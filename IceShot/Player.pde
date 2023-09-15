//Player class extends the functions of the MovingObject class
//this class takes care of updating the positon and movement of the playeer, as well as
//fires the player's bullets from the player's constantly moving position 
//if the player hits the enemies with their bullets, damage them
class Player extends MovingObject{
  boolean jump, playerAtEdge, shoot, fire;
  Tile tiles; 
  float scale;
  int lastFrame, direction, shootTimer, currentFrame;
  PImage shieldImg;
  char bulletC; 
  //char collide;
  String bulletType; 
  
  PImage[] walking = new PImage[6]; 
  
   /*
  final char L = 'L'; 
  final char R = 'r';
  final char T = 't'; */
  
  //different kinds of bullets
  final char B = 'b'; 
  //final char S = 's'; 
  final char M = 'm'; 
  
  ArrayList <Bullet> playerBullet = new ArrayList<Bullet>(); 
  
  //constructor
  //parameters: PVector(postition, velocity, dimension), PImage
  Player(PVector pos, PVector vel, PVector dim, PImage img){
    super(pos, vel, dim, img); 
    img.resize(60, 50); 
    jump = false; 
    playerAtEdge = false;
    tiles = null;
    scale = 0.1;
    lastFrame = -1; 
    
    shieldImg = loadImage("imgShield.png"); //Lee, K. (2021, July 26). player. [png]. Illustrator. 
    shieldImg.resize(45, 50);
    bulletC = 'x';
    //collide = T; 
    direction = 1; 
    shootTimer = 15; 
    shoot = false;
    currentFrame = 0;
    fire = false;
    
    //initlaize animation sequence
    for (int i = 0; i < walking.length; i++) {
      walking[i] = loadImage("WALKING-" + i + ".png");
      walking[i].resize(60, 50);
    }
  }
  
  //Yang, E. (2021, July 27). Lec 11 Tutorial. [Tutorial]. IAT167 Summmer 2021.
  //update the animation frames
  //parameters: none
  void updateFrame() {
    if (frameCounter %5 == 0){
        currentFrame++;
      }
      if (currentFrame == walking.length) {
        currentFrame = 0;
      }
      img = walking[currentFrame];
    
  }
  
 //check to see if the bullet hit anything and respond to scenerios
 //parameters: none
  void checkBullet(){
      //for every bullet in the ArrayList
     for(int i = 0; i < playerBullet.size(); i++){
      Bullet b = playerBullet.get(i); 
      b.updatePlayerBullet();      //update the movement and position
      b.drawBullet();  //draw the bullet
      b.hitWalls(b); 
      
      //take it out of the ArrayList
      if(!b.isAlive){
        playerBullet.remove(i);
        return;
      }
      
      //if the bullet hit the ebemy, remove it from the ArrayList
      for (int j = 0; j < enemies.size();j++){
        if (b.hitCharacter(enemies.get(j))){
          playerBullet.remove(i); 
          playSound(ENEMYHIT);    //play enemy hit sound
          if (bulletC != M){
            enemies.get(j).playerGlitch();
            enemies.get(j).health--;
          }
          else {
            enemies.get(j).playerGlitch();
            enemies.get(j).health -= 3;
          }
        }
        //println(enemies.get(j).health);
      }
      
     }
        
   }
  
  //shoot bullets
  //parameter: none
  void fireBullet(){
    //depends on bullet type
    if (bulletC == B) playerBullet.add(new Bullet(new PVector(pos.x, pos.y-10), new PVector(direction*10, 0), bulletRImg));
    //if (bulletC == S) playerBullet.add(new Bullet(new PVector(pos.x, pos.y-10), new PVector(direction*10, 0), bulletSImg ));
    if (bulletC == M) playerBullet.add(new Bullet(new PVector(pos.x, pos.y-10), new PVector(direction*10, 0), bulletMImg));
    
   }
  
  //check boundaries and edge of gameworld
  //parameters: none
  void checkWalls(){
    if (state != LEVEL_FOUR){  
      if (pos.x < width/4) {
        pos.x = width/4;    //left
        playerAtEdge = true;
      }
      else if (pos.x > (width/4)*3){
        pos.x = (width/4)*3;    //right
        playerAtEdge = true;
      }
      else playerAtEdge = false;
       //<>//
  }
  else{  //boundaries of level four
    if (pos.x <= 100)pos.x = 100;
    if (pos.x >= width-100)pos.x = width-100;
  }
}
    
  //Yang, E. (2021, July 20). Lec 10 Tutorial. [Tutorial]. IAT167 Summmer 2021.
  //parameters: none
  void jump(PVector upAcc) {
    move(upAcc);
    jump = true;
  }
  
  //player ends up ontop of tile 
  //parameters: tile
  void landOn(Tile t) {
    tiles = t;
    
    //if it is not a collecctiable, keep falling and return 
   if(t instanceof Gem || t instanceof Coins || t instanceof Health || t instanceof Shield || t instanceof Stone){
      jump = true; 
      return; 
    }
    
    //if it is a removable tile, remove the tile and fall
    if (t instanceof TileDelete){
      enviro.tiles.remove(t); 
      jump = true;
      return;
    }
    
    //if (collide == T || collide == B) pos.y = t.pos.y - dim.y /2 - t.dim.y / 2;  
    pos.y = t.pos.y - dim.y /2 - t.dim.y / 2;  
    jump = false; 
    vel.y = 0;
  }
  
  //let the player fall 
  //parameters: tile
  void fall(Tile t) {
    pos.y = t.pos.y + dim.y /2 + t.dim.y / 2; 
    vel.y *= -1;
  }
  
  //decrease health when in conctact 
  //parameters: none
  void playerCollision(){
    //decrease health by 1 for the first contact
   if (lastFrame == -1 && shield == false){
        health--;
        playerGlitch();
        playSound(HIT);
        lastFrame = frameCounter; 
    }
    
    //decrease the health by 1 for every contact after the first
    else if(frameCounter > lastFrame+2 && lastFrame != 0 && shield == false){
      lastFrame = frameCounter; 
      if (fire)health /= 2;
      else health--;
      playerGlitch();
      playSound(HIT);
      healthPercentage = (float)health/maxHealth;
      if (health <= 0) state = LOSE;
    }
    //lastFrame++;
    lastFrame+=2;
  }
  
  //updates everything that has to do with the playeer
  //responsible for callng methods related to playeer
   //parameters: none  
  void update(){
    vel.mult(damp); //multiply velocity by dampening factor (0.9-0.99);
    pos.add(vel); 
    drawPlayer(); 
    checkWalls();
    checkBullet();
    
    //can only shoot during intervals
    if (shootTimer > 0) shootTimer--; 
    updateBullet(); 
    updateFrame();
  }
  
   //updates everything that has to do with the player for the end screen
  //responsible for callng methods related to player for the end screen
   //parameters: none  
  void updateEnd(){
    updateFrame();
    drawPlayer();    
  }
  
  //different bullet types
   //parameters: none
  void updateBullet(){
    if (bulletC == B) bulletType = "Regular"; 
    else if (bulletC == M) bulletType = "Mega"; 
    //else if (bulletC == S) bulletType = "SpikeBom"; 
    else bulletType = "N/A"; 
  }
  
   //parameters: none
  void drawPlayer(){
    pushMatrix(); 
    translate(pos.x, pos.y); 
    scale(direction, 1);    //depends on which direction player is moving
    if (left || right || state == WIN) img = walking[currentFrame];    //walking animation
    else {
      img = playerImg;
    }
    image(img, -img.width/2, -img.height/2);
     //fill(255, 0, 0); 
     //rect(-img.width/2, -img.height/2, img.width, img.height);
     
    popMatrix(); 
  }
  
   //parameters: none
  void drawShield(){
    pushMatrix(); 
    translate(pos.x,pos.y);
    image(shieldImg, -shieldImg.width/2, -shieldImg.height/2); 
    popMatrix();  
  }
    
}

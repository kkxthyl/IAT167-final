//Enemy class extends the functions of the MovingObject class
//this class takes care of updating the positon and movement of the enemies, as well as
//fires the enemies bullets from the enemie's constantly moving position 
//if the enemy hits the player with their bullets, damage the player
class Enemy extends MovingObject{
   boolean rightFlag = true;     
   int direction; 
   
   ArrayList<Bullet> enemyBullets = new ArrayList <Bullet>();
   int health; 
   
   //constructor
   //parameters; PVector, PImage   
   Enemy(PVector pos, PVector vel, PVector dim, PImage img, int direction){
    super(pos, vel, dim, img); 
    health = 3;
    this.direction = direction; 
   }
   
  //updates everything that has to do with the enemies
  //responsible for callng methods related to enemies
   //parameters: none
   void update(){
     super.update();
     drawEnemy();
     checkBullet();
     
     if (check(player))player.playerCollision(); 
     healthCheck(); 
   }
 
 //if the enemy has no more life, remove it
 //parameter: none
 void healthCheck(){
   for (int i = 0; i < enemies.size(); i++){
     if (enemies.get(i).health <= 0) enemies.remove(i);
   }
 }
  
 //check to see if the bullet hit anything and respond to scenerios
 //parameters: none
 void checkBullet(){
   //enought time for player to dodge
   //depends on level
   if (frameCounter % 100 == 0 && state != LEVEL_FOUR) fireBullet();
   if (frameCounter % 60 == 0 && state == LEVEL_FOUR) fireBullet();
   
   //for every bullet in the ArrayList
   for(int i = 0; i < enemyBullets.size(); i++){
    Bullet b = enemyBullets.get(i); 
     //println(b.vel);
    b.update();      //update the movement and position
    b.drawBullet();  //draw the bullet
    //b.hitWalls(b); 
    
    hitWalls(b); 
    
    //if the bullet is dead, take it out of the ArrayList
    if(!b.isAlive){
      enemyBullets.remove(i);
    }
    
    //if the bullet hit the player, remove it from the ArrayList
    else if (b.hitCharacter(player)){
      enemyBullets.remove(i); 
      //decrease the player's health 
      if (shield == false){
        playSound(HIT);
        player.health--;
        player.playerGlitch();
        player.healthPercentage = (float)player.health/player.maxHealth;    //update the HUD
        if (player.health <= 0) state = LOSE;
      }
    }
   }
        
   }
  
  //detects if the bullet hit a wall; 
  //parameters: bullet 
  void hitWalls(Bullet b){
      
      //bullet goes a certain distance depending on level
      if (state == LEVEL_ONE)b.wall = this.pos.x+650;
      if (state == LEVEL_TWO)b.wall = this.pos.x+520;
      if (state == LEVEL_THREE)b.wall = this.pos.x-600;
    
   //if it goes past the limit, then isAlive is false, else true
    if (state != LEVEL_FOUR){
      if(b.pos.x >= b.wall && state != LEVEL_THREE){
            b.isAlive = false;
        }
        
        else if(b.pos.x <= b.wall && state == LEVEL_THREE){
          b.isAlive = false;
        }
    }
    else{
      if (b.pos.x > width+b.dim.x || b.pos.x < -b.dim.x) b.isAlive = false;
    }
  }
  
  //shoot bullets
  //parameter: none
   void fireBullet(){
     //shoot depending on level
     playSound(SHOOTE);
     if (state == LEVEL_THREE){
       /*for (int i = 0; i < enemies.size(); i++) {
         enemies.get(i).enemyBullets.add(new Bullet(new PVector(pos.x, pos.y), new PVector(-8, 0), enemyBulletImg));
       }*/
       this.enemyBullets.add(new Bullet(new PVector(pos.x-100, pos.y), new PVector(-8, 0), enemyBulletImg));
     }
     else {
       /*for (int i = 0; i < enemies.size(); i++) {
         enemies.get(i).enemyBullets.add(new Bullet(new PVector(pos.x, pos.y), new PVector(8, 0), enemyBulletImg));
         //println(i, enemies.get(i).direction);  
       }*/
       this.enemyBullets.add(new Bullet(new PVector(pos.x, pos.y), new PVector(8, 0), enemyBulletImg));
     }
     //println("fire");
 }
  
   
   //draw the enemy based from an image
   //parameters: none
   void drawEnemy(){
     pushMatrix(); 
     translate(pos.x, pos.y); 
     scale(direction, 1); 
     image(img,  -img.width/2*direction, -img.height/2 );
     //fill(255, 0, 0); 
     //rect(-img.width/2, -img.height/2, img.width, img.height);
     popMatrix(); 
     
   }
}

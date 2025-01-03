// Bullet class for the enemy and extends the functions of the MovingObjects calss
//this class draws the bullets, updates the movement and position throughout the game world, 
class Bullet extends MovingObject {
  boolean isAlive, fired;
  float wall;
  
  //constructor
  //parameters: PVector (position and velovity), PImage (image)
  Bullet(PVector pos, PVector vel,PImage img){
    super(pos, vel, new PVector(30, 20), img); 
    //img.resize(img.width/3, img.height/3);
    if (state == LEVEL_ONE)wall = pos.x+650;
    if (state == LEVEL_TWO)wall = pos.x+520;
    if (state == LEVEL_THREE)wall = pos.x-600;
    isAlive = true;    //the bullet has not hit any walls or characters 
  }
  
  //did the bullet hit any of the tiles/walls 
  //parameters: MovingObject (the object to check if it hit the wall)  
  void hitWalls(MovingObject b){
    for (int i = 0; i < enviro.tiles.size(); i++){
      Tile t = enviro.tiles.get(i);
      //if it is not a platform or ice, return
      
       if (t instanceof Gem || t instanceof Coins || t instanceof Health || t instanceof Shield) return;  
      //if the bullet collides with wall or ice
      println("checking");
      
      if (t.check(this)){  
        println("Collide");
         isAlive = false;       //remove the bullet
         //if ice, replace it with a platform
          /*if (t instanceof Ice && player.bulletC == player.S){
            t = new Tile(new PVector(enviro.TILE_SIZE, enviro.TILE_SIZE), new PVector(enviro.TILE_SIZE, enviro.TILE_SIZE), false);
            println("ice");
          }*/
      }
      //println("Checked");
    }
  }
  
  //if the bullet hit the character (enemy or player)
  //paraemeters: MovingObject
  boolean hitCharacter(MovingObject obj){
    if (abs(pos.x - obj.pos.x) < img.width/2 + obj.dim.x/2 && 
    abs(pos.y - obj.pos.y) < img.height/2 + obj.dim.y/2){  
      return true;
    }
    return false;
  }
 
 //update position of bullet
 //no parameters
  void move(){
    //change speed depending if bullet is going against or with scrolling 
    if (state == LEVEL_THREE){
      if (right) vel.x = -20; 
      else vel.x = -8; 
      
      println("here");
    }
     else if (state != LEVEL_THREE || state != LEVEL_FOUR){
      if (left)vel.x = 20; 
      else vel.x = 8; 
      //println("there");
    }
   
    pos.add(vel); 
    //println(pos, vel); 
  }
  
  
  //updates the position and state of the bullet
  //no parameters are needed
  void update(){
     move();
    //hitWalls(); 
  }
  
 //update position of bullet for the player
 //no parameters  
  void movePlayerBullet(){
    /*
    if (left && !fired){
     vel.x = player.direction*16; 
    }
    else if ({
     vel.x = player.direction*8; 
    }*/
    
    pos.add(vel); 
  }
  
  //updates the position and state of the bullet for the player
  //no parameters are needed  
  void updatePlayerBullet(){
     movePlayerBullet();
    //hitWalls(); 
  }
  
  //draw the bullet using an image
  //no parameters are needed
  void drawBullet(){
    pushMatrix(); 
    translate(pos.x, pos.y); 
    if (state != LEVEL_THREE)scale(-1, 1);
    else scale(1, 1);
    image(img, 0, 0); 
    
    //fill(0, 255, 0); 
    //rect(-dim.x/2, -dim.y/2, dim.x, dim.y);
    
    popMatrix(); 
  }
}

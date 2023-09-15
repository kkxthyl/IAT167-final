//superclass in charge of basic methods that all child classes extend from 
class MovingObject{
  PVector pos, vel, dim; 
  PImage img;
  float damp, healthPercentage;
  int health, maxHealth;
  
  //constructor
  MovingObject(PVector pos, PVector vel, PVector dim, PImage img){
    this.pos = pos;
    this.vel = vel; 
    this.img = img;
    this.dim = dim; 
    damp = 0.8;
    health = 10; 
    maxHealth = health;
    healthPercentage = 100;
  }

  //move method, PVector force as parameter, add to acceleration
  void move(PVector acc) {
    vel.add(acc);
  }
  
  //update the position of the MovingObject
  //parameters: none
  void update(){
     vel.mult(damp);  //stops the object from constantly moving
    pos.add(vel);  
  }
  
  //if the object collided with the parameter
  //parameter: MobingObject
  boolean check(MovingObject obj){
    if (abs(pos.x - obj.pos.x) < img.width/2 + obj.dim.x/2 && 
    abs(pos.y - obj.pos.y) < img.height/2 + obj.dim.y/2){   
      return true;
    }
    return false;
  }
    
  //if the object was hit show red
  //parameters: none
  void playerGlitch(){
    pushMatrix();
    translate(pos.x, pos.y-20);
    scale(player.direction, 1);
    //depends on which way they are facing
    if(vel.x >= 0)scale(-1, 1); 
    image(playerGlitch,  -playerGlitch.width/2, -playerGlitch.height/2);
    popMatrix();
  }
  
}

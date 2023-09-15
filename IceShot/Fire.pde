//Fire extends functions of tile, part of the mapping
//if player collides with fire, health decreases by half
class Fire extends Tile{
  PImage img; 
  PImage[] fire = new PImage[4];  //animation image sequence
  int currentFrame;
  
  //constructor
  //parameters: PVectors position, dimension
  Fire(PVector pos, PVector dim){
    super(pos, dim, false); 
    currentFrame = 0; 
    
    //load image seequence
    //Yang, E. (2021, July 27). Lec 11 Tutorial. [Tutorial]. IAT167 Summmer 2021.
    for (int i = 0; i < fire.length; i++) {
      fire[i] = loadImage("FIRE-" + i + ".png");      
      fire[i].resize(int(dim.x), int(dim.y));        
      //Lee, K. (2021, Aug 2). FIRE. [png]. Illustrator. modified from 
      //https://www.dreamstime.com/
      //there was a redirect notice from google for visiting this site so I did not click on it due to chances of getting a virus
      //the image came from google which came from that link
       //i did not deseign the fire artwork, only modified
    }
  }
  
  //if the playere collides with the fire, reduce health 
  //parameters: MovingObject
  boolean check(MovingObject c){
    fill(255); 
    if (abs(c.pos.x - (pos.x-c.pos.x)) < c.dim.x / 2 + dim.x / 2 &&
    abs(c.pos.y - pos.y) < c.dim.y / 2 + dim.y / 2){
      player.fire = true; 
      player.playerCollision();
      player.fire = false;
      return true;
    }
   return false;
  }
  
  //parameter: PVector
  void move(PVector acc){
    vel.add(acc);
  }
  
  
  //updates everything that has to do with the fire
  //responsible for callng methods related to fire
  //Parameter: Player
  void update(Player c){
    vel.mult(damp); //stop moving if key not pressed
    pos.add(vel);  
    drawMe(c);
    
    //animation frames and rate
   if (frameCounter % 2 == 0) {
      currentFrame++;
    }
    if (currentFrame == fire.length) {
      currentFrame = 0;
    }
  }
  
  //paramter: player
  void drawMe(Player c){
    pushMatrix(); 
    translate(-c.pos.x+pos.x, pos.y);
    //go through the image sequence
    PImage img = fire[currentFrame];
    image(img, -dim.x/2, -dim.y/2); 
    popMatrix(); 
  }
}

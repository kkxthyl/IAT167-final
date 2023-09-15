//Gem extends functions of tile, part of the mapping
//player can collect gems when collided with image on screen 
//neeed X gems to level up to next level
class Gem extends Tile{
  PImage[] gemRot = new PImage[8]; 
  int currentFrame;
  
  //constructor
  //parameters: PVectors position, dimension
  Gem(PVector pos, PVector dim){
    super(pos, dim, false); 
    
    //load image seequence
    //Yang, E. (2021, July 27). Lec 11 Tutorial. [Tutorial]. IAT167 Summmer 2021.
    for (int i = 0; i < gemRot.length; i++) {
      gemRot[i] = loadImage("GEM-" + i + ".png");      //Lee, K. (2021, Aug 2). GEM. [png]. Illustrator. 
      gemRot[i].resize(int(dim.x), int(dim.y));
    }
    currentFrame = 0; 
  }
  
  //if the playere collides with the gem, remove and add to gem count
  //parameters: MovingObject
  boolean check(MovingObject c){
    if (abs(c.pos.x - (pos.x-c.pos.x)) < c.dim.x / 2 + dim.x / 2 &&
    abs(c.pos.y - pos.y) < c.dim.y / 2 + dim.y / 2){
      //if collided, remove
      playSound(GEM);     //play gem sound
      enviro.tiles.remove(this); 
      gemCount++; 
      return true;
    }
   return false;
  }
  
   //parameter: PVector (acceleration) 
  void move(PVector acc){
    vel.add(acc);
  }
  
  //updates everything that has to do with the gems
  //responsible for callng methods related to gems
  //Parameter: Player
  void update(Player c){
    vel.mult(damp); //stop moving if key not pressed
    pos.add(vel);  
    drawMe(c);
    
    //animation frames and rate
   if (frameCounter % 2 == 0) {
      currentFrame++;
    }
    if (currentFrame == gemRot.length) {
      currentFrame = 0;
    }
  }
  
  //paramter: player
  void drawMe(Player c){
    pushMatrix(); 
    translate(-c.pos.x+pos.x, pos.y);
    //go through the image sequence
    PImage img = gemRot[currentFrame];
    image(img, -dim.x/2, -dim.y/2); 
    popMatrix(); 
  }
  
  //draw the gem for the final screen when the player wins
  //paramter: none
  void drawMe(){
    //animation rate / frame update
    if (frameCounter % 2 == 0) {
      currentFrame++;
      println("increaase", frameCounter);
    }
    if (currentFrame == gemRot.length) {
      currentFrame = 0;
    }
    
    pushMatrix(); 
    translate(pos.x, pos.y);
    //go through the image sequence
    PImage img = gemRot[currentFrame];
    img.resize(250, 250);
    image(img, -dim.x/2, -dim.y/2); 
    popMatrix();     
  }

}

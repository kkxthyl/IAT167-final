//Stone extends functions of tile, part of the mapping
//player can collect the stone to release the hidden gem
class Stone extends Tile{
  PImage[] stoneRot = new PImage[8]; 
  int currentFrame;
  
  //constructor
  //parameters: PVectors position, dimension
  Stone(PVector pos, PVector dim){
    super(pos, dim, false); 
    
    //load image sequence
    //Yang, E. (2021, July 27). Lec 11 Tutorial. [Tutorial]. IAT167 Summmer 2021.
    for (int i = 0; i < stoneRot.length; i++) {
      stoneRot[i] = loadImage("STONE-" + i + ".png");      //Lee, K. (2021, Aug 8). STONE. [png]. Illustrator. 
      stoneRot[i].resize(int(dim.x), int(dim.y));
    }
  }
  
  //if the playere collides with the stone, remove and remove two tiles to allow access to gem
  //parameters: MovingObject
  boolean check(MovingObject c){
    if (abs(c.pos.x - (pos.x-c.pos.x)) < c.dim.x / 2 + dim.x / 2 &&
    abs(c.pos.y - pos.y) < c.dim.y / 2 + dim.y / 2){
      //if collided, remove
      playSound(GEM);     //play gem sound
      for (int i = 0; i < enviro.tiles.size(); i++){
        if (enviro.tiles.get(i).wallFlag) enviro.tiles.remove(i);
      }
      enviro.tiles.remove(this); 
      return true;
    }
   return false;
  }
  
  //parameter: PVector (acceleration) 
  void move(PVector acc){
    vel.add(acc);
  }
  
  
  //updates everything that has to do with the stone
  //responsible for callng methods related to stone
   //parameters: player
  void update(Player c){
    vel.mult(damp); //stop moving if key not pressed
    pos.add(vel);  
    drawMe(c);
    
    //animation frames and rate
   if (frameCounter % 2 == 0) {
      currentFrame++;
    }
    if (currentFrame == stoneRot.length) {
      currentFrame = 0;
    }
  }
  
  //parameters: player
  void drawMe(Player c){
    pushMatrix(); 
    translate(-c.pos.x+pos.x, pos.y);
    //go through the image sequence
    PImage img = stoneRot[currentFrame];
    image(img, -dim.x/2, -dim.y/2); 
    popMatrix(); 
  }
}

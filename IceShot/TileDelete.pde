//TileDelete extends functions of tile, part of the mapping
//player health is damaged if collides with ice 

class TileDelete extends Tile{
  PImage img; 
  
  //constructor
  //parameters: PVectors position, dimension
  TileDelete(PVector pos, PVector dim){
    super(pos, dim, false); 
    img = loadImage("tileDelete.png"); //Lee, K. (2021, July 17). tileDelete. [png]. Illustrator. 
    img.resize(int(dim.x), int(dim.y));
  }
  
  //parameter: PVector (acceleration) 
  void move(PVector acc){
    vel.add(acc);
  }
  
  //updates everything that has to do with the TileDelete
  //responsible for callng methods related to TileDelete
  //parameters: player
  void update(Player c){
    vel.mult(damp); //stop moving if key not pressed
    pos.add(vel);  
    drawMe(c);
  }

   //parameters: player
  void drawMe(Player c){
    pushMatrix(); 
    translate(-c.pos.x+pos.x, pos.y);
    image(img, -dim.x/2, -dim.y/2); 
    popMatrix(); 
  }
}

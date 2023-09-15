//Ice extends functions of tile, part of the mapping
//player health is damaged if collides with ice 

class Ice extends Tile{
  PImage img; 
  
  //constructor
  //parameters: PVectors position, dimension
  Ice(PVector pos, PVector dim){
    super(pos, dim, false); 
    img = loadImage("ice.png"); //Lee, K. (2021, July 17). ice. [png]. Illustrator. 
    img.resize(int(dim.x), int(dim.y));
  }
  
  //if the playere collides with the ice, decrease player health by one
  //parameters: MovingObject
  boolean check(MovingObject c){
    if (abs(c.pos.x - (pos.x-c.pos.x)) < c.dim.x / 2 + dim.x / 2 &&
    abs(c.pos.y - pos.y) < c.dim.y / 2 + dim.y / 2){
      player.playerCollision();
      return true;
    }
   return false;
  }
 
  //parameter: PVector (acceleration) 
  void move(PVector acc){
    vel.add(acc);
  }

  //updates everything that has to do with the ice
  //responsible for callng methods related to ice
  //parameters: player
  void update(Player c){
    vel.mult(damp); //stop moving if key not pressed
    pos.add(vel);  
    drawMe(c);
  }
  
  //parameter: player
  void drawMe(Player c){
    pushMatrix(); 
    translate(-c.pos.x+pos.x, pos.y);
    image(img, -dim.x/2, -dim.y/2); 
    popMatrix(); 
  }
}

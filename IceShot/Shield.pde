//Shield extends functions of tile, part of the mapping
//player can collect Shield when collided with image on screen 
//shield lets player not be damaged by anything and has time limit shown by meter

class Shield extends Tile{
  PImage img; 
  
  //constructor
  //parameters: PVectors position, dimension
  Shield(PVector pos, PVector dim){
    super(pos, dim, false); 
    img = loadImage("shield-09.png"); //Lee, K. (2021, July 26). shield. [png]. Illustrator. 
    img.resize(int(dim.x), int(dim.y));
    
  }
    
  //if the playere collides with the shield, remove and add the shield portection
  //parameters: MovingObject
  boolean check(MovingObject c){
    if (abs(c.pos.x - (pos.x-c.pos.x)) < c.dim.x / 2 + dim.x / 2 &&
    abs(c.pos.y - pos.y) < c.dim.y / 2 + dim.y / 2){
      //if collided, remove
      playSound(SHIELD);
      enviro.tiles.remove(this); 
      shield = true;  //activate shield
      return true;
    }
   return false;
  }
  
  //parameter: PVector (acceleration) 
  void move(PVector acc){
    vel.add(acc);
  }

  
  //updates everything that has to do with the shield
  //responsible for callng methods related to shield
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

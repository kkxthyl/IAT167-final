//Health extends functions of tile, part of the mapping
//player can collect health when collided with image on screen 

class Health extends Tile{
  PImage img; 
  
  //constructor
  //parameters: PVectors position, dimension
  Health(PVector pos, PVector dim){
    super(pos, dim, false); 
    img = loadImage("health.png"); //Lee, K. (2021, July 17). health. [png]. Illustrator. 
    img.resize(int(dim.x), int(dim.y));
  }
  
  //if the playere collides with the health boost, remove and add to health count
  //parameters: MovingObject
  boolean check(MovingObject c){
    if (abs(c.pos.x - (pos.x-c.pos.x)) < c.dim.x / 2 + dim.x / 2 &&
    abs(c.pos.y - pos.y) < c.dim.y / 2 + dim.y / 2){
      //if collided, remove
      enviro.tiles.remove(this); 
      playSound(HEALTH);    //play health sound
      if (player.health < player.maxHealth) player.health++;
      return true;
    }
   return false;
  }
  
  //parameter: PVector (acceleration) 
  void move(PVector acc){
    vel.add(acc);
  }
  
  //updates everything that has to do with the health
  //responsible for callng methods related to health
  //parameters: player
  void update(Player c){
    vel.mult(damp); //stop moving if key not pressed
    pos.add(vel);  
    drawMe(c);
  }
  
  //paramter: player
  void drawMe(Player c){
    pushMatrix(); 
    translate(-c.pos.x+pos.x, pos.y);
    image(img, -dim.x/2, -dim.y/2); 
    popMatrix(); 
  }
}

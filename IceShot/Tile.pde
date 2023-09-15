//tiles class is superclass for other obstcales/boosts/rewards in the map
//platforms
//Yang, E. (2021, July 20). Week 10 Tutorial. [Lecture]. IAT167 Summmer 2021.
class Tile {
  boolean wallFlag = false; 
  PImage tileImageOne, tileImageTwo, tileImageThree, tileImageFour; 
  float damp = 0.8;
  PVector pos, dim, vel;
  
  //constructor
  //parameters: PVecctor (position, dimension), boolean(which tile should be removed in the middle of gameplay)
  Tile(PVector pos, PVector dim, boolean wallFlag) {
      this.pos = pos;
      this.dim = dim;
      vel = new PVector(); 
      
      tileImageOne = loadImage("tile.png");//Lee, K. (2021, July 26). tile. [png]. Illustrator. 
      tileImageOne.resize(int(dim.x), int(dim.y));
        
      tileImageTwo = loadImage("tile2.png");//Lee, K. (2021, Aug 1). tile2. [png]. Illustrator. 
      tileImageTwo.resize(int(dim.x), int(dim.y));  
      
      tileImageThree = loadImage("tile3.png");//Lee, K. (2021, Aug 1). tile3. [png]. Illustrator. 
      tileImageThree.resize(int(dim.x), int(dim.y));       
      
      tileImageFour = loadImage("tile4.png");//Lee, K. (2021, Aug 1). tile3. [png]. Illustrator. 
      tileImageFour.resize(int(dim.x), int(dim.y));        
      this.wallFlag = wallFlag; 
      
      
  }
  
  //if the player ontop of a tile for scrolling
  //parameters: player
  boolean isOn(Player c) {

    if (abs(c.pos.x - (pos.x-c.pos.x)) < c.dim.x / 2 + dim.x / 2) {
      return true;
    }
    return false;
  }
  
  //is the player ontop of the tile for a nonscrolling
  //parameters: player
  boolean isOnStatic(MovingObject c) {
      if (abs(c.pos.x - pos.x) < c.dim.x / 2 + dim.x / 2) {
          return true;
      }
      return false;
    }
  
  //did the player collide with one of the tiles, scrolling
  //parameter: MovingObject
  boolean check(MovingObject c) {
    if (abs(c.pos.x - (pos.x-c.pos.x)) < c.dim.x / 2 + dim.x / 2  &&
      abs(c.pos.y - pos.y) < c.dim.y / 2 + dim.y / 2) { 
        
      //which edge did it collide with 
      
      //println(player.collide); 
      /*
      if(c == player){
        if (c.pos.y == pos.y && (c.pos.x) > (pos.x-c.pos.x)) {
          //c.pos.x += 15;
          player.collide = player.R;
        }
        else if (c.pos.y == pos.y && (c.pos.x) < (pos.x-c.pos.x)){
          player.collide = player.L;
          //c.pos.x -= 15; 
        }
        else if (c.pos.y > pos.y) player.collide =player.T;
        else player.collide = player.B;
      }*/
      //println("COLLIDE");
      return true;
    }
    return false;
  }

  //did the player collide with the tile, non scrolling
  //parameter: MovingObject
  boolean checkStatic(MovingObject c) {
    if (abs(c.pos.x - pos.x) < c.dim.x / 2 + dim.x / 2 &&
        abs(c.pos.y - pos.y) < c.dim.y / 2 + dim.y / 2) {
        return true;
    }
    return false;
  }
  
  //parameter: PVector (acceleration) 
  void move(PVector acc){
    vel.add(acc);
  }

  
  //updates everything that has to do with the tiles
  //responsible for callng methods related to tiles
  //parameters: player
  void update(Player c){
    if (state != LEVEL_FOUR){
      vel.mult(damp); //stop moving if key not pressed
      pos.add(vel); 
  }
    drawMe(c);
  }
  
  //parameters: player
  void drawMe(Player c){
    
    pushMatrix();
    if (state != LEVEL_FOUR) translate(-c.pos.x+pos.x, pos.y);
    else translate(pos.x, pos.y);
    
    //tiles depending on level
    if (state == LEVEL_ONE) image(tileImageOne, -dim.x/2, -dim.y/2); 
    else if (state == LEVEL_TWO) image(tileImageTwo, -dim.x/2, -dim.y/2); 
    else if (state == LEVEL_THREE) image(tileImageThree, -dim.x/2, -dim.y/2); 
    else if (state == LEVEL_FOUR) image(tileImageFour, -dim.x/2, -dim.y/2); 
    
      //fill(255, 0, 0); 
      //rect(-dim.x/2, -dim.y/2, dim.x, dim.y);
    popMatrix();
  }
}

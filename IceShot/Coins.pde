//Coins extends functions of tile, part of the mapping
//player can collect coins when collided with image on screen 
//collect coins to buy bullets from the store
class Coins extends Tile{
  PImage img; 
  PImage[] coinRot = new PImage[34];  //animation image sequence
  int currentFrame;
  
  //constructor
  //parameters: PVectors (position and dimenion)
  Coins(PVector pos, PVector dim){
    super(pos, dim, false); 
    //img = loadImage("coin.png"); //Lee, K. (2021, July 17). coin. [png]. Illustrator. 
    //img.resize(int(dim.x), int(dim.y));
    currentFrame = 0; 
    
    //load image sequence
    //Yang, E. (2021, July 27). Lec 11 Tutorial. [Tutorial]. IAT167 Summmer 2021.
    for (int i = 0; i < coinRot.length; i++) {
      coinRot[i] = loadImage("COINS-" + i + ".png");      //Lee, K. (2021, Aug 2). COINS. [png]. Illustrator. 
      coinRot[i].resize(int(dim.x), int(dim.y));
    }
  }
  
  //if the playere collides with the coin, remove and add to coin count
  //parameters: MovingObject
  boolean check(MovingObject c){
    fill(255); 
    if (abs(c.pos.x - (pos.x-c.pos.x)) < c.dim.x / 2 + dim.x / 2 &&
    abs(c.pos.y - pos.y) < c.dim.y / 2 + dim.y / 2){
      //if collided, remove
      playSound(COINS);    //play coin sound
      enviro.tiles.remove(this); 
      coins++; 
      return true;
    }
   return false;
  }
  
  //parameter: PVector (acceleration) 
  void move(PVector acc){
    vel.add(acc);
  }
  
  //updates everything that has to do with the coins
  //responsible for callng methods related to coins
  //Parameter: Player
  void update(Player c){
    vel.mult(damp); //stop moving if key not pressed
    pos.add(vel);  
    drawMe(c);
    
    //animation frames and rate
   if (frameCounter % 2 == 0) {
      currentFrame++;
    }
    if (currentFrame == coinRot.length) {
      currentFrame = 0;
    }
  }
  
  //paramter: player
  void drawMe(Player c){
    pushMatrix(); 
    translate(-c.pos.x+pos.x, pos.y);
    //go through the image sequence
    PImage img = coinRot[currentFrame];
    image(img, -dim.x/2, -dim.y/2); 
    popMatrix(); 
  }
}

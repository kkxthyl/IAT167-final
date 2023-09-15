//creats the game world / map
class Environment {
  PImage backgroundOne, backgroundTwo, backgroundThree, backgroundFour, backgroundEnd; 
  
  static final int TILE_EMPTY = 0;  
  static final int TILE_SOLID = 1;
  static final int TILE_GEM = 2; 
  static final int TILE_COIN = 3; 
  static final int TILE_ICE = 4;
  static final int TILE_HEALTH = 5;
  static final int TILE_SHIELD = 6;
  static final int TILE_FIRE = 7; 
  static final int TILE_STONE = 8; 
  static final int TILE_DELETE = 9; 
  
  static final int TILE_SIZE = 45; 
  static final int GEM_SIZE = 40; 
  static final int COIN_SIZE = 30;
  static final int ICE_SIZE = 45;
  static final int HEALTH_SIZE = 35;
  static final int SHIELD_SIZE = 40;
  static final int FIRE_SIZE = 45;
  static final int STONE_SIZE = 40;
  
  boolean xCopy = false;
  
  int level =1 ;
  
  ArrayList<Tile> tiles = new ArrayList<Tile>(); 
  ArrayList<Tile> tilesLvlTwo = new ArrayList<Tile>(); 
  ArrayList<Tile> tilesLvlThree = new ArrayList<Tile>(); 
  ArrayList<Tile> tilesLvlFour = new ArrayList<Tile>(); 
   
  //level one
  int [][] map = {
    
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 0, 5, 0, 0, 0, 0, 0, 3, 3, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0},
  {1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 3, 3, 0, 1, 2, 0, 4, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 3, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 5, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 4, 0, 3, 3},
  {1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 0, 1, 1, 1, 1, 1},
  {1, 0, 0, 3, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 1, 1, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {1, 0, 0, 3, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {1, 0, 0, 5, 0, 1, 0, 2, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 4, 0, 0, 0, 4, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 3, 3, 0},
  {1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 0},
  {1, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 3, 3, 0, 1, 0, 1, 0, 3, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 4, 0, 0, 0, 0},
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},         
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 0, 0, 0, 0, 0, 0, 1, 1, 1, 4},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {1,1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},          
  };
  
  //level two
 int [][] mapTwo = {
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 0, 0, 0, 1, 2, 0, 0, 0, 0, 3, 1, 0, 0, 0, 0, 0, 5, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0, 0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 3, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},
  {1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 7, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 3, 3, 3, 3, 3, 0, 0, 0, 1, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 5, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 7, 1, 1},
  {1, 4, 0, 2, 0, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 7, 7, 1, 3, 0, 0, 5, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 0, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 2, 0, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
  {1, 4, 0, 0, 0, 4, 0, 2, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 3, 3, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 3, 3, 1},
  {1, 1, 0, 6, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 1, 0, 0, 0, 0, 1, 0, 0, 0, 4, 1, 1, 0, 2, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 3, 0, 0, 0, 7, 0, 0, 0, 0, 1},
  {1, 1, 1, 0, 0, 0, 0, 0, 0, 5, 0, 3, 3, 3, 3, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 3, 3, 1, 0, 0, 0, 3, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 1, 1, 0, 0, 3, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},         
  {1, 0, 0, 0, 0, 3, 3, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 6, 0, 0, 0, 1, 1, 1, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0},
  {1, 7, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1},
  {1, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 0, 1},
  {1, 1, 3, 3, 1, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 3, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 0, 3, 3, 3, 0, 0, 0, 4, 1, 1, 1, 0, 0, 0, 0, 2, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},          
  };
 
  //level three
   int [][] mapThree = {//2-3, 28
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 2, 1},
  {1, 0, 0, 3, 3, 0, 0, 0, 0, 2, 0, 0, 0, 1, 1, 3, 0, 2, 1, 1, 0, 0, 3, 5, 0, 1, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 5, 0, 0, 0, 0, 1},
  {1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 9, 1, 1, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 3, 1, 1, 1, 1, 0, 0, 1},
  {1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 4, 0, 5, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 4, 1, 9, 0, 2, 0, 0, 0, 0, 1, 9, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1},
  {1, 7, 2, 1, 0, 8, 1, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 5, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 2, 0, 0, 1, 0, 1, 1},
  {1, 1, 1, 1, 1, 9, 1, 1, 1, 0, 0, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 6, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1},
  {1, 0, 3, 3, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 0, 1, 7, 0, 1, 1, 0, 0, 0, 0, 1, 3, 0, 1},
  {1, 4, 0, 0, 0, 4, 0, 2, 1, 5, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 3, 1, 0, 2, 0, 1, 1, 1, 0, 0, 0, 0, 0, 3, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 2, 1, 3, 0, 1},
  {1, 1, 0, 6, 0, 0, 0, 0, 1, 1, 4, 0, 1, 5, 0, 0, 0, 7, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 6, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1},
  {1, 1, 1, 1, 0, 0, 1, 9, 1, 1, 1, 1, 1, 3, 3, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1},
  {1, 0, 0, 1, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 5, 0, 0, 7, 0, 0, 0, 0, 0, 3, 0, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1},         
  {1, 0, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9, 1, 1, 1, 0, 3, 3, 0, 1, 0, 3, 3, 0, 4, 4, 1, 0, 0, 0, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 3, 0, 0, 0, 2, 0, 0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
  {1, 0, 3, 3, 3, 0, 0, 0, 7, 0, 3, 3, 3, 3, 0, 7, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},          
  };

    //level four
   int [][] mapFour = {//2-3, 28
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},          
  };
  
  //constructor
  //parameters: none
  Environment(){
    //different backgrounds depending on level
    backgroundOne = loadImage("background-74.png"); //Lee, K. (2021, July 17). background. [png]. Illustrator. 
    backgroundOne.resize(1100, 900);  

    backgroundTwo = loadImage("background2-74.png"); //Lee, K. (2021, Aug 2). background2. [png]. Illustrator. 
    backgroundTwo.resize(1100, 900);  
    
    backgroundThree = loadImage("backgroud3-74.png"); //Lee, K. (2021, Aug 2). background3. [png]. Illustrator. 
    backgroundThree.resize(1100, 900);  

    backgroundFour = loadImage("background4.png"); //Lee, K. (2021, Aug 2). background3. [png]. Illustrator. 
    backgroundFour.resize(1100, 900);  

    backgroundEnd = loadImage("background5.png"); //Lee, K. (2021, Aug 8). background3. [png]. Illustrator. 
    backgroundEnd.resize(1100, 900);  
    
    //initalize the ArrayList for tiles
    initializeMap(map, tiles);
    level = 2; 
    initializeMap(mapTwo, tilesLvlTwo);
    level = 3;
    initializeMap(mapThree, tilesLvlThree);
    level = 4;
    initializeMap(mapFour, tilesLvlFour);
    level = 2;
   
  }
  
  //update map positions and tiles
  //parameters: none
  void update(Player c){
    drawBackground();
    
    for (int i = 0; i < tiles.size(); i++){
        Tile t = tiles.get(i); 
        
        /*
        if (i == 327 && !xCopy){
          enemies.get(0).boundR = t.pos; 
          println(t.pos);
        }
        
        if (i == 328 && !xCopy) {
          enemies.get(0).boundL = t.pos; 
          xCopy = true;
          println(t.pos);
        }*/
        
        //stop scrolling if the player at the end of the game world
        if (state != LEVEL_FOUR){
          //println(enviro.tilesLvlOne.get(0).pos.x);
          //set boundaries / edges of map
          if (enviro.tiles.get(0).pos.x >= 465) rightAccE.x = 0;
          else if (enviro.tiles.get(0).pos.x <= -1750)leftAccE.x = 0;   
          else{
            leftAccE.x =-speed*2; 
            rightAccE.x = speed*2;
          }
          
          //if the player is at its limit, change the speed of scrolling
          if (player.playerAtEdge){
            if(left) t.move(rightAccE);
            if(right)t.move(leftAccE);
          }
          else{
            if(left)t.move(rightAcc);
            if(right) t.move(leftAcc);
          }
        }
        
        /*
       if (t instanceof Coins || t instanceof Fire || t instanceof Gem || t instanceof Health || t instanceof Shield || t instanceof Stone);
       else{ 
        for (int j = 0; j < enemies.size(); j++){
           for (int k = 0; k < enemies.get(j).enemyBullets.size(); k++){
             if (t.check( enemies.get(j).enemyBullets.get(k))){
                enemies.get(j).enemyBullets.get(k).isAlive = false;
                println("remove");
             }
           }
         }
       }*/
       
       
         t.update(c);
      }
      
    drawHud();
  }
  
  //draw the mountain background 
  //depends on level
  //parameters: none
  void drawBackground(){
    pushMatrix(); 
    //based on level
    if (state == LEVEL_ONE)image(backgroundOne, 0, 0);
    else if (state == LEVEL_TWO)image(backgroundTwo, 0, 0);
    else if (state == LEVEL_THREE)image(backgroundThree, 0, 0);
    else if (state == LEVEL_FOUR)image(backgroundFour, 0, 0);
    popMatrix();
  }
  
  //draw the HUD
  //shows health, bullet type, gem and coin collection
  //parameters: none
  void drawHud(){
    pushMatrix(); 
    translate(30, height-50); 
    textAlign(LEFT); 
    fill(255);
    textSize(20); 
    text("Health meter:                                           " + 
         "Bullet Type:   " + player.bulletType + "                               " + 
         "Coins:  " + coins + "           "+
         "Gems:  " + gemCount + "/"+gemMax , 0, 0);
    popMatrix();
    
    drawHealthMeter();
    if (shield == true) drawShieldMeter(); 
    
  }
  
  //Yang, E. (2021, July 6). Week 8 Tutorial. [Lecture]. IAT167 Summmer 2021.
  //draw the shield meter to reflect how long the boost lasts
  //parameters: none
  void drawShieldMeter(){
    int max = 200; 
    pushMatrix(); 
    translate(40, 40); 
    noStroke();
    
    //update the decreasing bar
    shieldPercent = (float)shieldTimer/shieldMax;
    
    fill(0, 0, 0);
    rect(0, 0, max, 30); 
    
    fill(134, 187, 209);
    rect(0, 0, max*shieldPercent, 30); 
    
    fill(255); 
    textAlign(LEFT);
    textSize(15);
    text("Shield Meter: ", 0, 50);
    popMatrix();
  }
  
  //Yang, E. (2021, July 6). Week 8 Tutorial. [Lecture]. IAT167 Summmer 2021.
  //draw the shield meter to reflect how long the boost lasts
  //parameters: none
  void drawHealthMeter(){
    int max = 200; 
    pushMatrix(); 
    translate(180, height-75); 
    noStroke(); 
    
    //update the decreasing bar
    player.healthPercentage = (float)player.health/player.maxHealth;
    
    fill(0, 0, 0);
    rect(0, 0, max, 30); 
    
    fill(50, 168, 82);
    rect(0, 0, max*player.healthPercentage, 30); 
    
    popMatrix();
  }
  
  //Yang, E. (2021, July 27). Week 10 Tutorial. [Lecture]. IAT167 Summmer 2021.
  //load the tiles into an array for use
  //parameters: 2d array(map for specific level), ArrayList (for specific level)
  void initializeMap(int[][] map, ArrayList list){
    
    for(int i = 0; i < map.length; i++){
      for(int j = 0; j < map[i].length; j++){
        switch(map[i][j]){
          case TILE_SOLID:     //tile
            //need to keep track of the trap door tile
            if (level == 3){
              if (j == 28 && (i == 2 || i == 3)) list.add(new Tile(new PVector(j*TILE_SIZE, i*TILE_SIZE), new PVector(TILE_SIZE, TILE_SIZE), true));
               else list.add(new Tile(new PVector(j*TILE_SIZE, i*TILE_SIZE), new PVector(TILE_SIZE, TILE_SIZE), false)); 
            }
            
            else list.add(new Tile(new PVector(j*TILE_SIZE, i*TILE_SIZE), new PVector(TILE_SIZE, TILE_SIZE), false));
            break;  
            
          case TILE_GEM:      //gem
            list.add(new Gem(new PVector(j*TILE_SIZE, i*TILE_SIZE), new PVector(GEM_SIZE, GEM_SIZE))); 
            //total gems in each level
            if (level == 1)gemMax++;
            else if (level == 2) gemMaxTwo++;
            else if (level == 3) gemMaxThree++;
            
            break;
            
          case TILE_COIN:   //coins
            list.add(new Coins(new PVector(j*TILE_SIZE, i*TILE_SIZE), new PVector(COIN_SIZE, COIN_SIZE))); 
            break;    
           
          case TILE_ICE:   //ice (danger)
            list.add(new Ice(new PVector(j*TILE_SIZE, i*TILE_SIZE), new PVector(ICE_SIZE, ICE_SIZE))); 
            break;
            
          case TILE_HEALTH:   //health boost
            list.add(new Health (new PVector(j*TILE_SIZE, i*TILE_SIZE), new PVector(HEALTH_SIZE, HEALTH_SIZE))); 
            break;  
            
          case TILE_SHIELD:   //shield boost
            list.add(new Shield(new PVector(j*TILE_SIZE, i*TILE_SIZE), new PVector(SHIELD_SIZE, SHIELD_SIZE))); 
            break;
                
          case TILE_FIRE:     //fire (danger)
            list.add(new Fire(new PVector(j*TILE_SIZE, i*TILE_SIZE), new PVector(FIRE_SIZE, FIRE_SIZE))); 
            break;
  
          case TILE_STONE:     //stone (release trap door)
            list.add(new Stone(new PVector(j*TILE_SIZE, i*TILE_SIZE), new PVector(STONE_SIZE, STONE_SIZE))); 
            break;

          case TILE_DELETE:   //removable tiles 
            list.add(new TileDelete(new PVector(j*TILE_SIZE, i*TILE_SIZE), new PVector(TILE_SIZE, TILE_SIZE))); 
            break;
            
          default: 
            break; 
        }
      }
    
    }
  }
}

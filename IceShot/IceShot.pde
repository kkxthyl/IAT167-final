
  //images are made by me, Kathy Lee, using adobe illustrator 
  
  
import ddf.minim.*;

Player player; 
Environment enviro;

int state; 
final static int INTRO_ONE = 0; 
final static int INTRO_TWO = 1; 
final static int INTRO_THREE = 2; 
final static int INTRO_FOUR = 3; 
final static int LEVEL_ONE = 4; 
final static int LEVEL_TWO = 5; 
final static int LEVEL_THREE = 6; 
final static int LEVEL_FOUR = 7; 

final static int STORE = 8; 

final static int LOSE = -1; 
final static int WIN = 9;


final String BG = "backgroundMusic.mp3"; //Punk, D. (2019). Solar Sailr [Song]. TRON: Legacy [score]. Walt Disney Records.
final String SHOOTE = "enemyShoot.wav";   //Quick jump arcade gamee [wav]. mixkit. envato elements.https://mixkit.co/free-sound-effects/game/
final String GEM = "gemAudio.wav"; //Bonus earned in video game [wav]. mixkit. envato elements. https://mixkit.co/free-sound-effects/game/
final String HEALTH = "healthAudio.wav"; //Game ball tap [wav]. mixkit. envato elements. https://mixkit.co/free-sound-effects/game/?page=2
final String PURCHASE = "purchase.wav"; //Casino bling achievement [wav]. mixkit. envato elements. https://mixkit.co/free-sound-effects/game/?page=2
final String COINS = "coins.wav"; //Unlock game notification [wav]. mixkit. envato elements. https://mixkit.co/free-sound-effects/game/
final String HIT = "hit.wav"; //Small hit in a game [wav]. mixkit. envato elements. https://mixkit.co/free-sound-effects/game/?page=2
final String SHIELD = "shieldAudio.wav"; //Arcade retro changing tab [wav]. mixkit. envato elements. https://mixkit.co/free-sound-effects/game/
final String ENEMYHIT = "enemyHit.wav"; //Neutral bot pinbal tone [wav]. mixkit. envato elements. https://mixkit.co/free-sound-effects/game/?page=2

Minim minim; 
AudioPlayer music, shootSoundE, gemSound, healthSound, purchaseSound, coinsSound, hitSound, shieldSound, enemyHit;

ArrayList<Enemy> enemies = new ArrayList<Enemy>();
Gem endGem; 


void setup(){
  size(1100, 900); 
  state = INTRO_ONE;
  
  //set up all sound effects
  minim = new Minim(this); 
  music = minim.loadFile(BG);
  music.loop();
  shootSoundE = minim.loadFile(SHOOTE);
  gemSound = minim.loadFile(GEM);
  healthSound = minim.loadFile(HEALTH);
  purchaseSound = minim.loadFile(PURCHASE);
  coinsSound = minim.loadFile(COINS);
  hitSound = minim.loadFile(HIT);
  shieldSound = minim.loadFile(SHIELD);
  enemyHit = minim.loadFile(ENEMYHIT);
  
  //load all the images
  imgLoad(); 
  
  PFont font = createFont("ArialHebrew-Bold", 30);   //font is from the processing library (designed by Baruch Gorkin, 1993)
  textFont(font);
  
  player = new Player(new PVector(width/2, height/2), new PVector(),new PVector(4, 45), playerImg );
  player.jump = true;
  enviro = new Environment();
  
  //adding enemies for level one
  enemies.add(new Enemy(new PVector(700, 610), new PVector(), new PVector(75, 80), enemyImg, 1 ));
  enemies.add(new Enemy(new PVector(-65, 660), new PVector(), new PVector(75, 80), enemyImg, 1 ));
  
  //gem at the end of the game
  endGem = new Gem(new PVector(width/2, 400), new PVector(300, 300)); 
}

void draw(){
   
  switch(state){
     case INTRO_ONE:  //welcome page
       screen(introOneImg); 
       break; 

     case INTRO_TWO:  //backstory
       screen(introTwoImg); 
       break;
       
     case INTRO_THREE:  //instructions
       screen(introThreeImg); 
       break; 
       
     case INTRO_FOUR:    //controls
       screen(introFourImg); 
       break; 
       
     case LEVEL_ONE:   
       play();
       break;
     
     case LEVEL_TWO:
       //intro screen
       if (levelIntroTimer > 0 && !reset) {
         levelIntroTimer--;
         screen(levelTwo); 
       }
       else if (levelIntroTimer == 0 && !reset)reset();
       
       //play
       if (reset) play(); 
       break;
     
     case LEVEL_THREE: 
       //intro screen
       if (levelIntroTimer > 0 && !reset) {
         levelIntroTimer--;
         screen(levelThree); 
       }
       else if (levelIntroTimer == 0 && !reset) reset();
       
       else if (reset && !levelThreePlay){
         if (levelIntroTimer > 0) {
           levelIntroTimer--;
           screen(levelThreeTwo); 
         }
         else if (levelIntroTimer == 0)levelThreePlay = true;         
       }
       
       //play
       else if (reset && levelThreePlay) play(); 
       break;
     
     case LEVEL_FOUR:
       //intro screen
       if (levelIntroTimer > 0 && !reset) {
         levelIntroTimer--;
         screen(levelFour); 
       }
       else if (levelIntroTimer == 0 && !reset) reset();
       
       else if (reset && !levelFourPlay){
         if (levelIntroTimer > 0) {
           levelIntroTimer--;
           screen(levelFourTwo); 
         }
         else if (levelIntroTimer == 0)levelFourPlay = true;         
       }
       
       //play
       else if (reset && levelFourPlay) playFour(); 
       break;       
     
     case STORE:
       store(); 
       break;
       
     case LOSE: 
       screen(loseImg);
       break;
       
     case WIN: 
       //reset 
       if (!reset) {
         player.pos.x = -30;
         player.pos.y = 650;
         enviro.tiles.clear(); 
         /*for (int i = 0; i < enviro.tilesEnd.size(); i++){
           enviro.tiles.add(enviro.tilesEnd.get(i));
         }*/
        reset = true;
       }
       else{
         //end screen
         if (end)screen(winImg); 
         //end animation 
         else ending(); 
       }
       break;
  }
}

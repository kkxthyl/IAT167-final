

PImage playerImg, playerGlitch, enemyImg, introOneImg, introTwoImg, introThreeImg, introFourImg, loseImg, winImg, levelTwo, levelThree, levelThreeTwo, levelFour, levelFourTwo;
PImage storeImg, healthPurchase, bulletPurchase, spikePurchase, megaPurchase, errorImg; 
PImage enemyBulletImg, bulletRImg, bulletSImg, bulletMImg; 

int gemCount = 0;                   //how many gems did the player collect: need to collect all to level up
int gemMax = 0; 
int gemMaxTwo = 0; 
int gemMaxThree = 0; 
int coins = 0; 
boolean shield = false; 
int shieldTimer = 300;                     //how long the shield lasts
int shieldMax = 300; 
float shieldPercent = 100; 

char purchase = 'x'; 
boolean error = false;     //store menu

int frameCounter = 0; 
int levelIntroTimer = 120; 
int storeTimer = 120; 
boolean reset = false;
boolean levelThreePlay = false;
boolean levelFourPlay = false;
boolean end = false; 

//show particular screen as a result of pruchase depending on player's key input
//parameters: none
void store(){
  if (!error){
    if (purchase == 'x') screenStore(storeImg);   //default
    
    //health purchase
    if (purchase == 'h' && storeTimer > 0){
      screen(healthPurchase); 
      storeTimer--; 
    }
    else if (purchase == 'h' && storeTimer == 0){
      purchase = 'x'; 
      storeTimer = 120; 
      coins -= 15; 
    }
    
    //regular bullet
    if (purchase == 'b' && storeTimer > 0){
      screen(bulletPurchase); 
      storeTimer--; 
    }
    else if (purchase == 'b' && storeTimer == 0){
      purchase = 'x'; 
      storeTimer = 120; 
      coins -= 12;
    }
    /*
    //spike bullet
    if (purchase == 's' && storeTimer > 0){
      screen(spikePurchase); 
      storeTimer--; 
    }
    else if (purchase == 's' && storeTimer == 0){
      purchase = 'x'; 
      storeTimer = 120; 
      coins -= 25; 
    }*/
    
    //mega bullet
    if (purchase == 'm' && storeTimer > 0){
      screen(megaPurchase); 
      storeTimer--; 
    }
    else if (purchase == 'm' && storeTimer == 0){
      purchase = 'x'; 
      storeTimer = 120; 
      coins -= 50; 
    }
  }
  
  else{
    //not enough coins to buy
    if(storeTimer > 0 && error){
      storeTimer--; 
      screen(errorImg); 
    }
    else if (storeTimer == 0 && error){
      error = false; 
      storeTimer = 120; 
    }
  }
  
  reset = false;
  levelIntroTimer = 120;
}

//reset all the variables for the next level
//parameters: none
void reset(){
   reset = true; 
   gemCount = 0; 
   player.tiles = null;
   player.health = player.maxHealth; 
   enviro.tiles.clear(); 
   
   player.pos.x = width/2; 
   player.pos.y = height/2;
   
   //level two specifics
   if (state == LEVEL_TWO){
     for (int i = 0; i < enviro.tilesLvlTwo.size(); i++){
       enviro.tiles.add(enviro.tilesLvlTwo.get(i));    //tile updaate
     }
     //enemy upate
     enemies.clear(); 
     enemies.add(new Enemy(new PVector(360,665 ), new PVector(), new PVector(75, 80), enemyImg , 1));
     enemies.add(new Enemy(new PVector(-300, 705), new PVector(), new PVector(75, 80), enemyImg, 1 ));
     gemMax = gemMaxTwo; 
     enviro.level = 3;
   }
   
   //level three specifics
   else if (state == LEVEL_THREE){
     for (int i = 0; i < enviro.tilesLvlThree.size(); i++){
       enviro.tiles.add(enviro.tilesLvlThree.get(i));      //tile update
     }
     //enemy update
     enemies.clear(); 
     enemies.add(new Enemy(new PVector(1400, 175 ), new PVector(), new PVector(75, 80), enemyImg, -1 ));
     enemies.add(new Enemy(new PVector(80, 710), new PVector(), new PVector(75, 80), enemyImg, -1 ));
     gemMax = gemMaxThree;  
     enviro.level = 4;
   }
   
   else if (state == LEVEL_FOUR){
     for (int i = 0; i < enviro.tilesLvlFour.size(); i++){
       enviro.tiles.add(enviro.tilesLvlFour.get(i));      //tile update
     }
     //enemy update
     enemies.clear(); 
     enemies.add(new Enemy(new PVector(200, 350 ), new PVector(), new PVector(75, 80), enemyImg, 1 ));
     enemies.add(new Enemy(new PVector(250, 480), new PVector(), new PVector(75, 80), enemyImg , 1));
      enemies.add(new Enemy(new PVector(150, 220), new PVector(), new PVector(75, 80), enemyImg , 1));
     gemMax = 0;
     leftAcc.x = -2; 
     rightAcc.x = 2;
     shield = false;
   }
   
   player.jump = true;
   levelIntroTimer = 120;
   
   player.shoot = true;
   
}

//end screen animation 
//parameters: none
void ending(){
  player.direction = 1;    //moving right
  //println(player.pos);
  frameCounter++;
  screen(enviro.backgroundEnd);    
  endGem.drawMe();
  player.pos.x += 3;     //speed
  player.updateEnd();
  
  if (player.pos.x > width/2)end = true;     //stop animation
}

//showcase the store
//show how many coins there are
//parameter: PImage
void screenStore(PImage img){
  image(img, 0, 0);
  textAlign(CENTER); 
  textSize(20); 
  fill(0); 
  
  pushMatrix(); 
  translate(1000, 850); 
  text("Coins: " + coins, 0, 0); 
  popMatrix(); 
}

//show an image the size of the screen
//parameter: PImage
void screen(PImage img){
  image(img, 0, 0);
}


//gameplay, level four
//parameters: none
void playFour(){
  //game control: if all enemies are dead, win
  if (enemies.size() == 0) {
    state = WIN;
    reset = false;
  }
  
  frameCounter++;
  enviro.update(player);
  
  //player movement
  if (up && !player.jump)player.jump(upForce);
  if(left)player.move(leftAcc);
  if(right)player.move(rightAcc);
  
  //Yang, E. (2021, July 20). Week 10 Tutorial. [Lecture]. IAT167 Summmer 2021.
  //if player on tile and moves off, can jump again  
  if (player.tiles != null) {
    if (!player.tiles.isOnStatic(player)) {
      player.jump = true;
    }
  }

  if (player.jump) {
    player.move(gravForce);
    //gravity brings player back down
    for (int i = 0; i < enviro.tiles.size(); i++) {//check to see if player hit tile
      Tile t = enviro.tiles.get(i);
      if (t.checkStatic(player)) {
        
        //if there is a tile, player lands on it
        if (player.vel.y > 0) {
          player.landOn(t);
        } 
        else {
          player.fall(t);    //otherwise let player keep going down
        }
      }
     
    }
  }
  
  //update enemies
  for (int i = 0; i < enemies.size(); i++){
    enemies.get(i).update(); 
  }
  
  player.update(); 
  
}




//gameplay (leve; 1-3)
//parameters: none
void play(){
  //if level was completed, move to the store
  if (gemCount >= gemMax) state = STORE;
  
  frameCounter++;
  enviro.update(player);
  
  //player and enemy movement
  if (up && !player.jump) player.jump(upForce);
 
  if(left){      //move left
    player.move(leftAcc);
    for (int i = 0; i < enemies.size(); i++){
      enemies.get(i).move(rightAccE); 
    }
  }
  
  if(right) {    //move right
    player.move(rightAcc);
     for (int i = 0; i < enemies.size(); i++){
      enemies.get(i).move(leftAccE); 
    } 
  }
  
  //Yang, E. (2021, July 20). Week 10 Tutorial. [Lecture]. IAT167 Summmer 2021.
  //if player on tile and moves off, can jump again  
  if (player.tiles != null) {
    if (!player.tiles.isOn(player)) {
      player.jump = true;
    }
  }

  if (player.jump) {
    player.move(gravForce);
    //gravity brings player back down
    for (int i = 0; i < enviro.tiles.size(); i++) {//check to see if player hit tile
      Tile t = enviro.tiles.get(i);
      if (t.check(player)) {
        
        //if there is a tile, player lands on it
        if (player.vel.y > 0) {
          player.landOn(t);
        } 
        else {
          player.fall(t);    //otherwise let player keep going down
        }
      }
     
    }
  }
  
  for (int i = 0; i < enemies.size(); i++){
    enemies.get(i).update(); 
  }
  
  player.update(); 
  
   //timer and update shield boost
  if (shield == true){
    //update meter
    shieldTimer--; 
    shieldPercent = (float)shieldTimer/shieldMax;
    
    //reset when time is up
    if (shieldTimer < 0){
      shield = false; 
      shieldTimer = 300; 
    }
    else player.drawShield(); 
  }  
  
}

//Yang, E. (2021, July 27). Lec 11 Tutorial. [Tutorial]. IAT167 Summmer 2021.
//sound control
//parameter: string for file name
void playSound(String file){
  AudioPlayer sound = null; 
  
  switch(file){
    case SHOOTE: 
      sound = shootSoundE; 
      break; 
      
    case GEM: 
      sound = gemSound; 
      break; 
      
    case HEALTH: 
      sound = healthSound; 
      
    case PURCHASE: 
      sound = purchaseSound; 
      break; 
      
    case COINS: 
      sound = coinsSound; 
      break; 
      
    case HIT: 
      sound = hitSound; 
      break; 
      
    case SHIELD: 
      sound = shieldSound; 
      break; 
      
    case ENEMYHIT:
      sound = enemyHit; 
      break;
  }
  
  sound.play(0);
}

void imgLoad(){
  
  playerImg = loadImage("player.png");      //Lee, K. (2021, July 17). player. [png]. Illustrator. modified from https://www.kindpng.com/imgv/bbxowx_astronaut-spritesheet-astronaut-2d-sprite-hd-png-download/
                                            //i did not design the character, only modified
  enemyImg = loadImage("enemy.png");        //Lee, K. (2021, July 17). enemy. [png]. Illustrator.
  enemyImg.resize(60, 70);
  
  playerGlitch = loadImage("playerGlitch.png");  //Lee, K. (2021, July 26). playerGlitch. [png]. Illustrator. 
  playerGlitch.resize(playerGlitch.width/6, playerGlitch.height/6); 
    
  
  introOneImg = loadImage("intro1.png");  //Lee, K. (2021, Aug 1). intro1. [png]. Illustrator.
  introOneImg.resize(1100, 900);
  
  introTwoImg = loadImage("intro2.png");    //Lee, K. (2021, Aug 1). intro2. [png]. Illustrator.
  introTwoImg.resize(1100, 900);
  
  introThreeImg = loadImage("intro3.png");    //Lee, K. (2021, Aug 1). intro3. [png]. Illustrator.
  introThreeImg.resize(1100, 900);
  
  introFourImg = loadImage("intro4.png");  //Lee, K. (2021, Aug 1). intro4. [png]. Illustrator.
  introFourImg.resize(1100, 900);
  
  loseImg = loadImage("lose.png");  //Lee, K. (2021, Aug 1). lose. [png]. Illustrator.
  loseImg.resize(1100, 900);
  
  winImg = loadImage("win.png");  //Lee, K. (2021, Aug 1). win. [png]. Illustrator.
  winImg.resize(1100, 900);
  
  levelTwo = loadImage("levelTwo.png");    //Lee, K. (2021, Aug 2). levelTwo. [png]. Illustrator.
  levelTwo.resize(1100, 900);
  
  levelThree = loadImage("levelThree.png");   //Lee, K. (2021, Aug 2). levelThree. [png]. Illustrator.
  levelThree.resize(1100, 900);

  levelThreeTwo = loadImage("levelThree2.png");   //Lee, K. (2021, Aug 8). levelThree2. [png]. Illustrator.
  levelThreeTwo.resize(1100, 900);

  levelFour = loadImage("levelFour.png");   //Lee, K. (2021, Aug 2). levelThree. [png]. Illustrator.
  levelFour.resize(1100, 900);

  levelFourTwo = loadImage("levelFour2.png");   //Lee, K. (2021, Aug 8). levelThree2. [png]. Illustrator.
  levelFourTwo.resize(1100, 900);
  
  storeImg = loadImage("store.png");  //Lee, K. (2021, Aug 1). store. [png]. Illustrator.
  storeImg.resize(1100, 900);  
  
  healthPurchase = loadImage("store-health.png");  //Lee, K. (2021, Aug 1). store-health. [png]. Illustrator.  
  healthPurchase.resize(1100, 900);
  
  bulletPurchase = loadImage("store-bullet.png");  //Lee, K. (2021, Aug 1). store-bullet. [png]. Illustrator.
  bulletPurchase.resize(1100, 900);
  
  spikePurchase = loadImage("store-spike.png");  //Lee, K. (2021, Aug 1). store-spike. [png]. Illustrator.
  spikePurchase.resize(1100, 900);
  
  megaPurchase = loadImage("store-mega.png");  //Lee, K. (2021, Aug 1). store-mega. [png]. Illustrator.
  megaPurchase.resize(1100, 900);
  
  errorImg = loadImage("store-error.png");   //Lee, K. (2021, Aug 1). store-error. [png]. Illustrator.
  errorImg.resize(1100, 900); 
  
  enemyBulletImg = loadImage("bulletE.png");  //Lee, K. (2021, Aug 2). bulletE. [png]. Illustrator.
  enemyBulletImg.resize(30, 20);
  
  bulletRImg = loadImage("bulletR.png");   //Lee, K. (2021, Aug 2). bulletR. [png]. Illustrator.
  bulletRImg.resize(30, 20); 
  
  bulletSImg = loadImage("bulletS.png");   //Lee, K. (2021, Aug 2). bulletS. [png]. Illustrator.
  bulletSImg.resize(30, 20); 
  
  bulletMImg = loadImage("bulletM.png");   //Lee, K. (2021, Aug 2). bulletM. [png]. Illustrator.
  bulletMImg.resize(30, 20); 
  
}

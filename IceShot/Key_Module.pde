//the code for this module was modified from lab 7 IAT167 D101 Summmer 2021
//Yang, E. (2021, July 20). Lab 10 Tutorial. [Tutorial]. IAT167 Summmer 2021. 

//not a class

boolean left, right, up; 
float speed = 1; 
float grav = 3;
PVector gravForce = new PVector(0, grav);
PVector upForce = new PVector(0, -2.75 * 24);
PVector leftAcc = new PVector(-speed, 0);
PVector rightAcc = new PVector(speed, 0);

PVector leftAccE = new PVector(-speed*2, 0);
PVector rightAccE = new PVector(speed*2, 0);

void keyPressed(){
  //move right, left
  if(key == CODED && state != WIN){
    if(keyCode == LEFT) {
      left = true;
      player.direction = -1;
    }
    if(keyCode == RIGHT) {
      right = true;
      player.direction = 1; 
    }
    if(keyCode == UP) up = true;
    
  }
  //when in the store and want to continue to the game
   if (key == ' ' && state == INTRO_ONE) state = INTRO_TWO; 
   else if (key == ' ' && state == INTRO_TWO) state = INTRO_THREE; 
   else if (key == ' ' && state == INTRO_THREE) state = INTRO_FOUR; 
   else if (key == ' ' && state == INTRO_FOUR) state = LEVEL_ONE; 
   else if (key == ' ' && state == STORE && enviro.level == 2) state = LEVEL_TWO; 
   else if (key == ' ' && state == STORE && enviro.level == 3) state = LEVEL_THREE;
   else if (key == ' ' && state == STORE && enviro.level == 4) state = LEVEL_FOUR;
   
   //buy the health upgrade
   if (key == 'h' && state == STORE){
     if (coins - 15 >= 0){
       player.maxHealth = 12; 
       purchase = 'h'; 
       playSound(PURCHASE);
     }
     else error = true; 
   }
   
   //by the regular bullet
   if (key == 'b' && state == STORE) {
     if (coins - 12 >= 0){
       player.bulletC = 'b';
       purchase = player.bulletC;
       playSound(PURCHASE);
     }
     else error = true; 
   }
   /*
   if (key == 's' && state == STORE) {
     if (coins - 25 >= 0){
       player.bulletC = 's';
       purchase = player.bulletC;
       playSound(PURCHASE);
     }
     else error = true; 
   }*/
   
   //buy the mega bullet
   if (key == 'm' && state == STORE) {
     if (coins - 50 >= 0){
       player.bulletC = 'm';
       purchase = player.bulletC;
       playSound(PURCHASE);
     }
     else error = true; 
   }
   
   //let the player shoot bullets
   if (key == ' ' && player.shoot == true && player.shootTimer == 0) {
     player.fireBullet();
     player.shootTimer = 15; 
   }
}

void keyReleased(){
  //stop moving when keys are released
  if(key == CODED){ 
    if(keyCode == LEFT) left = false;
    if(keyCode == RIGHT) right = false;
    if(keyCode == UP) up = false;
  }
 
}

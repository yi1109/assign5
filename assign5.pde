Ball myBall;
Bar theBar;
Brick [] bricks;

//Game Status
final int GAME_START   = 0;
final int GAME_RUN     = 1;
final int GAME_PLAYING = 2;
final int GAME_PAUSE   = 3;
final int GAME_WIN     = 4;
final int GAME_LOSE    = 5;
final int GAME_OVER    = 6;

int status;              //Game Status
int life = 3 ;
int myBallX ;
int myBallY;
int brickNum;

String pStart = "PONG";
String sStart = "Press Enter to Start";
String pPause = "Pause";
String sPause = "Press Enter to Resume";
String pWin   = "WINNER";
String sWin   = "SCORE";
String pLose  = "BOOM";
String sLose  = "GAME OVER";
void printText(
int pSize, int px, int py, String pMark, String sMark) {  
  textSize(pSize);
  text(pMark, px, py);
  fill(105,105,105);
  textSize(20);
  text(sMark, px, py+40);
  fill(105,105,105);
  textAlign(CENTER);
}

void setup(){
  status = GAME_START;
  size(640,480);
  background(255);
  
  
  theBar = new Bar(80);
  bricks = new Brick[50];
  
  brickMaker(50);  
  
  reset();
}
void reset(){
  brickNum=0;
  life=3;
  for(int i=0;i<bricks.length;i++){
     fill(int (i*49%255),int(i*49%255),255);
     bricks[i].display();
      }
  
}
void draw(){
  background(0);
  noStroke();
  println(life);
  switch(status){
    
    case GAME_START:;
     printText(60, width/2, height/2, pStart, sStart);
     //myBallX = mouseX;
     //myBallY = height - 30;
     //myBall = new Ball(myBallX,myBallY);
     //myBall.display();
     //drawLife();
     
     break;
    
    case GAME_RUN:
     for(int i=0;i<bricks.length;i++){
     fill(int (i*49%255),int(i*49%255),255);
     bricks[i].display();
      }
     theBar.move();
     theBar.display();
     myBallX = mouseX;
     myBallY = height - 30;
     myBall = new Ball(myBallX,myBallY);
     myBall.display();
     drawLife();
      
     break;
    
    case GAME_PLAYING:
     theBar.move();
     theBar.display();
     for(int i=0;i<bricks.length;i++){
     fill(int (i*49%255),int(i*49%255),255);
     bricks[i].display();
      }
     myBallX = mouseX;
     myBallY = height - 30;
     //myBall = new Ball(myBallX,myBallY);
     myBall.display();
     myBall.move();
     drawLife();
     checkBallMissed();
     checkBrickHit();
     checkWin();
   
    break;
     
    case GAME_PAUSE:     
    /*---------Print Text-------------*/
    printText(40, width/2, height/2, pPause, sPause);
    /*--------------------------------*/
    break;
  case GAME_WIN:
    /*---------Print Text-------------*/
    printText(40, width/2, height/2+80, pWin,"cool");
    /*--------------------------------*/
    //winAnimate();
    break;
  case GAME_LOSE:
 
    /*---------Print Text-------------*/
    //loseAnimate();
   fill(95, 194, 226);
    printText(40, width/2, height/2, "LOST A LIFE","PRESS ENTER TO CONTINUE");
  
    /*--------------------------------*/
    break;
    
  case GAME_OVER:
  
   fill(95, 194, 226);
    printText(40, width/2, height/2, "BOOM","GAME OVER");
    break;
     }
}
 
 void brickMaker(int num){
   for(int i=0;i<num;i++){
     
     int colNum = 10; 
     int bx = (width-40*10-10*9)/2+(50*int(i % colNum));
     int by = 30+(30*int(i /colNum));
     bricks[i] = new Brick(bx,by);
   }
  }
void checkBrickHit(){
  for (int i=0; i<bricks.length; i++) {
    Brick brick = bricks[i];
    if (brick!= null && !brick.gone // Check Array isn't empty and brick still exist
      && bricks[i].brx+brick.len/2 >= myBall.x  && bricks[i].bry-brick.len/2<= myBall.y+myBall.size/2
      && bricks[i].bry+brick.len/2>= myBall.y && bricks[i].brx-brick.len/2<=myBall.x ) {
      
      
      removeBrick(brick);
      brickNum++;
    }
  }
   
}
void removeBrick(Brick obj){
  obj.gone = true;
  obj.brx = 2000;
  obj.bry = 2000;
}
void drawLife() {
  fill(230, 74, 96);
  text("LIFE:", 36, 455);
  
  for(int i=0;i<life;i++){
    int xspace = 25*i;
    ellipse(78+xspace,459,15,15);
  }
}
void checkBallMissed(){
   
   if(myBallY>height){
     println(myBallY);
       life --;
       status = GAME_PLAYING;
    }
}

void checkWin(){
    if(brickNum==50){
       status=GAME_WIN;
    }
    if(myBall.y>=height){
       life-=1;
       status=GAME_LOSE;
    }
       if(life==0){
         status=GAME_OVER;
       }
    }
    





void mousePressed(){
    if(mouseButton == RIGHT){
      status = GAME_PLAYING;
    }
}
void keyPressed() {
  if (keyCode==ENTER) {
  /*status = GAME_START;
  }
  statusCtrl();
}
void statusCtrl() {
  if (key == ENTER) {*/
    switch(status) {
    case GAME_START:
      status = GAME_RUN;
      break;
      /*-----------add things here--------*/
    case GAME_PLAYING:
      status = GAME_PAUSE;
      break;   
    case GAME_PAUSE:
      status = GAME_PLAYING;
      break;
    case GAME_WIN:
      status = GAME_START;
      reset();
      break;
    case GAME_LOSE:
      status = GAME_RUN;
      break;
    case GAME_OVER:
      status = GAME_START;
      reset();
      break;  
    }
  }
}

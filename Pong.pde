import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress dest;
float p = .5;
float x, y, dx, dy;
float r = 10;
float rectSize = 200;
float lbound = 200;
float ubound=150;
int score=0;

void setup() {
  size(1080,720);
  fill(0, 255, 0);
  reset();
  
  oscP5 = new OscP5(this,12000); //listen for OSC messages on port 12000 (Wekinator default)
  dest = new NetAddress("127.0.0.1",6448); //send messages back to Wekinator on port 6448, localhost (this machine) (default)
}


void reset() {
  x = width/2;
  y = height/2;
  dx = random(5, 8);
  dy = random(5, 8);
}

int z=0;
void draw() { 
  fill(255, 255, 255);
  text("Score: ",score, 100, 10 );
  background(0);
  fill(0, 255, 0);
  
  ellipse(x, y, r, r);
  if (z%100==0){
    lbound=random(height/2-50);
  }
  z+=1;
  rect(0, 0, 20, lbound);
  rect(0,lbound+175,20,height);
  rect(width-30, (height*p)-rectSize/2, 10, rectSize);

  x += dx;
  y += dy;

  if ( x > width-30 && x < width -20 && y > (height*p)-rectSize/2 && y < (height*p)+rectSize/2) {
    dx = dx * -1;
  } 
  
  if ( x > width-30 && x < width -20 && (y < (height*p)-rectSize/2 || y > (height*p)+rectSize/2)) {
    score-=1;
    reset();
  }

  if (x < 25 && (y<lbound || y>lbound+300)) {
    dx *= -1.1;
    dy *= 1.1;
  }
  if (x < 25 && y>lbound && y<lbound+300){
  score+=1;
  reset();
  }

  if ( y > height || y < 0 ) {
    dy *= -1;
  }
}
void oscEvent(OscMessage theOscMessage) {
 if (theOscMessage.checkAddrPattern("/wek/outputs")==true) {
     if(theOscMessage.checkTypetag("f")) { //Now looking for 1 parameters
        p = theOscMessage.get(0).floatValue(); //get this parameter
        println("Received new params value from Wekinator");
      } else {
        println("Error: unexpected params type tag received by Processing");
      }
 }
}

void mousePressed() {
  reset();
}

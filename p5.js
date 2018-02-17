function setup() {
  createCanvas(400, 400);
}

var x = 200;
var y = 200;
var flag2=0;
var x1 = 400;	
var y1 = 400;	
var r1 =1;	


var dx = 0;
var dy = 0;


var isGoalReached = false;

function drawBall() {
  fill(color(0, 255, 0));
  ellipse(x, y, 20, 20);
}

function drawGoal() {
  if(flag2==0){
	axis=random(0,2)
  if (axis>=1){
  x1 = random(400);
  y1=200;
  r1=random(50)
  flag2=1
  }
  else{
  x1 = 200;
	y1 = random(400);
  r1=random(50)
  flag2=1
  }
  }
  ellipse(x1, y1, r1 * 2, r1 * 2);
}

function drawMouseCursor() {
  fill(color(255, 0, 0))
  ellipse(mouseX, mouseY, 20, 20);
}

function draw() {
  background(220);

  drawGoal();

  drawBall();

  drawMouseCursor();

  checkGoal();

  if (!isGoalReached) {
    update();
  }
  
}

function update() {
  x = x + dx
  y = y + dy
}

function checkGoal() {
  if (dist(x, y, x1, y1) < r1) {
    fill(255,255,0)
    ellipse(x1,y1,r1*2,r1*2)
    isGoalReached = true
  }
}

function mouseMoved() {

  if (mouseX >= 200 ) {
    dx = 2*(mouseX-200)/200
    
  } else {
    dx = -2*(200-mouseX)/200
  }
  if (mouseY >= 200 ) {
    dy = 2*(mouseY-200)/200
  } else {
    dy = -2*(200-mouseY)/200
  }
}

import processing.sound.*;

Starhopper starhopper;
Terrain terrain;
float gravity;
int score;

void setup(){
  size(1400,900);
  frameRate(120);
  
  terrain = new Terrain();
  starhopper = new Starhopper(width/4, height/4, terrain, this);
  
  
  gravity = 4;
  score = 0;
  
  starhopper.setGravity(gravity);
  
  
}

void draw(){
  background(0);
  stroke(255);
  strokeWeight(2);
  
  starhopper.draw();
  
  textSize(10);
  fill(255);
  text("horizontal speed: " + (int)(starhopper.getHSpeed()*40), 10, 20);
  text("vertical speed: " + -(int)(starhopper.getVSpeed()*40 + gravity),10,40);
  text("fuel: " + (int)starhopper.getFuel(), 10, 60);
  text("Altitude: " +(int)((height-starhopper.getY())/2), 10, 80);
  text("Score: " + score, 10, 100);
  
  
  terrain.draw();
}

void keyPressed(){
  starhopper.keyPressed();
  
  if(keyCode == ENTER){
    if(starhopper.getisSmall()){
      starhopper.setSmall(false);
      terrain.setBig(true);
    }else{
      starhopper.setSmall(true);
      terrain.setBig(false);
    }
  }
}

void keyReleased(){
  starhopper.keyReleased();
}

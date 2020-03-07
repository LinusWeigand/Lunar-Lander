
class Starhopper{
  
  SoundFile sound;
  Terrain terrain;
  
  float x, y, w, h;
  float rotation;
  float hspeed, vspeed;
  float gravity;
  float fuel;
  float amp;
  float t, v;
  PImage img;
  PImage[] explosion;
  boolean moveUp, turnRight, turnLeft;
  boolean isSmall, makeSoundPlay, makeSoundStop;
  int pstate, rstate;
  float explosionIndex;
  float opacity;
  
  Starhopper(int x, int y,Terrain terrain, Main main){
    this.x = x;
    this.y = y;
    this.terrain = terrain;
    
    sound = new SoundFile(main, "Sound.wav");
    img = loadImage("starhopper.png");
    explosion = new PImage[13];
    for(int i = 0; i < 13; i++){
      explosion[i] = loadImage("explosion\\ex" + i + ".png");
    }
    
    rotation = radians(270);
    hspeed = 1;
    vspeed = 0.2;
    gravity = 2;
    pstate = 0;
    rstate = 5;
    fuel = 1000;
    explosionIndex = 0;
    opacity = 0;
    isSmall = true;
    makeSoundPlay = true;
    makeSoundStop = false;
    amp = 1;
    
    sound.amp(amp);
  }
  
  void draw(){
    fill(255);
    if(!collision()){
    update();
    Matrix();
    soundBox();
    }else{
      if(!landing()){
      textSize(50);
      fill(255,opacity);
      text("GAME OVER",width/2 - 150,height/2);
      image(explosion[(int)explosionIndex], x - 30, y - 30, 60, 60);
      if(explosionIndex < 12){
      explosionIndex += 0.3;
      }
      sound.stop();
      opacity += 1;
      }else{
        textSize(50);
        fill(255,opacity);
        text("SUCCESS",width/2 - 150,height/2);
        sound.stop();
        Matrix();
        opacity += 1;
      }
    }
    
  }
  
  void keyPressed(){
    switch(keyCode){
      
      case UP:
      moveUp = true;
      
      break;
      
      case RIGHT:
      turnRight = true;
      break;
      
      case LEFT:
      turnLeft = true;
      break;
    }
  }
  
  void keyReleased(){
    switch(keyCode){
      
      case UP:
      moveUp = false;
      pstate = 0;
      rstate = 0;
      makeSoundPlay = true;
      makeSoundStop = true;
      break;
      
      case RIGHT:
      turnRight = false;
      break;
      
      case LEFT:
      turnLeft = false;
      break;
    }
  }
  
  void update(){
      x += hspeed;
      y += vspeed;
      
      if(hspeed > 0){
        hspeed -= 0.0001;
      }else{
        hspeed += 0.0001;
      }
    if(moveUp){
      hspeed += cos(rotation) * 0.004;
      vspeed += sin(rotation)/300;
      fuel -= 0.2;
      
      switch(pstate){
        
        case 0:
        img = loadImage("starhopper1.png");
        pstate++;
        break;
        
        case 1:
        pstate+=2;
        
        case 3:
        pstate+= 2;
        break;
        
        case 5:
        img = loadImage("starhopper2.png");
        pstate++;
        break;
        
        case 6:
        pstate++;
        break;
        
        case 7:
        img = loadImage("starhopper3.png");
        pstate++;
        break;
        
        case 8:
        pstate = 5;
        break;
        
      }
      
      
    }else{
      if(vspeed < 10){
        vspeed += pow((1.62/2),2)/600; 
        
        switch(rstate){
        
        case 0:
        rstate++;
        break;
        
        case 1:
        rstate++;
        break;
        
        case 2:
        rstate++;
        img = loadImage("starhopper1.png");
        break;
        
        case 3:
        rstate++;
        break;
        
        case 4:
        rstate++;
        break;
        
        case 5:
        img = loadImage("starhopper.png");
        break;
      }
      }
    }
    if(turnRight){
      //if(rotation < 2*PI){
        rotation += radians(2);
      //}
    }
    if(turnLeft){
      //if(rotation > PI){
        rotation -= radians(2);
      //}
    }
      
     //System.out.println("y: " + y + " h: " + h + "getHeight: " + terrain.getHeight((int)x));
     
    }
  
  
  
  
  void soundBox(){
    if(moveUp && makeSoundPlay){
      amp = 1;
      sound.amp(amp);
      sound.loop();
      makeSoundPlay = false;
     }
     if(!moveUp && makeSoundStop){
       if(amp > 0){
         amp -= 0.05;
         sound.amp(amp);
          
       }
     }
  }
  
  void Matrix(){
    pushMatrix();
    translate(x, y);
    rotate(rotation + radians(90));
    if(isSmall){
      w = 21;
      h = 18;
      image(img, -11.5, -9, 21, img.height/2);
    }else{
      w = 42;
      h = 36;
      image(img, -21, -18);
    }
    popMatrix();
  }
  
  private boolean collision(){
   // ellipse(x + cos(rotation)*8, y + sin(rotation)*8, 4, 4);
   //ellipse(x + cos(rotation + radians(130))*12, y + sin(rotation + radians(130))*12,4, 4);
   //ellipse(x + cos(rotation - radians(130))*12, y + sin(rotation - radians(130))*12, 4, 4);
   
   //ellipse(x + cos(rotation)*10,  terrain.getHeight((int)(x + cos(rotation)*10)) , 4, 4);
   //ellipse(x + cos(rotation + radians(130))*14, terrain.getHeight((int)(x + cos(rotation + radians(130))*14)), 4, 4);
   //ellipse(x + cos(rotation - radians(130))*14,  terrain.getHeight((int)(x + cos(rotation - radians(130))*14)) , 4, 4);
   
   println(degrees(rotation));
   return !(y + sin(rotation)*10 < terrain.getHeight((int)(x + cos(rotation)*10)) 
   && y + sin(rotation + radians(130))*14 < terrain.getHeight((int)(x + cos(rotation + radians(130))*14))
   && y + sin(rotation - radians(130))*14 < terrain.getHeight((int)(x + cos(rotation - radians(130))*14)));// && !(vspeed < 0.5 && degrees(rotation) < 280 && degrees(rotation) > 260); 
   
  }
  
  private boolean landing(){
    return (vspeed < 0.2 && degrees(rotation) < 275 && degrees(rotation) > 265 && x > terrain.getR() && x < terrain.getR() + 40 && vspeed > 0 && hspeed < 0.1 && hspeed > -0.1);
  }
  
  boolean getisSmall(){
    return isSmall;
  }
  
  float getVSpeed(){
    return vspeed;
  }
  float getHSpeed(){
    return hspeed;
  }
  
  float getFuel(){
   return fuel; 
  }
  
  float getY(){
   return y; 
  }
  
  float getX(){
    return x;
  }
  
  
  
  void setSmall(boolean isSmall){
    this.isSmall = isSmall;
  }
  
  void setGravity(float gravity){
   this.gravity = gravity; 
  }
  
 
  
}

class Terrain{
  private float amp = 400;
  private float[] siny = new float[width];
  private float[][] stars;
  int r = (int)random(siny.length - 20);
  int r2 = (int)random(siny.length - 20);
  int a = 0;
  boolean big;
  
  Terrain(){
    for(int i = 0; i < siny.length; i++){
      //siny[i] = height - 250 + (100*sin(i*0.01)) * noise(sin(noise(i*0.01)*10))*noise(cos(i*0.01))*5/noise(5);
      
      siny[i] = height - amp + amp * noise(0.01 * i);
    }
    stars = new float[20][2];
    
    for(int w = 0; w < 20; w++){
    for(int h = 0; h < 2; h++){
      if(h == 0){
        stars[w][h] = random(width);  
      }else{
        stars[w][h] = random(height - amp); 
      }
    }
  }
  
  }
  
  void draw(){
    if(!big){
    //System.out.println(siny.length);
    for(int i = 0; i < width - 1; i++){
      line(i, siny[i], i+1, siny[i+1]);
      }
    
    for(int w = 0; w < 20; w++){
      ellipse(stars[w][0], stars[w][1], 2, 2);
    }  
    generateLandingAreas(r);
    }else{
      int x = 0;
      for(int i = 0; i < width - 1; i++){
      
      line(x, siny[i], x + 2, siny[i+1]);
      x += 2;
      }
      generateLandingAreas(r);
    }
  }
  
  void generateLandingAreas(int r){
    for(int i = 0; i < 40; i++){
      siny[r+i] = siny[r];
    }
    //line(r, siny[r], r + 20, siny[r]);
    if(frameCount%30 == 0){
      switch(a){
        
        case 0:
        a = 1;
        break;
        
        case 1:
        a = 0;
        break;
      }
    }
    if(a == 0){
    textSize(10);
    text("x 2", r + 2 , siny[r] + 10);
    }
  }
  
  float getHeight(int x){
    if(x < 1400 && x > 0){
    return siny[x];
    }else{
      return 0;
    }
  }
  
  float getR(){
    return r;
  }
  
  void setBig(boolean big){
    this.big = big;
  }
  
}

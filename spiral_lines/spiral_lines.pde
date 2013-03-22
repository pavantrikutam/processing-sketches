  float r, g, b;
  color from;
  float cNoise;

  float rectWidth, rectHeight;
  float widthNoise;
  float heightNoise;
  float ang;

void setup() {
  size(600,400); 

  background(255);
  noStroke();
  smooth();

  r = random(255);
  g = random(255);
  b = random(255);
  from = color(r, g, b);
  cNoise = .1;
  
  
  rectWidth = 5;
  rectHeight = 100;
  widthNoise = random(10);
  heightNoise = random(10);
  
  ang = 0;

  while(ang <= 1080) {
   
    //Gradually Vary Color
    cNoise += 0.05;
    float thisr = random(255);
    float thisg = random(255);
    float thisb = random(255);
    
    color to = color(thisr, thisg, thisb);
    color interpColor = lerpColor(from, to, noise(cNoise));

    fill(interpColor);
    from = interpColor;
    
    
    
    //Gradually Vary Height
    heightNoise += .005;
    widthNoise += .05;
    float thisHeight = rectHeight + (noise(heightNoise) * 2000) - 1000;
    float thisWidth = rectWidth + (noise(widthNoise) * 60) - 30;
    
    //Draw Rects
    float rads = radians(ang);
    pushMatrix();
    translate(width/2,height/2);
    rotate(rads);
    rectMode(CORNER);
    rect(0,0,10,thisHeight);
    popMatrix(); 
    
    //Angle a bit forward   
    ang += 5;
    
  }


}

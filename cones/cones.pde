
static float unitConeX[];
static float unitConeY[];
static int coneDetail;
 
static {
  coneDetail(64);
}
 
// just inits the points of a circle, 
// if you're doing lots of cones the same size 
// then you'll want to cache height and radius too
static void coneDetail(int det) {
  coneDetail = det;
  unitConeX = new float[det+1];
  unitConeY = new float[det+1];
  for (int i = 0; i <= det; i++) {
    float a1 = TWO_PI * i / det;
    unitConeX[i] = (float)Math.cos(a1);
    unitConeY[i] = (float)Math.sin(a1);
  }
}
 
// places a cone with it's base centred at (x,y),
// beight h in positive z, radius r.
void cone(float x, float y, float r, float h) {
  pushMatrix();
  translate(x,y);
  scale(r,r);
  beginShape(TRIANGLES);
  for (int i = 0; i < coneDetail; i++) {
    vertex(unitConeX[i],unitConeY[i],0.0);
    vertex(unitConeX[i+1],unitConeY[i+1],0.0);
    vertex(0,0,h);
  }
  endShape();
  popMatrix();
}


void setup() {
  size(1200, 600, P3D);
   
  background(255);

  lights();
//  ambientLight(180,180,180);
//  directionalLight(255, 255,255, -1, -1,1);
//spotLight(255, 255, 255,-100, -100, -100, 2, 3, 1, PI/2, 2);
  

  noStroke();
  float xStart = random(10);
  float xNoise = xStart;
  float yNoise = random(10);
//  translate(0,-50,0);
  rotateX(radians(-95));
//  rotateY(radians(-10));
//  rotateZ(radians(45));
  translate(-10000,-400,500);
  
  float coneBase = 12.5;


  //Non-Random Colors
//   color endColor = color(255,0,0);
//   color startColor = color(255,255,0);

//  

  //Directed randoms (redish to greenish)
//  color startColor = color(random(255),random(55),random(55));
//  color endColor = color(random(255),random(255),random(50));
//  
  //Straight up Randoms
     color startColor = color(random(255),random(255),random(255));
  color endColor = color(random(255),random(255),random(255));

  for (int x = 0; x < 20000; x += (coneBase*2)) {
    yNoise += 0.1;
    xNoise = xStart;
    
    for (int y = 0; y < 40000; y += ((coneBase*2) + random(10))) {
      
      xNoise += 0.1;
//      coneBase += 0.01;
      pushMatrix();
      translate(x,y, 0);
      rotateX(radians(180));
//      rotate(random(-5,5),random(-5,5),random(-5,5),random(-5,5));

      //forest colors
      float thisr = random(55);
      float thisg = random(30,200);
      float thisb = random(25);
      
      //random colors
//      float thisr = random(255);
//      float thisg = random(255);
//      float thisb = random(255);
    
      color to = color(thisr, thisg, thisb);
      color thisColor = lerpColor(startColor, to, noise(xNoise,yNoise));
      fill(thisColor);
      startColor = thisColor;

      float thisHeight = noise(xNoise,yNoise)*125;
      
      translate(0,-thisHeight,0);
      
//      drawCylinder(1, coneBase,  thisHeight, 64); // Draw a mix between a cylinder and a cone
      cone(0,0,coneBase,thisHeight);
      popMatrix();    
    }
    
  }
}



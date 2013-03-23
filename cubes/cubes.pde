import java.awt.Color;
import sunflowapiapi.P5SunflowAPIAPI;
import org.sunflow.math.Point3;
import org.sunflow.math.Vector3;

int sceneWidth = 1200;
int sceneHeight = 600;
P5SunflowAPIAPI sunflow;

void setup() {
  size(sceneWidth, sceneHeight, "sunflowapiapi.P5SunflowAPIAPI");
  sunflow = (P5SunflowAPIAPI) g;
  sunflow.background(255);
//  sunflow.setSunSkyLight("mySunskyLight");
//  sunflow.setPointLight("myPointLight", new Point3(0,0,5), new Color(255,255,255));
//  sunflow.setDirectionalLight("myDirectionalLight", new Point3(-2,3,0), new Vector3(0,0,0), 3, new Color(1f,0f,0f));
//  sunflow.setSphereLight("mySphereLight", new Point3(0,0,-5), new Color(0,0,255), 32, 10);
//  
//  sunflow.setCameraPosition(0,0,10);
//  sunflow.setCameraTarget(10,10,1);
//   sunflow.setThinlensCamera("thinLensCamera", 50f, (float)sceneWidth/sceneHeight);

  drawCubes();

//  sunflow.setPathTracingGIEngine(64);
//  sunflow.render(sketchPath + "/CubeSunflowRender.png"); 
}

void drawCubes() {
  background(255);
  lights();
  noStroke();
  float xNoise = random(10);
  float yNoise = random(10);
  rotateX(radians(0));
  translate(-100,0,-50);
  float rotatePlane = 0;

  for (int y = 0; y < 10; y += 1) {
    pushMatrix();
//    rotateY(radians(rotatePlane));
    for (float x = 0; x < 200; x+= 0.5) {

      float h = random(2);//
      float w = random(0.5,1); //random(1,2);
      float d = random(4);//noise(xNoise,yNoise) * 4;


      pushMatrix();
        translate(x,y,(sin(x)*5));
              println("X: " + x + ", Y: " + y);
        fill(random(50,200),random(50,200),random(50,200));
        box(w,h,d);
//        sphere(1);
        println("W: " + w + ", H: " + h + ", D: " + d);
      popMatrix();
//      x += w;


    }
    rotatePlane += 1.5;
    popMatrix();
  } 
}

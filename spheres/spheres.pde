import org.sunflow.math.Point3;
import org.sunflow.math.Vector3;

//import processing.core.*;
import sunflowapiapi.*;

private boolean render = false;
private P5SunflowAPIAPI sunflow ;


void setup() {

  size(800, 800,"sunflowapiapi.P5SunflowAPIAPI");
  sunflow = (P5SunflowAPIAPI) g;
  sunflow.background(128);
  
  background(0);
//  lights();
  pointLight(255,255,255,0,height/8,-150);
  translate(0, height/8,-150);
  
  
  float sphereSize = 5;

  //First Sphere Plane
  drawSpherePlane(-PI/4,sphereSize);
  //Second SPhere Plane
  drawSpherePlane(-3*PI/4,sphereSize);

  if (render) {
    sunflow.setPathTracingGIEngine(16);
    sunflow.render(sketchPath + "/SpheresSunflow" + second()+".png");            // this will be rendered into the applications folder.
  }
}

void drawSpherePlane(float rotateAngle, float sphereSize) {
  pushMatrix();
    rotateZ(rotateAngle);
    for (int z = 0; z > -(sphereSize * 50); z -= (sphereSize * 2)) {
      
  //    rotateZ(radians(0.5));  
      for (int x = 0; x < (sphereSize * 50); x+= (sphereSize * 2)) {
      
      
        fill(128);
        println("("+x+","+ z+ ")");
        pushMatrix();
          translate(x,0,z);
          noStroke();
          fill(255);
          sphere(sphereSize);
//          sunflow.drawSphere("sphere"+random(12313254),x,0,z,sphereSize);
        popMatrix();  
      }
    }
  popMatrix();
}

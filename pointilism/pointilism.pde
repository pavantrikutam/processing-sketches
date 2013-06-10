
import java.util.*;
import java.io.*;
PicClr[] colors;

PImage photo;

int miniWidth;
int miniHeight;

int scaleFactorX = 80;
int scaleFactorY = 60;

boolean pixelate = false;
public class PicClr {
   color integer;
   String filename;
   PicClr(color intgr, String flnm) {
    integer = intgr;
    filename = flnm;
  } 
  
  String toString() {
    return filename + ": " + green(integer); 
  }
}

public class PicClrComparator implements Comparator<PicClr> {

    @Override
    public int compare(PicClr o1, PicClr o2) {
      
      float o1p = (int(red(o1.integer)) & 0xFF) << 24 |
              (int(blue(o1.integer)) & 0xFF) << 16 |
              (int(green(o1.integer)) & 0xFF) <<  8 |
              (255 & 0xFF); // 255 is alpha value
              
      float o2p = (int(red(o2.integer)) & 0xFF) << 24 |
              (int(blue(o2.integer)) & 0xFF) << 16 |
              (int(green(o2.integer)) & 0xFF) <<  8 |
              (255 & 0xFF); // 255 is alpha value
      
      println("o1p: " + o1.toString() + ", o2p: " + o2p);
      
      if (o1 == null) {
        println("o1 Null!");
      } 
      if (o2 == null) {
       println("o2 null!"); 
      }
      
        if (o1p > o2p) {
          println("GREATER");
          return 1; 
        } else if (o1p == o2p) {
          println("EQUAL");
          return 0;
        } else {
          println("LESS THAN");
          return -1; 
        }
    }
}





void setup() {
  String photoPath  = "/Users/pavan/Pictures/Pointilism/seasia/PB190309-shadows-highlighting-photofilter.jpg";
  photo = loadImage(photoPath);
  miniWidth = photo.width / scaleFactorX;
  miniHeight = photo.height / scaleFactorY;
  println(miniWidth+"x"+miniHeight);
  photo.loadPixels(); 

  size(photo.width, photo.height);
  loadPoints();
  drawPhoto();  
}


void loadPoints() {
 //  String path = "/Users/pavan/Pictures/Pointilism/seasia/PB240524.JPG";
  File directory = new File("/Users/pavan/Pictures/Pointilism/honduras/");
//  File directory = new File("/Users/pavan/Pictures/My Photos - Unfiltered/2011 - Honduras/");
  File[] pics = directory.listFiles(new FilenameFilter() {
    public boolean accept(File directory, String fileName) {
        return fileName.endsWith(".JPG");
    }
});
  colors = new PicClr[pics.length];
  for (int i = 0; i < pics.length; i++) {
    

    if (pics[i].getName().contains("JPG")) {
      println("I: " + (i + 1) + " of " + pics.length);
      PImage pointPhoto = loadImage(pics[i].getAbsolutePath());
      colors[i] = new PicClr(getColor(pointPhoto,0,0,pointPhoto.width,pointPhoto.height),pics[i].getAbsolutePath()); 
    } else {
       println("NOT LOADING: " + i); 
    }
  }
  
  println("Sorting colors.");
  
  Arrays.sort(colors, new PicClrComparator());
  println("SORTED"); 
}

void drawPhoto() {
  
  for (int y = 0; y < photo.height; y += miniHeight) {
    for (int x = 0; x < photo.width; x += miniWidth) {

      color boxColor = getColor(photo,x,y, miniWidth, miniHeight);
      
      
      
      if(pixelate) {
        fill(boxColor);
        rectMode(CORNER);
        rect(x,y,miniWidth,miniHeight);  
      } else {
       String path = findClosestPhoto(boxColor,0,colors.length-1);
       println("("+x+","+y+"): " + path);
       PImage closePhoto = loadImage(path);
       image(closePhoto,x,y,miniWidth,miniHeight);
      }
    }
  }
  
  println("Photo drawing complete!");
    int d = day();    // Values from 1 - 31
  int m = month();  // Values from 1 - 12
  int y = year();   // 2003, 2004, 2005, etc.
   int s = second();  // Values from 0 - 59
  int mi = minute();  // Values from 0 - 59
  int h = hour();    // Values from 0 - 23
  save("pointilism"+d+"."+m+"."+y+"-"+h+"-"+mi+"-"+s+".png");
}

color getColor(PImage img, int originx, int originy, int picWidth, int picHeight) {
  float red = 0;
  float green = 0;
  float blue = 0;
  int maxx = originx+picWidth;
  int maxy = originy+picHeight;
//  println(maxx+","+maxy+")");
  for (int x = originx; x < (maxx); x++) {
    for (int y = originy; y < (maxy); y++) {
//      red += img.pixels[y*picWidth+x] >> 16 & 0xFF;  
      red += img.get(x,y) >> 16 & 0xFF;;
      green += img.get(x,y) >> 8 & 0xFF;
      blue += img.get(x,y) & 0xFF;
    }
  }
//  println("Red, Green, Blue: (" + red + ", " + green + ", " + blue + ")");
  red =  red / (picWidth*picHeight);
  green = green / (picWidth*picHeight);
  blue = blue / (picWidth*picHeight); 
  //  println("Path: " + path); 
//  println("Red, Green, Blue: (" + red + ", " + green + ", " + blue + ")");
  
  return color(red,green,blue);
}


String findClosestPhoto(color clr, int min, int max) {
//  println("MIN: " + min + ", MAX: " + max);
   if (max < min ) {
//     println("MAX LESS THAN MIN: " + colors[max].filename);
     if (max < 0) {
       max = 0;
     }
     return colors[max].filename;
   }
   int mid = (min + max) / 2;
   float clrNum = (int(red(clr)) & 0xFF) << 24 |
              (int(blue(clr)) & 0xFF) << 16 |
              (int(green(clr)) & 0xFF) <<  8 |
              (255 & 0xFF); // 255 is alpha value
              
   float midNum = (int(red(colors[mid].integer)) & 0xFF) << 24 |
              (int(blue(colors[mid].integer)) & 0xFF) << 16 |
              (int(green(colors[mid].integer)) & 0xFF) <<  8 |
              (255 & 0xFF); // 255 is alpha value
      
              
   if (midNum > clrNum) {
     return findClosestPhoto(clr,min,mid-1);
   } else if (midNum < clrNum) {
     return findClosestPhoto(clr,mid+1,max);
   } 
//   println("PATH IS: " + colors[mid].filename);
   return colors[mid].filename; 
} 

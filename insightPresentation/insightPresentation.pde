import SimpleOpenNI.*;

SimpleOpenNI  context;
PImage img;
int irW,irH;

PGraphics g;

void setup()
{
  context = new SimpleOpenNI(this);
  context.enableDepth();
  context.setMirror(true);
  context.enableUser();
  if(context.isInit() == false)
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }
  size(640, 480, P2D);
  
  g = createGraphics(width,height, P2D);

  img = new PImage(640,480); 
  img.loadPixels();

}

void draw()
{
  background(244,90,10);
  context.update();

  int[] u = context.userMap();
  for(int i =0;i<u.length;i++){
    if(u[i]==0){
      img.pixels[i] = color(0);
    }
    else  {
      img.pixels[i] = color(255,0,0,0);
    }
  }
   
  img.updatePixels(); 
  g.beginDraw();
  g.background(0);
  g.image(img, 0, 0);
  g.endDraw();
  
  blend(g,0,0, width,height, 0,0,width,height,MULTIPLY);
  
}


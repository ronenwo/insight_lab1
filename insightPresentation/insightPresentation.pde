import SimpleOpenNI.*;

SimpleOpenNI  context;
PImage img;
int irW,irH;


void setup()
{
  context = new SimpleOpenNI(this);
  context.enableDepth();
  context.enableUser();
  if(context.isInit() == false)
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }
  size(640, 480);

  img = new PImage(640,480); 
  img.loadPixels();

}

void draw()
{
  context.update();

  int[] u = context.userMap();
  for(int i =0;i<u.length;i++){
    if(u[i]==0){
      img.pixels[i] = color(0);
    }
    else  {
      img.pixels[i] = color(255,0,0);
    }
  }
   
  img.updatePixels(); 
  image(img, 0, 0);
}


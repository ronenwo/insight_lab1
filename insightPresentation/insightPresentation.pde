import SimpleOpenNI.*;

SimpleOpenNI  context;
import processing.video.*;

String PATH = "wind2.mov";
Movie mov;

PImage imgKinect, imgMov;
int irW,irH;

PGraphics g , dest, back;

PVector pos = new PVector();//this will store the position of the user
float lastDistance = 3000;
float currentScale = 1.0; 

void setup()
{
  mov = new Movie(this, PATH);
  mov.play();

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
  dest = createGraphics(width,height, P2D);
  back = createGraphics(width,height, P2D);
  
  

  imgKinect = new PImage(640,480); 
  imgKinect.loadPixels();

//  img0 = loadImage("oranges.jpg");
//  img0.resize(width,height);
  
  imgMov = createImage(width,height,RGB);
  
}

void draw()
{
  background(0,0);
//  background(0,255,0);
//  back.beginDraw();
//  back.background(100,100,100,255);
//  back.endDraw();
  
  context.update();

  int[] u = context.userMap();
  for(int i =0;i<u.length;i++){
//    context.getCoM(u[i],pos);//store that user's position
    if(u[i]==0){
      imgKinect.pixels[i] = color(0);
    }
    else  {
      imgKinect.pixels[i] = color(255);
    }
  }
   
  imgKinect.updatePixels(); 

//  float dif = lastDistance - pos.z / pos.z; 
//  // check if
//  if ( abs(dif) > 0.01 ){
//     
//    if (dif>0){
//      currentScale = dif * 100;
//    }
//    else {
//      currentScale = (100-dif) * 100;
//    }    
//  }



  g.beginDraw();
  g.background(0);
  g.image(imgKinect, 0, 0);
  g.endDraw();
  
  dest.beginDraw();
  dest.image(mov, 0, 0, width, height);
//  dest.scale(currentScale);
  dest.blend(g,0,0, width,height, 0,0,width,height,MULTIPLY);
  dest.endDraw();

//  back.beginDraw();
//  back.copy(dest,0,0, width,height, 0,0,width,height);  
////  back
//  back.endDraw();

  
//  dest.blend(g,0,0, width,height, 0,0,width,height,MULTIPLY);
//  
//  img0.mask(img);
//  image(img0,0,0);

//  image(back,0,0);
  
  image(dest,0,0);
}

void movieEvent(Movie m) {
  m.read();
}



import processing.video.*;

Capture video;
PImage img;
Boolean videoInit = false;

PShader myShader;

void setup() {
  size(640, 360, P2D);
  frameRate(30);
  noStroke();
  
  img = loadImage("image.jpg");
 
  
  // Uses the default video input, see the reference if this causes an error
  video = new Capture(this, width, height);
  video.start();
  
 
  myShader = loadShader("shader.glsl");
  
  myShader.set("resolution", float(width), float(height));   
  myShader.set("iChannel0", img);
}

void draw() {
  background(0,255,0);
  
  myShader.set("time", millis() / 1000.0);
  
  if (video.available() == true) {
    videoInit = true;
  }
  
  if(videoInit == true) {
    video.read();
    myShader.set("iChannel0", video);
  }
  else {
    myShader.set("iChannel0", img);
  }
  
  shader(myShader);

  rect(0, 0, width, height); 
}


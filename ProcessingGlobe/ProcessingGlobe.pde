import processing.serial.*;

Serial myPort;

PImage earth; 
PShape globe;

float x=0;
float y=0;
float z=0;

void setup() {
  myPort = new Serial(this, "COM17", 9600);
  
  noStroke();
  size(600, 600, P3D);
  
  earth = loadImage("https://7thunders.biz/assets/tex-globe.png");
  globe = createShape(SPHERE, 200); 
  globe.setTexture(earth);
} 

void draw() {  
  background(0);
  lights();

  getAngles();

  pushMatrix();
  fill(0,255,0);
  translate(width/2,height/2,-100);
  rotateX(radians(y));
  rotateY(radians(x));
  rotateZ(radians(z));

  //box(200,100,200); 
  shape(globe);
  popMatrix(); 
}

void getAngles() { 
  String inString = myPort.readStringUntil('\n');
    
  if(inString == null || inString == "")
    return;
  
  String[] inStrings = split(inString, ',');
  
  if(inStrings.length != 3)
    return;
 
  x=float(inStrings[0]);
  y=float(inStrings[1]);
  z=float(inStrings[2]);
  
  print(x);
  print(" ");
  print(y);
  print(" ");
  println(z);
}

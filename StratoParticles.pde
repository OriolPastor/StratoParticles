
// Sketch by Oriol Pastor www.oriolpastor.com
import java.util.*;

// A bunch of possible textures
PImage textures = new PImage();
// Which texture
int currentTex = 2;
// Our planet PShape
PShape planet;

// A particle system
ParticleSystem ps;

ParticleSystem s;
// Image for particle
PImage sprite;  
PImage sprite2;  
// A "glow" atmosphere image
PImage glow;

// current state
boolean glowing = true;
boolean sphere = true;
boolean particles = true;
boolean particleTex = true;

// Very lame not arcball rotation
float rotX, rotY;

//float r = 200;
float r = 100;

int type=0;

float xoff=0.0;


Random generator;

float theta = 0;
float Vrot = TWO_PI/800; //revolution speed in radians

float power=0.0;
int radius_white=0;
int radius_black=100;
PVector wind;

void setup() {
  size(800, 600, P3D);
  noStroke();
  fill(255);
  
  // Load images
  textures= loadImage("marble.jpg");
  glow = loadImage("glow.png");
  sprite = loadImage("sprite4.png");
  sprite2 = loadImage("sprite3.png");
  
  //Create system particles
  ps = new ParticleSystem(1,new PVector(width/6,height/6),1500);
  s = new ParticleSystem(2,new PVector(width/4,height/4),500);
}

void draw() {
  background(0);
  smooth();
  pushMatrix(); 
  translate(width/2, height/2);  
  lights();
  rotateY(rotX);
  rotateX(rotY);
  
  //SET PROPERTIES
  
  setPower(power);
  
  setWhiteCircle(radius_white);
  
  setWhiteGlow(radius_white);
  drawParticles(); 
  popMatrix();
  
   
  //DRAW HELPERS
  //drawFrameRate();
  text("Frame rate: " + int(frameRate) + 
  "\n1 to toggle bigger glow\n2 to toggle normal glow\n3 to toggle normal particles\n4 to toggle bigger particles\n5 to toggle particle texture\n6 to toggle mini particles movement\n7 to toggle mini particles", 10, 20);
  
    // Draw an arrow representing the wind force
  //drawVector(wind, new PVector(width/2,50,0),500);
  
  
}

/*
void drawFrameRate(){
  fill(255);
  textSize(16);
  // Draw an arrow representing the wind force
  drawVector(wind, new PVector(width/2,50,0),500);
  //text("Frame rate: " + int(frameRate),10,20);
  text("Frame rate: " + int(frameRate) + "\n1 to make bigger white sphere\n2 to reset white sphere size\n3 to reset black sphere\n4 to make bigger black sphere\n5 to toggle particle texture\n6 to spray\n7 to reset spray", 10, 20);
}
*/

// Renders a vector object 'v' as an arrow and a location 'loc'
/*
void drawVector(PVector v, PVector loc, float scayl) {
  pushMatrix();
  float arrowsize = 4;
  // Translate to location to render vector
  translate(loc.x,loc.y);
  stroke(0);
  // Call vector heading function to get direction (note that pointing up is a heading of 0) and rotate
  rotate(v.heading2D());
  // Calculate length of vector & scale it to be bigger or smaller if necessary
  float len = v.mag()*scayl;
  // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
  line(0,0,len,0);
  line(len,0,len-arrowsize,+arrowsize/2);
  line(len,0,len-arrowsize,-arrowsize/2);
  popMatrix();
}
*/

void drawParticles(){
    // Particles
  if (particles) {
    if (particleTex) {
      hint(DISABLE_DEPTH_MASK);
    }
    
    ps.update();
    
    s.applyForce(wind);
    s.update();
    
    ps.display();
    s.display();
    
    if (particleTex) {
      hint(ENABLE_DEPTH_MASK);
    }
  }
  
}


void setPower(float pow){
  
    theta = theta + Vrot;
    power=pow;
    
    //get cartesian from polar
    float dx = power * cos(theta);
    float dy = power * sin(theta);
    //modify angle by rotation amount
     
    wind = new PVector(dx,dy); 
    
}




void setWhiteGlow(int radius){
 // Unrotate to billboard glow
  rotateX(-rotY);
  rotateY(-rotX);
  if (glowing) {
    imageMode(CENTER);
    tint(255);
 
    
   image(glow, 0, 0, random(600,605)+radius, random(600,605)+radius);
   
  }
   
  
}


void setWhiteCircle(int radius){
    noStroke(); 
  ellipseMode(CENTER);
  
  float d= radius*0.4;
  planet = createShape(ELLIPSE,-250-d,-250-d,500+radius*0.9,500+radius*0.8); 
  // Start with a texture
  planet.setTexture(textures);
  
  // Sphere
  
  if (sphere) {
    shape(planet);
  }
    
} 



/*
// Renders a vector object 'v' as an arrow and a location 'loc'
void drawVector(PVector v, PVector loc, float scayl) {
  pushMatrix();
  float arrowsize = 4;
  // Translate to location to render vector
  translate(loc.x,loc.y);
  stroke(0);
  // Call vector heading function to get direction (note that pointing up is a heading of 0) and rotate
  rotate(v.heading2D());
  // Calculate length of vector & scale it to be bigger or smaller if necessary
  float len = v.mag()*scayl;
  // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
  line(0,0,len,0);
  line(len,0,len-arrowsize,+arrowsize/2);
  line(len,0,len-arrowsize,-arrowsize/2);
  popMatrix();
}

*/



void keyPressed() {
  if (key == '1') {
    
    radius_white=50;
  } 
  else if (key == '2') {
    
    radius_white=0;
  } 
  else if (key == '3') {
    
    radius_black=100;
  } 
  else if (key == '4') {
    
    radius_black=125;
  } 
  else if (key == '5') {
    particleTex = !particleTex;
  }
  else if (key == '6') {
    power=+0.5;
    Vrot = TWO_PI/2800;
  }
    else if (key == '7') {
    power=0.0;
    Vrot = TWO_PI/400;
    
  }
  
}

   




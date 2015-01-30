// classe Particula
// Circulo negro

class Particle {

  PVector position;
  PVector velocity;
  float lifespan = 255;
  PShape part;
  float partSize;

  PVector gravity = new PVector(0, 0.1);
  PVector location;
  
  PVector acc;
  
  float xoff=0.00;
  float xincrement = 0.01; 
  //int radius_black;

  Particle(PVector l) {
    location = l.get();
    position = new PVector();
    //tamaño particulas;
    partSize = random(width/50, width/30);
    rebirth();
    lifespan = random(127);
    
    //vector fuerzas
    acc = new PVector(0,0);
  }

  PShape getShape() {
    return part;
  }

  void rebirth() {
    float speed = random(0.1,0.5);
    velocity = PVector.random3D();
    velocity.mult(speed);
    lifespan = 127;   
    position = PVector.random3D();
    setRadius(radius_black);
    position.mult(radius_black);
    
    
  }

  void setRadius(int radius){
    radius_black= radius;
  }

  boolean isDead() {
    if (lifespan == 0) {
      return true;
    } 
    else {
      return false;
    }
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    // Unrotate to billboard particles
    rotateX(-rotY);
    rotateY(-rotX);
    if (particleTex) {
      imageMode(CENTER);
      tint(color(255, 255, 255, lifespan));
      image(sprite, 0, 0, partSize, partSize);
    } 
    else {
      stroke(255, lifespan);
      strokeWeight(partSize/4);
      point(0, 0);
    }
    popMatrix();
  }

  void update() {
    position.add(velocity);
    lifespan = lifespan - 4;
    if (lifespan < 0) {
      lifespan = 0; 
    }
  }
  
     // Method to apply a force vector to the Particle object
  // Note we are ignoring "mass" here
  void applyForce(PVector f) {
    acc.add(f);
  }  
  
  
}


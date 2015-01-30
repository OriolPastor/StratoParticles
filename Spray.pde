// classe Spray
// Spray


class Spray extends Particle {

  // We could add variables for only Confetti here if we so
  // Very lame not arcball rotation
  
  float r;
  PVector loc;
  PVector vel;
  
  Spray(PVector l){
    //super(l);
    super(l);
    
     //spray spread particles in this gaussian generator
     generator = new Random();
     //float vx = (float) generator.nextGaussian()*0.3;
     float vx = (float) generator.nextGaussian()*0.1;
     //float vy = (float) generator.nextGaussian()*0.3 - 1.0;
     float vy = (float) generator.nextGaussian()*0.1 - 1.0;
     vel = new PVector(vx,vy);
  
    partSize = random(width/70, width/50);
    lifespan = random(255);
    
  }




  // Inherits update() from parent
  
  PShape getShape() {
    return part;
  }

  
  void rebirth() {
    // spray velocity
    float speed = random(0.4, 3); 
    velocity = PVector.random3D();
    //multiply speed to velocity
    velocity.mult(speed);
    lifespan = 255;   
    position = PVector.random3D();
    position.mult(r*1.05);
    
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
      image(sprite2, 0, 0, partSize, partSize);
    } 
    else {
      stroke(255, lifespan);
      strokeWeight(partSize/4);
      point(0, 0);
    }
    popMatrix();
  }
  
  
  
   void update() {
      //add acceleration to velocity
     velocity.add(acc);
    
     //add velocity to position
     position.add(velocity);
    
    //spray lifespan particles
    lifespan = lifespan - 4;
    if (lifespan < 0) {
      lifespan = 0; 
    }
    
    acc.mult(0); // clear Acceleration
  }

  
}


// NOC Cosmos
// https://github.com/shiffman/The-Nature-of-Code-Cosmos-Edition

// Your standard NOC particle system

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  PShape particleShape;

  ParticleSystem(int type,PVector location,int n) {
    origin = location.get();
    particles = new ArrayList<Particle>();

   //tipo particula 1
   if (type ==1){
    for (int i = 0; i < n; i++) {
      Particle p = new Particle(origin);
      particles.add(p);
    }
   
   }else{
     //tipo particula Spray
    if(type==2){
      for (int i = 0; i < n/2; i++) {
        Spray s = new Spray(origin);
        particles.add(s);
      }
    }
   }
    
  }

  void update() {
    for (Particle p : particles) {
      p.update();
      if (p.isDead()) {
        p.rebirth();
      }
    }
  }
  
  void applyForce(PVector dir) {
    for (Particle p: particles) {
      p.applyForce(dir);
    }
  
  }   

  void display() {

    for (Particle p : particles) {
      p.display();
    }
  }
}


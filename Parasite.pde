
public class Parasite extends Organism implements Hunt {


  ArrayList<Organism> organisms;
  Organism prey;
  boolean feeding = false;
  float socialMovement = 0.2;

  public Parasite(ArrayList<Organism> o) {
    //super (o);
    organisms = o;
    setParameters();
  }

  public Parasite(ArrayList<Organism> o, double x, double y) {
    pos = new PVector((float)x, (float)y);
    vel = new PVector(random(-1, 1), random(-1, 1));
    organisms = o;
    setParameters();
  }

  public Parasite(ArrayList<Organism> o, PVector p) {
    organisms = o;
    pos = new PVector(p.x, p.y);
    setParameters();
  }

  private void setParameters() {
    vel = new PVector();
    sizeFactor = 2;//2 makes it half size
    minEnergy = 5;
    energyLevel = minEnergy;
    sight = 200;
    reproductionEnergy = 8;
    reproductionEnergyMantained = 18;
    growthRate = 0.86;
    eatSpeed = 0.16;
    speed = 3.2;
    maxAge = 650;
    decayRate = 0.04;
    col = color(220, 150,150,110);
    dCol = color(110,75,75,110);
    // siz = energyLeel
  }

  public void drawSelf() {
    siz = (float)((energyLevel+minEnergy)/sizeFactor);
    ellipse(pos.x, pos.y, siz, siz);
  }

  public void update() {
    drawSelf();
    age();
    decay();
    killSelf();
    if (isAlive) {
      eat();
      move();
      reproduce();
      if (!feeding) {
        hunt();
      }
    }
  }

  public void decay() {
    if (!isAlive) energyLevel -= decayRate;
    else energyLevel -= decayRate;//can keep use a parameter
  }

  protected void age() {
    age++;
  }

  public void eat() {
    if (frameCount%20==0) {
      prey = null;
    }
    if (prey!=null && prey.isAlive) {//is the prey alive and still in the list?
      if (PVector.dist(pos, prey.pos) < (prey.siz + siz)/2.) {//are we touching it?
        feeding = true; //then we are feeding
        vel.mult(0.8);//slow down and feast
        prey.energyLevel-=eatSpeed;//drain its energy
        energyLevel+= growthRate * eatSpeed;//we get some that energy
        if (prey.energyLevel <= minEnergy*0.4) {//check to see if we killed it
          organisms.remove(prey);//if so wipe it off the list
          prey = null;
        }
      } else {
        feeding = false;
      }
      if (!organisms.contains(prey)) {
        feeding = false;
      }
    }//end prey is alive
  }//end eat


  public void move() {
    for (int i = 0; i < organisms.size (); i++) {
      Organism o = organisms.get(i);
      if (o instanceof Parasite && o.isAlive) {
        if (PVector.dist(pos, o.pos) < sight/2 && !feeding) {
          PVector socialVector = new PVector(pos.x - o.pos.x, pos.y - o.pos.y);
          socialVector.normalize();
          socialVector.mult(socialMovement);
          vel.add(socialVector);
        }
      }
    }
    pos.add(vel);
  }

  public void reproduce() {
    if (this.energyLevel > reproductionEnergyMantained) {
      PVector birthV = PVector.random2D();
      birthV.mult((float)energyLevel);
      birthV.add(pos);
      Parasite newPara = new Parasite(this.organisms, birthV);
      this.organisms.add(newPara);
      this.energyLevel -= this.reproductionEnergy;
      System.out.println("Reproducing");
    }
  }

  public void killSelf() {
    if (energyLevel <= minEnergy*0.5) {
      isAlive =  false; 
      organisms.remove(this);
    }
    if (age > maxAge) isAlive = false;
  }

  public void hunt() {
    if ((!organisms.contains(prey) && !feeding)||prey==null) {
      Organism prey = locatePrey();
    }
    chasePrey(prey);
  }


  public Organism locatePrey() {
    double distanceToPrey = (float)sight;
    for (int i = 0; i < organisms.size (); i++) {
      Organism o = organisms.get(i);
      if (o instanceof Scavenger && o.isAlive) {
        if (PVector.dist(pos, o.pos) < distanceToPrey) {
          prey = o; 
          distanceToPrey = PVector.dist(pos, o.pos);
        }
      } else if (o instanceof PlantEater && o.isAlive) {
        if (PVector.dist(pos, o.pos) < distanceToPrey) {
          prey = o; 
          distanceToPrey = PVector.dist(pos, o.pos);
        }
      }
    }
    return prey;
  }

  public void chasePrey(Organism o) {
    if (o != null) {
      vel.set((o.pos.x - pos.x), (o.pos.y - pos.y));
      vel.normalize();
      vel.mult(speed);
    }
  }

  public void killPrey(Organism o) {
  }
}


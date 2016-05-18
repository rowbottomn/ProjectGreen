
public class Scavenger extends Organism implements Hunt{

  ArrayList<Organism> organisms = new ArrayList<Organism>();
  Organism prey;

  int count = 0;
  float socialMovement = 6.5;
  
  public Scavenger(ArrayList<Organism> o){
    organisms = o;
    setParameters();
  }
  
  public Scavenger(ArrayList<Organism> o,double x, double y){
   pos = new PVector((float)x, (float)y);
   vel = new PVector(random(-1,1), random(-1,1));
   organisms = o;
   setParameters();
   
  }

  public Scavenger(ArrayList<Organism> o,PVector p){
   pos = p;
   vel = new PVector(random(-1,1), random(-1,1));
   organisms = o;
   setParameters();
   
  }
    
  private void setParameters(){
    energyLevel = 50;
    reproductionEnergy = 50;
    reproductionEnergyMantained = 70;
    maxAge = 350;
    
        isAlive = true;
    sizeFactor = 5.;
    social = 1.;
    //travelFrames = 20;
    growthRate = 0.55;
    decayRate = -0.03;
    minEnergy = 40;
    energyLevel = minEnergy;
    reproductionEnergy = minEnergy*4.;
    reproductionEnergyMantained = 500;
    sight = 150;
    speed = 3;
    siz = ((float)(energyLevel/sizeFactor));
    vel = new PVector(random(-social, social+1), random(-social, social+1));
   // hunger = 0;
   // col = color(80,160,215,100);
    maxAge = 3000;
  }

  public void drawSelf(){
//    if(feeding){
//      fill(180,160,15,110);
//       ellipse(pos.x, pos.y, (int)energyLevel, (int)energyLevel);
//    }else{
//      fill(68,134,227,110);
//       ellipse(pos.x, pos.y, (int)energyLevel, (int)energyLevel);
//    }
      fill(180,160,15,110);
      ellipse(pos.x, pos.y, (int)energyLevel, (int)energyLevel);
  }
  
  public void update(){
    drawSelf();
    decay();
     killSelf();
    if(isAlive){
      eat();
      move();
  //    age();
     reproduce();
      if(!feeding){
        hunt();
      }  
    }
  }
  
  public void decay(){
    if(isAlive) energyLevel -= decayRate;
    age++;
  }
  
  public void eat(){
    if(prey!=null){
      if(PVector.dist(pos, prey.pos) < 10){
        feeding = true;
        vel.set(0,0);
        prey.energyLevel-=0.2;energyLevel+=0.2;
      }else{
        feeding = false;
      }
      if(!organisms.contains(prey))feeding = false;
    }
  }
  
  public void move(){
    for(int i = 0; i < organisms.size();i++){
      Organism o = organisms.get(i);
      if(o instanceof Scavenger && !o.equals(this)){
        if(PVector.dist(pos, o.pos) < siz && !feeding){
            PVector socialVector = new PVector(pos.x - o.pos.x, pos.y - o.pos.y);
            socialVector.normalize();
            socialVector.mult(socialMovement);
            vel.add(socialVector);  
            //System.out.println("Social Vel Set");
         
        }
      }
    }
    pos.add(vel);
      
  }
  
//  public void age(){
  //  age+=0.1;
 // }
  
  public void reproduce(){
     if(this.energyLevel > reproductionEnergyMantained){
       PVector birthV = PVector.random2D();
       birthV.mult((float)energyLevel);
       birthV.add(pos);
      Scavenger newScavenger = new Scavenger(this.organisms, birthV.x, birthV.y);
      this.organisms.add(newScavenger);
      this.energyLevel -= this.reproductionEnergy;
      //System.out.println("Reproducing");
    }
  }
  
  public void killSelf(){
      if(energyLevel <= 0) isAlive =  false;
      if(age > maxAge) isAlive = false;  
     if(!isAlive){ organisms.remove(this); System.out.println("Scavenger Removed");}
  }
  
  public void hunt(){
  if((!organisms.contains(prey) && !feeding)||prey==null) {
    Organism prey = locatePrey();
    count++;
   
  }
    chasePrey(prey);
  }
    
  
  public Organism locatePrey(){
    float distanceToPrey = 250;
    for(int i = 0; i < organisms.size();i++){
      Organism o = organisms.get(i);
      if(!o.isAlive){
        if(PVector.dist(pos, o.pos) < distanceToPrey){prey = o; distanceToPrey = PVector.dist(pos, o.pos);}
      }
    }
    return prey;
  }
  
  public void chasePrey(Organism o){
   if(o != null){
      vel.set((o.pos.x - pos.x), (o.pos.y - pos.y));
      vel.normalize();
      vel.mult(5);
   }
  }
  
  public void killPrey(Organism o){
    
  }
    
}

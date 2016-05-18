
public class Parasite extends Organism implements Hunt{
  
 
  ArrayList<Organism> organisms;
  Organism prey;
  boolean feeding = false;
  int count = 0;
  float socialMovement = 5.5;
  
  public Parasite(ArrayList<Organism> o){
    //super (o);
    organisms = o;
    setParameters();
  }
  
  public Parasite(ArrayList<Organism> o,double x, double y){
   pos = new PVector((float)x, (float)y);
   vel = new PVector(random(-1,1), random(-1,1));
   organisms = o;
   setParameters();
   
  }
  
  public Parasite(ArrayList<Organism> o, PVector p){
    organisms = o;
    pos = new PVector(p.x,p.y);
    setParameters();    
  }
    
  private void setParameters(){
    vel = new PVector();
    energyLevel = 8;
    sight = 200;
    reproductionEnergy = 14;
    reproductionEnergyMantained = 24;
    growthRate = 0.60;
    eatSpeed = 0.08;
    speed = 3.2;
    maxAge = 400;
  }

  public void drawSelf(){
    if(feeding){
      fill(134,16,142,110);
       ellipse(pos.x, pos.y, (int)energyLevel, (int)energyLevel);
    }else{
      fill(176,16,16,110);
       ellipse(pos.x, pos.y, (int)energyLevel, (int)energyLevel);
    }
  }
  
  public void update(){
   // System.out.println(vel.toString());
  // System.out.println(isAlive);
  //System.out.println(energyLevel);
  System.out.println("Prey set: " + count + " Feeding: " + feeding);
    drawSelf();
    decay();
   killSelf();
    if(isAlive){
      eat();
      move();
      reproduce();
      if(!feeding){
        hunt();
      }  
    }
  }
  
  public void decay(){
    if(isAlive) energyLevel -= 0.01;
  }
  
  public void eat(){
    if(prey!=null){
      if(PVector.dist(pos, prey.pos) < (prey.siz + energyLevel)/2){
        feeding = true;
        vel.set(0,0);
        //if(prey instanceof Scavenger){
        //  prey.energyLevel-=0.2;
          prey.energyLevel-=eatSpeed;
          energyLevel+=eatSpeed/2;
          //energyLevel+= growthRate * prey.energyLevel;
           if (prey.energyLevel <= 0) {
              organisms.remove(prey);
              prey = null;
           }
        //}
        }else{
          feeding = false;
      }
      if(!organisms.contains(prey))feeding = false;
    }
  }
  
  
  public void move(){
    for(int i = 0; i < organisms.size();i++){
      Organism o = organisms.get(i);
      if(o instanceof Predator){
        if(PVector.dist(pos, o.pos) < 15 && !feeding){
            PVector socialVector = new PVector(pos.x - o.pos.x, pos.y - o.pos.y);
            socialVector.normalize();
            socialVector.mult(socialMovement);
            vel.add(socialVector);  
         
        }
      }
    }
    pos.add(vel);
      
  }
  
  public void reproduce(){
     if(this.energyLevel > reproductionEnergyMantained){
       PVector birthV = PVector.random2D();
       birthV.mult((float)energyLevel);
       birthV.add(pos);
      Predator newPredator = new Predator(this.organisms, birthV);
      this.organisms.add(newPredator);
      this.energyLevel -= this.reproductionEnergy;
      System.out.println("Reproducing");
    }
  }
  
  public void killSelf(){
      if(energyLevel <= minEnergy*0.5) {isAlive =  false; organisms.remove(this);}
      if(age > maxAge) isAlive = false;   
  }
  
  public void hunt(){
  if((!organisms.contains(prey) && !feeding)||prey==null) {
    Organism prey = locatePrey();
    count++;
   
  }
    chasePrey(prey);
  }
    
  
  public Organism locatePrey(){
    double distanceToPrey = (float)sight;
    for(int i = 0; i < organisms.size();i++){
      Organism o = organisms.get(i);
        if(o instanceof Scavenger){
          if(PVector.dist(pos, o.pos) < distanceToPrey){prey = o; distanceToPrey = PVector.dist(pos, o.pos);}
        }
        else if(o instanceof PlantEater){
          if(PVector.dist(pos, o.pos) < distanceToPrey){prey = o; distanceToPrey = PVector.dist(pos, o.pos);}
        }

      
    }
    return prey;
  }
  
  public void chasePrey(Organism o){
   if(o != null){
      vel.set((o.pos.x - pos.x), (o.pos.y - pos.y));
      vel.normalize();
      vel.mult(speed);
   }
  }
  
  public void killPrey(Organism o){
    
  }
    
}

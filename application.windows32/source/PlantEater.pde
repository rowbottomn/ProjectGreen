
public class PlantEater extends Organism implements Hunt{
  
  ArrayList<Organism> organisms;  
  float minEnergy;
  PVector vel;
  float social;
  int travelFrames; 
  int maxAge;
  float siz;
  float speed;
  float sight;
  float hunger;
  color col;
  
  public PlantEater(ArrayList<Organism> o){
    organisms = o;
    setParameters();
  }
  
  public PlantEater(ArrayList<Organism> o,double x, double y){
    organisms = o;
    pos = new PVector((float)x,(float)y);
    setParameters();
  }

  public PlantEater(ArrayList<Organism> o, PVector p){
    organisms = o;
    pos = new PVector(p.x,p.y);
    setParameters();    
  }
    
  private void setParameters(){
    isAlive = true;
    sizeFactor = 5.;
    social = 1.;
    travelFrames = 20;
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
    hunger = 0;
    col = color(80,160,215,100);
    maxAge = 3000;
  }
  
  public void drawSelf(){
    fill(215,160,80,100);
    if (!isAlive){
        fill(40,40,40, 80);
    }
    ellipse(pos.x, pos.y, siz, siz);
  }
  
  public void update(){
    drawSelf();
    decay();
    killSelf();
    if(isAlive){
      move();
      eat();
      reproduce();
      age();
    }
    
  }
  
  protected void age(){
    age++; 
    siz = (float)((energyLevel+100)/sizeFactor);
  }
  
  public void decay(){
    energyLevel += decayRate;
  }
  
  public void eat(){
    //go through all the organsisms
    for (int i = 0; i < organisms.size();i++){
      Organism o = organisms.get(i);
     // if (o instanceof Plant && pos.dist(o.pos)<(siz+o.siz)/2.8){
        if (o instanceof Plant && pos.dist(o.pos)<(siz+o.energyLevel)/2.8){
        //if touching a plant
         energyLevel += growthRate*o.energyLevel;
         o.energyLevel -= energyLevel; 
         siz = ((float)(energyLevel/sizeFactor));
            //take all its energy 
            //and remove it from the list
            organisms.remove(o);
      }
    }
  }
  
  public void move(){
    if (age%travelFrames == 0){
      PVector temp = new PVector();
      float tempSpeed = 30. *speed / (float)(siz + 150.); 
      //go thru all the organisms 
      vel.set(0,0);
      for (Organism a : organisms){
         if (a instanceof Plant && pos.dist(a.pos)< sight){
           
           temp.set(a.pos); 
           temp.sub(pos);
           temp.mult(sight/temp.magSq());
           vel.add(temp);
           //print("step"+vel.mag());
         }       
      }
      vel.normalize();  
      vel.mult(tempSpeed);
    }
    pos.add(vel);
    energyLevel -= vel.mag()*siz/500;
  }  
  
  public void reproduce(){
     PVector birthVector = PVector.random2D(); 
     if(this.energyLevel > reproductionEnergyMantained){
      //double posX = int(random(width-70));
      //double posY = int(random(height-80));
      this.energyLevel -= this.reproductionEnergy;
      birthVector.mult(siz);
      birthVector.add(pos);
      this.organisms.add(new PlantEater(this.organisms, birthVector));
    }
  }
  
  public void killSelf(){
      if(energyLevel <= minEnergy*0.5) {isAlive =  false; organisms.remove(this);}
      if(age > maxAge) isAlive = false;
      
  }
  
  public Organism locatePrey(){
    return null;
  }
  
  public void chasePrey(Organism o){
  }
  
  public void killPrey(Organism o){
    
  }
    
}

public class Predator extends Parasite implements Hunt{
  
   ArrayList<Organism> organisms = new ArrayList<Organism>();
  Organism prey;

  int count = 0;
  float socialMovement = 6.5;
  
  public Predator(ArrayList<Organism> o){
      super(o);  
    setParameters();  
  }
  
//  public Predator(ArrayList<Organism> o,double x, double y){
//    suoper
   
//  }

  public Predator(ArrayList<Organism> o,PVector p){
    super(o, p);
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
    col = color(180,160,15,110);
    dCol = color(90,80,8, 110);
  }

  public void age(){
        
  }
  public void drawSelf(){

    siz = (float)((energyLevel+minEnergy)/sizeFactor);
    ellipse(pos.x, pos.y, siz, siz);

  }
  
  public void update(){
    drawSelf();
    decay();
     killSelf();
    if(isAlive){
      eat();
      move();
      age();
     reproduce();
      if(!feeding){
        hunt();
      }  
    }
  } 
  
  
  
  
}

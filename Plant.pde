
public class Plant extends Organism{
  
  ArrayList<Organism> organisms;
  
  public Plant(ArrayList<Organism> o){
    this.organisms = o;
    setParameters();
    pos = new PVector(width/2.0, height/2.0);
   
  }
  
  public Plant(ArrayList<Organism> o, double x, double y){
    this.organisms = o;
    setParameters();
    pos = new PVector((float)x,(float)y);
  }
  
  public Plant(ArrayList<Organism> o, PVector p){
    this.organisms = o;
    setParameters();
    pos = p;
  }
  private void setParameters(){
    sizeFactor = 2;//Not used
    energyLevel = 20;
    growthRate = random(0.2)+0.1;
    decayRate = -0.05;
    reproductionEnergy = 40;
    reproductionEnergyMantained = 50;
    age = 0;
    siz = (float)energyLevel;
  }

  public void update(){
    drawSelf();
    decay();
    killSelf();
    if(isAlive){
      eat();
      reproduce();
      age();
    }
  }
  
  public void drawSelf(){
     if(isAlive){fill(0,255,0,110); /*System.out.println("Alive Plant Drawn");*/}
     else {fill(0,0,0,110);/*System.out.println("Dead Plant Drawn");*/ }
     ellipse(pos.x, pos.y, (int)energyLevel, (int)energyLevel);
     
  }
  
  public void age(){
    age += 0.1;
    siz = (float)energyLevel;
    //if(!this.isAlive) System.out.println("Aging while dead");
  }
  
  public void decay(){
   energyLevel += decayRate; 
   //else {energyLevel -= 0.1; /*System.out.println("Decaying while dead");*/}
  }
  
  public void eat(){
    double areaCovered = 0;
    for(int i = 0; i < organisms.size();i++){
      Organism organism = organisms.get(i);
      if(organism instanceof Plant){
         float selfRadius = (float) energyLevel/2;
         float organismRadius = (float) organism.energyLevel/2;
        if(!this.equals(organism)){
           areaCovered += areaOfIntersection(this.pos.x, this.pos.y, selfRadius, organism.pos.x, organism.pos.y, organismRadius);
        }
      }
    
    }
    double circleArea = PI * Math.pow((energyLevel/2), 2);
    if(circleArea >= 10){energyLevel += (1-(areaCovered/circleArea)) * growthRate;}
    System.out.println("Circle Area: " + circleArea);
    
  }
  
  private double areaOfIntersection(float x0, float y0, float r0, float x1, float y1, float r1){
   double rr0 = r0 * r0;
   double rr1 = r1 * r1;
   double d = Math.sqrt((x1 - x0) * (x1 - x0) + (y1 - y0) * (y1 - y0));

    // Circles do not overlap
    if (d > r1 + r0)
    {
      return 0;
    }
  
    // Circle1 is completely inside circle0
    else if (d <= Math.abs(r0 - r1) && r0 >= r1)
    {
      // Return area of circle1
      return Math.PI * rr1;
    }
  
    // Circle0 is completely inside circle1
    else if (d <= Math.abs(r0 - r1) && r0 < r1)
    {
      // Return area of circle0
      return Math.PI * rr0;
    }
  
    // Circles partially overlap
    else
    {
      double phi = (Math.acos((rr0 + (d * d) - rr1) / (2 * r0 * d))) * 2;
      double theta = (Math.acos((rr1 + (d * d) - rr0) / (2 * r1 * d))) * 2;
      double area1 = 0.5 * theta * rr1 - 0.5 * rr1 * Math.sin(theta);
      double area2 = 0.5 * phi * rr0 - 0.5 * rr0 * Math.sin(phi);
  
      // Return area of intersection
      return area1 + area2;
    }
  
  }
  
  public void move(){

  }
  
  public void reproduce(){
    if(this.energyLevel > reproductionEnergyMantained){
       PVector birthV = PVector.random2D();
       birthV.mult((float)energyLevel);
       birthV.add(pos);
      Plant newPlant = new Plant(this.organisms, birthV.x, birthV.y);
      this.organisms.add(newPlant);
      this.energyLevel -= this.reproductionEnergy;
      System.out.println("reproduce");
    }
    
  }
  
  
  public void killSelf(){
    if(energyLevel <=0) isAlive = false;
    if(energyLevel < 5 && !isAlive) {
      organisms.remove(this);
      System.out.println("Plant Removed");
    }else if(age > 100){
      isAlive = false;
    }
    if(pos.x > width || pos.x < 0 || pos.y < 0 || pos.y > height) organisms.remove(this);
    
    
    
  }


}

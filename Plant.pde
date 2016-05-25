
public class Plant extends Organism{
  
  ArrayList<Organism> organisms;
  
  public Plant(ArrayList<Organism> o){
    this.organisms = o;
    setParameters();
    pos = new PVector(width/2.0, height/2.0);
   
  }
  
  public Plant(ArrayList<Organism> o, double x, double y){
    this.organisms = o;
    //System.out.print("set list");
    setParameters();
   // System.out.print("set parameters");
    pos = new PVector((float)x,(float)y);
   //     System.out.print("set position" + pos);
  }
  
  public Plant(ArrayList<Organism> o, PVector p){
    this.organisms = o;
    setParameters();
    pos = p;
  }
  
  private void setParameters(){
    vel = new PVector();
    sizeFactor = 0.9;//
    minEnergy = 10;
    energyLevel = minEnergy;
    growthRate = 0.35;//random(0.2)+0.1;  R if we are going to do random mutation, this is not the way to do it
    decayRate = -0.05;
    reproductionEnergy = 35;
    reproductionEnergyMantained = 50;
    age = 0;
    maxAge = 2500;
    col = color(0, 255, 0, 110);
    dCol = color(0,122,0,110);
    social = 0; //no sporing yet
    siz = (float)((energyLevel+minEnergy)/sizeFactor);
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

    siz = (float)((energyLevel+minEnergy)/sizeFactor);
    ellipse(pos.x, pos.y, siz, siz);
  }
  
  protected void age(){
    age++; 
  }
  
  public void decay(){
   energyLevel += decayRate; 
   //else {energyLevel -= 0.1; /*System.out.println("Decaying while dead");*/}
  }
  
  public void eat(){
    float areaCovered = 0;
    //in order to prevent lag only worry about overlapping every second frame
    if (frameCount%2==0){

    for(Organism o : organisms){
      if (this != o){
        //if touching
        if (pos.dist(o.pos)< (siz+o.siz)/2.){
         float selfRadius = (float) siz/2.;
         float organismRadius = (float) o.siz/2.;
         //add the amount of covered area to the total area
         areaCovered += areaOfIntersection(pos, selfRadius, o.pos, organismRadius); 
        }
      }
    }
    }
    double circleArea = PI * Math.pow((siz/2), 2);
    energyLevel += (1-(areaCovered/circleArea)) * growthRate;
 //  System.out.ln("Circle Area: " + circleArea);    
  }

//recoded the implementation of a method area of intersection
  private float areaOfIntersection(PVector me, float r1, PVector them, float r2){
   float rr2 = r2 * r2;
   float rr1 = r1 * r1;
   float d = me.dist(them); 
   //are they completely inside me?
   if (d <= r1 && r2<=r1){
      // Return area of circle1
      return (float)Math.PI *rr2;
    }
      //if i am completely inside them
    else if (d <= r2 && r1<r2){
       return (float)Math.PI * rr1;
    }
    // Circles partially overlap
    else
    {
      float phi =(float) (Math.acos((rr1 + (d * d) - rr2) / (2 * r1 * d))) ;
      float theta =(float) (Math.acos((rr2 + (d * d) - rr1) / (2 * r2 * d)));
      float extra = (float)0.5*sqrt((-d+r1+r2)*(d+r1-r2)*(d-r1+r2)*(d+r1+r2));
      float area = rr1* phi+rr2 * theta - extra;
      // Return area of intersection
      if (area != area){
         exit(); 
      }
      //System.out.println(area);
      return area;
    }
  }



/*  private double areaOfIntersection(float x0, float y0, float r0, float x1, float y1, float r1){
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
*/  
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
      //System.out.println("reproduce");
    }
    
  }
  
  
  public void killSelf(){
    if(energyLevel <=minEnergy*0.75) isAlive = false;
  //  if(energyLevel < minEnergy/2 && !isAlive) {
  //    organisms.remove(this);
  //  }
    if(age > maxAge){
      isAlive = false;
    }
 //   if(pos.x > width + siz || pos.x < - siz || pos.y < -siz || pos.y > height+siz)|| organisms.remove(this);
    
    
    
  }


}

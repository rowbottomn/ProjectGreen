import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import g4p_controls.*; 
import java.util.ArrayList; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class testingG4P_v2 extends PApplet {





ArrayList <GButton> buttonList;
ArrayList<Organism> organisms = new ArrayList<Organism>();

GWindow[] screen;
GWindow start_Screen;
GButton helpButton, settingsButton, pauseSettingsButton, startButton, menuButton, resumeButton, pauseButton, quitButton, quitGameButton, backButton, backHelpButton;
GLabel labelTest;
//GWIndow help_Screen;

public void setup() {
  Start_Sc();
}

/////////////////
/// Main Menu ///
/////////////////


public void Start_Sc () {
  size(1280,700);
  start_Screen = new GWindow(this, "", 0,0,1280,700, false, JAVA2D);
  PApplet app = start_Screen.papplet; // allows objects to be placed on the start screen
  
  buttonList = new ArrayList <GButton>();
  helpButton = new GButton(app,(width/7),height - 50, width/7, 40, "Help"); // the location of the start button
  startButton = new GButton(app, 3*(width/7),height - 50, width/7, 40, "Start"); // the location of the start button
  settingsButton = new GButton(app, 5*(width/7),height - 50, width/7, 40, "Settings"); // the location of the settings button
  quitButton = new GButton(app, 6*(width/7),0,width/7,25,"Quit"); // the location of the quit button
  
  labelTest = new GLabel(this, 100, 34, 120, 60, "test success!"); // message that appears if the left button is pressed
  labelTest.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelTest.setVisible(false);
  buttonList.add(quitButton);
  buttonList.add(helpButton);
  buttonList.add(backButton);
  //createGUI();    // enables random alternate ui screen
  
  start_Screen.addDrawHandler(this, "drawStart_Sc"); // calls the draw function for the background
  start_Screen.setVisible(true); // sets the game screen window to visible
}

public void drawStart_Sc(GWinApplet start_, GWinData data) {
  start_.background(255);
  
  start_.fill(0,255,0);
  start_.textSize(40);
  start_.text("Project Green", 50, 100);
  for (GButton b: buttonList){
//    if (
  }
}
 
public void handleButtonEvents(GButton button, GEvent event) { // MUST be called handleButtonEvents, won't work any other way 
   // if help is clicked
  if (screen == null && event == GEvent.CLICKED && button == helpButton) {
    Help_Sc();
    button.setEnabled(false);
  }
  // if settings is clicked
  else if (screen == null && event == GEvent.CLICKED && button == settingsButton) {
    Settings_Sc();
    pauseSettingsButton.setEnabled(false);
    settingsButton.setEnabled(false);
  }
  // if the settings button in the pause menu is clicked
  else if (screen == null && event == GEvent.CLICKED && button == pauseSettingsButton) {
    Settings_Sc();
    pauseSettingsButton.setEnabled(false);
    settingsButton.setEnabled(false);
  }
  // if start is clicked
  else if (screen == null && event == GEvent.CLICKED && button == startButton) {
    //screen.setVisible(false);
    Game_Sc();
    startButton.setEnabled(false);
  }
  // if pause is clicked
  else if (screen == null && event == GEvent.CLICKED && button == pauseButton) {
    Pause_Sc();
    paused =true;
    pauseButton.setEnabled(false);
  }
  
/////////////////////
///Closing Buttons///
/////////////////////
  
  // if quit is clicked
  if (event == GEvent.CLICKED && button == quitButton) {
    exit();
  }
  if (event == GEvent.CLICKED && button == quitGameButton) {
    exit();
  }
  // if back is clicked
  else if (help_Screen!=null && event == GEvent.CLICKED && button == backHelpButton){
      help_Screen.setVisible(false);
      helpButton.setEnabled(true);
  }
  // if back is clicked on settings screen
  else if (settings_Screen!=null && event == GEvent.CLICKED && button == backButton){
      settings_Screen.setVisible(false);
      settingsButton.setEnabled(true); 
      spawnBasedOnSettings();
      pauseSettingsButton.setEnabled(true);
  } 
  // if back is clicked on pause screen
  else if (pause_Screen!=null && event == GEvent.CLICKED && button == resumeButton){
      pause_Screen.setVisible(false);
      pauseButton.setEnabled(true);
      paused = false;
  }
  // if the main menu button is pressed
  else if (pause_Screen!=null && event == GEvent.CLICKED && button == menuButton){
    pause_Screen.setVisible(false);
    settings_Screen.setVisible(false);
    help_Screen.setVisible(false);
    game_Screen.setVisible(false);
    
    settingsButton.setEnabled(true); 
    pauseSettingsButton.setEnabled(true);
    pauseButton.setEnabled(true);
    helpButton.setEnabled(true);
    startButton.setEnabled(true);
    menuButton.setEnabled(true);
    resumeButton.setEnabled(true);
  }
}

public void spawnBasedOnSettings(){
   for (int i = 0 ; i < sdr1.getValueF(); i ++){
     organisms.add(new Plant(organisms,new PVector(random(width), random(height))));
   }  
   for (int i = 0 ; i < sdr2.getValueF(); i ++){
     organisms.add(new PlantEater(organisms,new PVector(random(width), random(height))));
   }  
   for (int i = 0 ; i < sdr3.getValueF(); i ++){
     organisms.add(new Scavenger(organisms,new PVector(random(width), random(height))));
   }    
//   for (int i = 0; i <= sdr4.getValueF(); i ++){
//     organisms.add(new Predator(organisms,new PVector(random(width), random(height))));
//   }
}

//
//static void useRoundCorners(boolean useRoundCorners){
//  useRoundCorners.setEnabled(true);
//}

GWindow game_Screen, pause_Screen;

public void Game_Sc() {

  if (game_Screen == null) { // if it hasn't been created yet
    game_Screen = new GWindow(this, "", 0, 0, 1280, 700, false, JAVA2D);
    PApplet app = game_Screen.papplet; // allows objects to be placed on the game screen
    pauseButton = new GButton(app, width-75, 0, 75, 25, "Pause"); // opens the pause screen
    game_Screen.addDrawHandler(this, "drawGame_Sc"); // calls the draw function for the background
    game_Screen.addMouseHandler(this, "mouseClickedY");
  }
  game_Screen.setVisible(true); // sets the game screen window to visible
}

int x = 0;
boolean paused;

public void drawGame_Sc(GWinApplet g, GWinData data)
{
  if (!paused) {
    g.background(255, 255, 255);
    int aliveCount = 0;
    for (int i = 0; i < organisms.size (); i++) {
      Organism organism = organisms.get(i);


      organism.update();
      if (organism instanceof Plant) {
        g.fill(0, 255, 0, 110);
        if (!organism.isAlive) {
          g.fill(0, 100, 0, 110);
        }    
        g.ellipse(organism.pos.x, organism.pos.y, (int)organism.energyLevel, (int)organism.energyLevel);
      }

      if (organism instanceof PlantEater) {
        PlantEater p = (PlantEater)organism;
        //if(organism.feeding){
        g.fill(18, 160, 150, 110);
        if (!organism.isAlive) {
          g.fill(9, 80, 75, 110);
        }   
        g.ellipse(p.pos.x, p.pos.y, p.siz, p.siz);
        //              }else{
        //              g.fill(68,134,227,110);
        //              g.ellipse(pos.x, pos.y, 30, 30);
      }      
      if (organism instanceof Scavenger) {
        //if(organism.feeding){
        g.fill(180, 160, 15, 110);
        if (!organism.isAlive) {
          g.fill(90, 80, 7, 110);
        }  
        g.ellipse(organism.pos.x, organism.pos.y, (float)organism.energyLevel, (float)organism.energyLevel);
        //              }else{
        //              g.fill(68,134,227,110);
        //              g.ellipse(pos.x, pos.y, 30, 30);
      }
      if (organism instanceof Predator) {
        //if(organism.feeding){
        g.fill(176,16,16,110);
        if (!organism.isAlive) {
          g.fill(88, 8, 8, 110);
        }
        g.ellipse(organism.pos.x, organism.pos.y, (float)organism.energyLevel, (float)organism.energyLevel);
      }

      //   game_Screen.addDrawHandler(this, "organism.drawSf/ calls the draw function for the background
      if (organism.isAlive)aliveCount++;
      if (i==0) System.out.println(aliveCount);
    }
  }
}
// System.out.println(aliveCount);

private boolean click = false;
private boolean rclick = false;
private int clickVal = 0;
private int rclickVal = 0;
public void mouseClickedY(GWinApplet game_, GWinData data, MouseEvent e) {
  //println("====================================================>"+e.getButton());

  if (e.getButton()==37 && !click) {

    organisms.add(new Scavenger(organisms, e.getX(), e.getY()));
    click = true;
    clickVal = 37;
  } else if (e.getButton()!= 37&& click) {
    click = false;
  }
  if (e.getButton()==39 && !rclick) {
    organisms.add(new Parasite(organisms, e.getX(), e.getY()));
    rclick = true;
    rclickVal = 39;
  } else if (e.getButton()!=39 && rclick) {
    rclick = false;
  }
  //39 is right button and 3 is middle
}


////////////////
// Pause Menu //
////////////////

public void Pause_Sc() {

  if (pause_Screen == null) { // if it hasn't been created yet
    pause_Screen = new GWindow(this, "Paused", 0, 0, 1280, 100, false, JAVA2D);
    PApplet app = pause_Screen.papplet; // allows objects to be placed on the pause screen
    resumeButton = new GButton(app, 6*width/7, 0, width/7, 25, "Resume"); // closes the pause screen
    menuButton = new GButton(app, (width/7), 35, width/7, 35, "Main Menu"); // closes the pause screen
    quitGameButton = new GButton(app, 5*(width/7), 35, width/7, 35, "Quit"); // closes the game
    pauseSettingsButton = new GButton(app, 3*(width/7), 35, width/7, 35, "Settings"); // the location of the settings button
    pause_Screen.addDrawHandler(this, "drawPause_Sc"); // calls the draw function for the background
  }
  pause_Screen.setVisible(true);
}


public void drawPause_Sc(GWinApplet pause_, GWinData data)
{
  pause_.background(255, 255, 255);
}


GWindow help_Screen;


public void Help_Sc() {
  if (help_Screen == null) { // if it hasn't been created yet
  help_Screen = new GWindow(this, "Help", 0, 0, 1280,700, false, JAVA2D);
  PApplet app = help_Screen.papplet; // allows objects to be placed on the help screen
  backHelpButton = new GButton(app,width-75,0,75,25,"Back"); // closes the help screen
  help_Screen.addDrawHandler(this, "drawHelp_Sc"); // calls the draw function for the background
  }
  help_Screen.setVisible(true);
}


public void drawHelp_Sc(GWinApplet help_, GWinData data)
{
  help_.background(255, 255,255);  
}
public interface Hunt {
  
  public Organism locatePrey();
  
  public void chasePrey(Organism o);
  
  public void killPrey(Organism o);
  
  
  
}

public abstract class Organism{

PVector pos;
PVector vel;
double age;
double sizeFactor;
boolean isAlive = true;
boolean feeding = false;
double energyLevel;
double growthRate;
double decayRate;
double reproductionEnergy;
double reproductionEnergyMantained;
double eatSpeed;
double sight;
float speed;
float siz;
int maxAge = 0;
float minEnergy = 0;

public abstract void drawSelf();
public abstract void update();
public abstract void decay();
public abstract void eat();
public abstract void move();
public abstract void reproduce();
public abstract void killSelf();

}

public class Parasite extends Organism implements Hunt{
  
 
  ArrayList<Organism> organisms;
  Organism prey;
  boolean feeding = false;
  int count = 0;
  float socialMovement = 5.5f;
  
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
    growthRate = 0.60f;
    eatSpeed = 0.08f;
    speed = 3.2f;
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
    if(isAlive) energyLevel -= 0.01f;
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
      if(energyLevel <= minEnergy*0.5f) {isAlive =  false; organisms.remove(this);}
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

public class Plant extends Organism{
  
  ArrayList<Organism> organisms;
  
  public Plant(ArrayList<Organism> o){
    this.organisms = o;
    setParameters();
    pos = new PVector(width/2.0f, height/2.0f);
   
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
    growthRate = random(0.2f)+0.1f;
    decayRate = -0.05f;
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
    age += 0.1f;
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
      double area1 = 0.5f * theta * rr1 - 0.5f * rr1 * Math.sin(theta);
      double area2 = 0.5f * phi * rr0 - 0.5f * rr0 * Math.sin(phi);
  
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
  int col;
  
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
    sizeFactor = 5.f;
    social = 1.f;
    travelFrames = 20;
    growthRate = 0.55f;
    decayRate = -0.03f;
    minEnergy = 40;
    energyLevel = minEnergy;
    reproductionEnergy = minEnergy*4.f;
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
        if (o instanceof Plant && pos.dist(o.pos)<(siz+o.energyLevel)/2.8f){
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
      float tempSpeed = 30.f *speed / (float)(siz + 150.f); 
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
      if(energyLevel <= minEnergy*0.5f) {isAlive =  false; organisms.remove(this);}
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
public class Predator extends Parasite implements Hunt{
  
   ArrayList<Organism> organisms = new ArrayList<Organism>();
  Organism prey;

  int count = 0;
  float socialMovement = 6.5f;
  
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
  }

  public void drawSelf(){

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
 //     age();
     reproduce();
      if(!feeding){
        hunt();
      }  
    }
  } 
  
  
  
  
}

public class Scavenger extends Organism implements Hunt{

  ArrayList<Organism> organisms = new ArrayList<Organism>();
  Organism prey;

  int count = 0;
  float socialMovement = 6.5f;
  
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
      age();
     reproduce();
      if(!feeding){
        hunt();
      }  
    }
  }
  
  public void decay(){
    if(isAlive) energyLevel -= 0.05f;
  }
  
  public void eat(){
    if(prey!=null){
      if(PVector.dist(pos, prey.pos) < 10){
        feeding = true;
        vel.set(0,0);
        prey.energyLevel-=0.2f;energyLevel+=0.2f;
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
  
  public void age(){
    age+=0.1f;
  }
  
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

GWindow settings_Screen;
GCustomSlider sdr1, sdr2, sdr3, sdr4, sdr5, sdr6;
int numTicks = 21;
int maxValue = numTicks - 1;
int minValue = 0;
int defaultValue = 5;


public void Settings_Sc() {
  if (settings_Screen == null) { // if it hasn't been created yet
  settings_Screen = new GWindow(this, "Settings", minValue, 0, 1280,700, false, JAVA2D);  
  PApplet app = settings_Screen.papplet; // allows objects to be placed on the settings screen
  backButton = new GButton(app, width-75, minValue, 75,25, "Back"); // closes the settings screen
  settings_Screen.addDrawHandler(this, "drawSettings_Sc"); // calls the draw function for the background
  
  //Slider Functions =================== 
  sdr1 = new GCustomSlider(app, 55, 1*height/13, 200, 60, "blue18px");//plant
  sdr2 = new GCustomSlider(app, 55, 3*height/13, 200, 60, "blue18px");//plantEater
  sdr3 = new GCustomSlider(app, 55, 5*height/13, 200, 60, "blue18px");//scavenger
  sdr4 = new GCustomSlider(app, 55, 7*height/13, 200, 60, "blue18px");
  sdr5 = new GCustomSlider(app, 55, 9*height/13, 200, 60, "blue18px");
  sdr6 = new GCustomSlider(app, 55, 11*height/13, 200, 60, "blue18px");

//Slider 1 =================

  sdr1.setLocalColorScheme(6); 
  sdr1.setOpaque(false); 
  sdr1.setValue(100); 
  sdr1.setNbrTicks(numTicks); 
  sdr1.setShowLimits(false); 
  sdr1.setShowValue(true); 
  sdr1.setShowTicks(true); 
  sdr1.setStickToTicks(true); 
  sdr1.setEasing(1); 
  sdr1.setLimits(1, minValue, maxValue);
  sdr1.setNumberFormat(G4P.INTEGER, 0);
  
//Slider 2 ==================

  sdr2.setLocalColorScheme(6); 
  sdr2.setOpaque(false); 
  sdr2.setValue(100); 
  sdr2.setNbrTicks(numTicks); 
  sdr2.setShowLimits(false); 
  sdr2.setShowValue(true); 
  sdr2.setShowTicks(true); 
  sdr2.setStickToTicks(true); 
  sdr2.setEasing(1); 
  sdr2.setLimits(1, minValue, maxValue);
  sdr2.setNumberFormat(G4P.INTEGER, 0);
  
//Slider 3 ==================

  sdr3.setLocalColorScheme(6); 
  sdr3.setOpaque(false); 
  sdr3.setValue(100); 
  sdr3.setNbrTicks(numTicks); 
  sdr3.setShowLimits(false); 
  sdr3.setShowValue(true); 
  sdr3.setShowTicks(true); 
  sdr3.setStickToTicks(true); 
  sdr3.setEasing(1); 
  sdr3.setLimits(1, minValue, maxValue);
  sdr3.setNumberFormat(G4P.INTEGER, 0);
  
//Slider 4 ====================

  sdr4.setLocalColorScheme(6); 
  sdr4.setOpaque(false); 
  sdr4.setValue(100); 
  sdr4.setNbrTicks(numTicks); 
  sdr4.setShowLimits(false); 
  sdr4.setShowValue(true); 
  sdr4.setShowTicks(true); 
  sdr4.setStickToTicks(true); 
  sdr4.setEasing(1); 
  sdr4.setLimits(1, minValue, maxValue);
  sdr4.setNumberFormat(G4P.INTEGER, 0);
  
//Slider 5 ===================

  sdr5.setLocalColorScheme(6); 
  sdr5.setOpaque(false); 
  sdr5.setValue(100); 
  sdr5.setNbrTicks(numTicks); 
  sdr5.setShowLimits(false); 
  sdr5.setShowValue(true); 
  sdr5.setShowTicks(true); 
  sdr5.setStickToTicks(true); 
  sdr5.setEasing(1); 
  sdr5.setLimits(1, minValue, maxValue);
  sdr5.setNumberFormat(G4P.INTEGER, 0);
  
  
//Slider 6 ==================
  
  sdr6.setLocalColorScheme(6); 
  sdr6.setOpaque(false); 
  sdr6.setValue(100); 
  sdr6.setNbrTicks(numTicks); 
  sdr6.setShowLimits(false); 
  sdr6.setShowValue(true); 
  sdr6.setShowTicks(true); 
  sdr6.setStickToTicks(true); 
  sdr6.setEasing(1); 
  sdr6.setLimits(1, minValue, maxValue);
  sdr6.setNumberFormat(G4P.INTEGER, 0);
  }
  
  settings_Screen.setVisible(true);
}


public void drawSettings_Sc(GWinApplet settings_, GWinData data)
{
  settings_.background(255, 255,255);  
}
/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void slider1_change1(GSlider source, GEvent event) { //_CODE_:slider1:589600:
  println("slider1 - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:slider1:589600:

public void slider2_change1(GSlider source, GEvent event) { //_CODE_:slider2:894533:
  println("slider2 - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:slider2:894533:

public void slider3_change1(GSlider source, GEvent event) { //_CODE_:slider3:256282:
  println("slider3 - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:slider3:256282:

public void slider4_change1(GSlider source, GEvent event) { //_CODE_:slider4:754764:
  println("slider4 - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:slider4:754764:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  if(frame != null)
    frame.setTitle("Sketch Window");
  slider1 = new GSlider(this, 54, 58, 100, 40, 10.0f);
  slider1.setLimits(0.5f, 0.0f, 1.0f);
  slider1.setNumberFormat(G4P.DECIMAL, 2);
  slider1.setOpaque(false);
  slider1.addEventHandler(this, "slider1_change1");
  slider2 = new GSlider(this, 50, 121, 100, 40, 10.0f);
  slider2.setLimits(0.5f, 0.0f, 1.0f);
  slider2.setNumberFormat(G4P.DECIMAL, 2);
  slider2.setOpaque(false);
  slider2.addEventHandler(this, "slider2_change1");
  label1 = new GLabel(this, 58, 30, 80, 20);
  label1.setText("My label");
  label1.setOpaque(false);
  label2 = new GLabel(this, 57, 99, 80, 20);
  label2.setText("My label");
  label2.setOpaque(false);
  slider3 = new GSlider(this, 64, 203, 100, 40, 10.0f);
  slider3.setLimits(0.5f, 0.0f, 1.0f);
  slider3.setNumberFormat(G4P.DECIMAL, 2);
  slider3.setOpaque(false);
  slider3.addEventHandler(this, "slider3_change1");
  slider4 = new GSlider(this, 58, 278, 100, 40, 10.0f);
  slider4.setLimits(0.5f, 0.0f, 1.0f);
  slider4.setNumberFormat(G4P.DECIMAL, 2);
  slider4.setOpaque(false);
  slider4.addEventHandler(this, "slider4_change1");
  label3 = new GLabel(this, 65, 169, 80, 20);
  label3.setText("My label");
  label3.setOpaque(false);
  label4 = new GLabel(this, 67, 251, 80, 20);
  label4.setText("My label");
  label4.setOpaque(false);
}

// Variable declarations 
// autogenerated do not edit
GSlider slider1; 
GSlider slider2; 
GLabel label1; 
GLabel label2; 
GSlider slider3; 
GSlider slider4; 
GLabel label3; 
GLabel label4; 

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "testingG4P_v2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}


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
  int  MIDX = width/2;
  int MIDY = height/2;
  if (!paused) {

    g.background(255, 255, 255);
    int aliveCount = 0;
    for (int i = 0; i < organisms.size (); i++) {
      Organism organism = organisms.get(i);
      //universal removal conditions, remove them before anything else is done to speed things up
      //outside the screen remove them
      if ((abs(organism.pos.x - MIDX)>= MIDX + organism.siz/2) || (abs(organism.pos.y - MIDY)>= MIDY + organism.siz/2)){
        organism.isAlive = false;
        organisms.remove(organism);
        continue;         
      }
      //remove all organisms that are low energy
      if (organism.energyLevel < organism.minEnergy*0.4 && !organism.isAlive ){
        organisms.remove(organism);
        continue;         
      }
      if (organism.energyLevel < organism.minEnergy*0.7 && organism.isAlive){
         organism.col = organism.dCol;
         organism.isAlive = false;
      } 
      g.stroke(organism.armorCol);
      g.strokeWeight(organism.armor);
      organism.update();
      
      if (organism instanceof Plant) {
        g.fill(organism.col);
        g.ellipse(organism.pos.x, organism.pos.y, (int)organism.siz, (int)organism.siz);
      }
      else if (organism instanceof PlantEater) {
        g.fill(organism.col);
        g.ellipse(organism.pos.x, organism.pos.y, (1+1.*sin(0.01/frameRate*frameCount))*organism.siz, (1+0.5*sin((frameCount+30.)/300.))*organism.siz);
      }    
      
      else if (organism instanceof Scavenger) {
        g.fill(organism.col);
        
        g.ellipse(organism.pos.x, organism.pos.y, organism.siz, organism.siz);
      }
      
      else if (organism instanceof Parasite) {
        g.fill(organism.col);
        g.ellipse(organism.pos.x, organism.pos.y, organism.siz, organism.siz);
      }
      
      else if (organism instanceof Predator) {
        //if(organism.feeding){
        g.fill(organism.col);
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

    organisms.add(new Plant(organisms, e.getX(), e.getY()));
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



import g4p_controls.*;
import java.util.ArrayList;

ArrayList <GButton> buttonList;
ArrayList<Organism> organisms = new ArrayList<Organism>();

GWindow[] screen;
GWindow start_Screen;
GButton helpButton, settingsButton, pauseSettingsButton, startButton, menuButton, resumeButton, pauseButton, quitButton, quitGameButton, backButton, backHelpButton;
GLabel labelTest;
//GWIndow help_Screen;

void setup() {

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

void drawStart_Sc(GWinApplet start_, GWinData data) {
  start_.background(255);
  
  start_.fill(0,255,0);
  start_.textSize(40);
  start_.text("Project Green", 50, 100);
  for (GButton b: buttonList){
//    if (
  }
}
 
void handleButtonEvents(GButton button, GEvent event) { // MUST be called handleButtonEvents, won't work any other way 
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

void spawnBasedOnSettings(){
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

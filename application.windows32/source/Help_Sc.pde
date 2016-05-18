
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

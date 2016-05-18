
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

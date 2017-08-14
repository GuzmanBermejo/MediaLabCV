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

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:controlWindow:392828:
  appc.background(230);
} //_CODE_:controlWindow:392828:

public void option1_clicked1(GOption source, GEvent event) { //_CODE_:knn:821891:
  //println("option1 - GOption >> GEvent." + event + " @ " + millis());
  onMediaLabCVBgSubtractorParameterChange();
} //_CODE_:knn:821891:

public void option2_clicked1(GOption source, GEvent event) { //_CODE_:mog2:822889:
  //println("option2 - GOption >> GEvent." + event + " @ " + millis());
  onMediaLabCVBgSubtractorParameterChange();
} //_CODE_:mog2:822889:

public void slider1_change1(GSlider source, GEvent event) { //_CODE_:bgHistory:746189:
  //println("slider1 - GSlider >> GEvent." + event + " @ " + millis());
  onMediaLabCVBgSubtractorParameterChange();
} //_CODE_:bgHistory:746189:

public void slider2_change1(GSlider source, GEvent event) { //_CODE_:bgKnnThreshold:303786:
  //println("slider2 - GSlider >> GEvent." + event + " @ " + millis());
  onMediaLabCVBgSubtractorParameterChange();
} //_CODE_:bgKnnThreshold:303786:

public void checkbox1_clicked1(GCheckbox source, GEvent event) { //_CODE_:bgShadows:569864:
  //println("checkbox1 - GCheckbox >> GEvent." + event + " @ " + millis());
  onMediaLabCVBgSubtractorParameterChange();
} //_CODE_:bgShadows:569864:

public void slider3_change1(GSlider source, GEvent event) { //_CODE_:bgLearning:510683:
  //println("slider3 - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:bgLearning:510683:

public void slider4_change1(GSlider source, GEvent event) { //_CODE_:dilateKernelSize:852981:
  //println("slider4 - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:dilateKernelSize:852981:

public void slider5_change1(GSlider source, GEvent event) { //_CODE_:dilateIterations:636670:
  //println("slider5 - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:dilateIterations:636670:

public void onExitButton(GButton source, GEvent event) { //_CODE_:button1:681809:
  //println("button1 - GButton >> GEvent." + event + " @ " + millis());
  doExit = true;
} //_CODE_:button1:681809:

public void checkbox2_clicked1(GCheckbox source, GEvent event) { //_CODE_:bgLearningAuto:995997:
  //println("checkbox2 - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:bgLearningAuto:995997:

public void slider1_change2(GSlider source, GEvent event) { //_CODE_:bgMog2Threshold:587558:
  //println("slider1 - GSlider >> GEvent." + event + " @ " + millis());
  onMediaLabCVBgSubtractorParameterChange();
} //_CODE_:bgMog2Threshold:587558:

public void slider1_change3(GSlider source, GEvent event) { //_CODE_:morphNoiseSize:325697:
  //println("morphNoiseSize - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:morphNoiseSize:325697:

public void slider1_change4(GSlider source, GEvent event) { //_CODE_:cMinWidth:344095:
  //println("slider1 - GSlider >> GEvent." + event + " @ " + millis());
  onMediaLabCVContourParameterChange();
} //_CODE_:cMinWidth:344095:

public void slider2_change2(GSlider source, GEvent event) { //_CODE_:cMaxWidth:692856:
  //println("slider2 - GSlider >> GEvent." + event + " @ " + millis());
  onMediaLabCVContourParameterChange();
} //_CODE_:cMaxWidth:692856:

public void slider3_change2(GSlider source, GEvent event) { //_CODE_:cMinHeight:452537:
  //println("slider3 - GSlider >> GEvent." + event + " @ " + millis());
  onMediaLabCVContourParameterChange();
} //_CODE_:cMinHeight:452537:

public void slider4_change2(GSlider source, GEvent event) { //_CODE_:cMaxHeight:714232:
  //println("slider4 - GSlider >> GEvent." + event + " @ " + millis());
  onMediaLabCVContourParameterChange();
} //_CODE_:cMaxHeight:714232:

public void slider1_change5(GSlider source, GEvent event) { //_CODE_:cDistanceThreshold:302199:
  //println("cDistanceThreshold - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:cDistanceThreshold:302199:

public void slider1_change6(GSlider source, GEvent event) { //_CODE_:erodeKernelSize:924100:
  //println("erodeKernelSize - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:erodeKernelSize:924100:

public void slider2_change3(GSlider source, GEvent event) { //_CODE_:erodeIterations:811495:
  //println("erodeIterations - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:erodeIterations:811495:

public void checkbox1_clicked2(GCheckbox source, GEvent event) { //_CODE_:cAdjacentMerge:390758:
  //println("cAdjacentMerge - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:cAdjacentMerge:390758:

public void checkbox2_clicked2(GCheckbox source, GEvent event) { //_CODE_:cShadowRemove:365409:
  //println("cShadowRemove - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:cShadowRemove:365409:

public void checkbox1_clicked3(GCheckbox source, GEvent event) { //_CODE_:roi:992676:
  //println("roi - GCheckbox >> GEvent." + event + " @ " + millis());
  onMediaLabCVROIParameterChange();
} //_CODE_:roi:992676:

public void slider1_change7(GSlider source, GEvent event) { //_CODE_:roiX:202390:
  //println("roiX - GSlider >> GEvent." + event + " @ " + millis());
  onMediaLabCVROIParameterChange();
} //_CODE_:roiX:202390:

public void slider2_change4(GSlider source, GEvent event) { //_CODE_:roiY:574889:
  //println("roiY - GSlider >> GEvent." + event + " @ " + millis());
  onMediaLabCVROIParameterChange();
} //_CODE_:roiY:574889:

public void slider3_change3(GSlider source, GEvent event) { //_CODE_:roiWidth:347683:
  //println("roiWidth - GSlider >> GEvent." + event + " @ " + millis());
  onMediaLabCVROIParameterChange();
} //_CODE_:roiWidth:347683:

public void slider4_change3(GSlider source, GEvent event) { //_CODE_:roiHeight:890588:
  //println("roiHeight - GSlider >> GEvent." + event + " @ " + millis());
  onMediaLabCVROIParameterChange();
} //_CODE_:roiHeight:890588:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  controlWindow = GWindow.getWindow(this, "Controls", 100, 100, 468, 630, JAVA2D);
  controlWindow.noLoop();
  controlWindow.addDrawHandler(this, "win_draw1");
  label1 = new GLabel(controlWindow, 0, 234, 234, 54);
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setText("Background Subtractor");
  label1.setTextBold();
  label1.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  label1.setOpaque(true);
  label2 = new GLabel(controlWindow, 0, 288, 90, 36);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("Kind");
  label2.setOpaque(true);
  togGroup1 = new GToggleGroup();
  knn = new GOption(controlWindow, 90, 288, 72, 36);
  knn.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  knn.setText("KNN");
  knn.setOpaque(false);
  knn.addEventHandler(this, "option1_clicked1");
  mog2 = new GOption(controlWindow, 162, 288, 72, 36);
  mog2.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  mog2.setText("MOG2");
  mog2.setOpaque(false);
  mog2.addEventHandler(this, "option2_clicked1");
  togGroup1.addControl(knn);
  knn.setSelected(true);
  togGroup1.addControl(mog2);
  label3 = new GLabel(controlWindow, 0, 324, 90, 36);
  label3.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label3.setText("History");
  label3.setOpaque(true);
  label4 = new GLabel(controlWindow, 0, 360, 90, 36);
  label4.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label4.setText("KNN Threshold");
  label4.setOpaque(true);
  label5 = new GLabel(controlWindow, 0, 432, 90, 36);
  label5.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label5.setText("Shadows");
  label5.setOpaque(true);
  bgHistory = new GSlider(controlWindow, 90, 324, 144, 36, 10.0);
  bgHistory.setShowValue(true);
  bgHistory.setShowLimits(true);
  bgHistory.setLimits(500, 0, 5000);
  bgHistory.setNumberFormat(G4P.INTEGER, 0);
  bgHistory.setOpaque(false);
  bgHistory.addEventHandler(this, "slider1_change1");
  bgKnnThreshold = new GSlider(controlWindow, 90, 360, 144, 36, 10.0);
  bgKnnThreshold.setShowValue(true);
  bgKnnThreshold.setShowLimits(true);
  bgKnnThreshold.setLimits(400.0, 0.0, 2500.0);
  bgKnnThreshold.setNumberFormat(G4P.DECIMAL, 2);
  bgKnnThreshold.setOpaque(false);
  bgKnnThreshold.addEventHandler(this, "slider2_change1");
  bgShadows = new GCheckbox(controlWindow, 144, 432, 36, 36);
  bgShadows.setIconPos(GAlign.SOUTH);
  bgShadows.setText(" Mark?");
  bgShadows.setOpaque(false);
  bgShadows.addEventHandler(this, "checkbox1_clicked1");
  bgShadows.setSelected(true);
  label6 = new GLabel(controlWindow, 0, 468, 90, 72);
  label6.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label6.setText("Learning Rate");
  label6.setOpaque(true);
  bgLearning = new GSlider(controlWindow, 90, 504, 144, 36, 10.0);
  bgLearning.setShowValue(true);
  bgLearning.setShowLimits(true);
  bgLearning.setLimits(0.5, 0.0, 1.0);
  bgLearning.setNumberFormat(G4P.DECIMAL, 2);
  bgLearning.setOpaque(false);
  bgLearning.addEventHandler(this, "slider3_change1");
  label7 = new GLabel(controlWindow, 234, 0, 234, 54);
  label7.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label7.setText("Mathematical Morphology");
  label7.setTextBold();
  label7.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  label7.setOpaque(true);
  label8 = new GLabel(controlWindow, 234, 90, 90, 36);
  label8.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label8.setText("Dilate Kernel Size");
  label8.setOpaque(true);
  label9 = new GLabel(controlWindow, 234, 126, 90, 36);
  label9.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label9.setText("Dilate Iterations");
  label9.setOpaque(true);
  dilateKernelSize = new GSlider(controlWindow, 324, 90, 144, 36, 10.0);
  dilateKernelSize.setShowValue(true);
  dilateKernelSize.setShowLimits(true);
  dilateKernelSize.setLimits(18, 1, 50);
  dilateKernelSize.setNumberFormat(G4P.INTEGER, 0);
  dilateKernelSize.setOpaque(false);
  dilateKernelSize.addEventHandler(this, "slider4_change1");
  dilateIterations = new GSlider(controlWindow, 324, 126, 144, 36, 10.0);
  dilateIterations.setShowValue(true);
  dilateIterations.setShowLimits(true);
  dilateIterations.setLimits(1, 1, 50);
  dilateIterations.setNumberFormat(G4P.INTEGER, 0);
  dilateIterations.setOpaque(false);
  dilateIterations.addEventHandler(this, "slider5_change1");
  button1 = new GButton(controlWindow, 126, 558, 216, 54);
  button1.setText("Exit");
  button1.setLocalColorScheme(GCScheme.RED_SCHEME);
  button1.addEventHandler(this, "onExitButton");
  bgLearningAuto = new GCheckbox(controlWindow, 144, 468, 36, 36);
  bgLearningAuto.setIconPos(GAlign.SOUTH);
  bgLearningAuto.setText(" Auto?");
  bgLearningAuto.setOpaque(false);
  bgLearningAuto.addEventHandler(this, "checkbox2_clicked1");
  bgLearningAuto.setSelected(true);
  label10 = new GLabel(controlWindow, 0, 396, 90, 36);
  label10.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label10.setText("MOG2 Threshold");
  label10.setOpaque(true);
  bgMog2Threshold = new GSlider(controlWindow, 90, 396, 144, 36, 10.0);
  bgMog2Threshold.setShowValue(true);
  bgMog2Threshold.setShowLimits(true);
  bgMog2Threshold.setLimits(16.0, 0.0, 100.0);
  bgMog2Threshold.setNumberFormat(G4P.DECIMAL, 2);
  bgMog2Threshold.setOpaque(false);
  bgMog2Threshold.addEventHandler(this, "slider1_change2");
  label11 = new GLabel(controlWindow, 234, 54, 90, 36);
  label11.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label11.setText("Noise Size");
  label11.setOpaque(true);
  morphNoiseSize = new GSlider(controlWindow, 324, 54, 144, 36, 10.0);
  morphNoiseSize.setShowValue(true);
  morphNoiseSize.setShowLimits(true);
  morphNoiseSize.setLimits(3, 0, 15);
  morphNoiseSize.setNumberFormat(G4P.INTEGER, 0);
  morphNoiseSize.setOpaque(false);
  morphNoiseSize.addEventHandler(this, "slider1_change3");
  label12 = new GLabel(controlWindow, 234, 234, 234, 54);
  label12.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label12.setText("Contour");
  label12.setTextBold();
  label12.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  label12.setOpaque(true);
  label13 = new GLabel(controlWindow, 234, 396, 90, 36);
  label13.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label13.setText("Min Width");
  label13.setOpaque(true);
  label14 = new GLabel(controlWindow, 234, 432, 90, 36);
  label14.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label14.setText("Max Width");
  label14.setOpaque(true);
  label15 = new GLabel(controlWindow, 234, 468, 90, 36);
  label15.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label15.setText("Min Height");
  label15.setOpaque(true);
  label16 = new GLabel(controlWindow, 234, 504, 90, 36);
  label16.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label16.setText("Max Height");
  label16.setOpaque(true);
  cMinWidth = new GSlider(controlWindow, 324, 396, 144, 36, 10.0);
  cMinWidth.setShowValue(true);
  cMinWidth.setShowLimits(true);
  cMinWidth.setLimits(0.05, 0.0, 1.0);
  cMinWidth.setNumberFormat(G4P.DECIMAL, 2);
  cMinWidth.setOpaque(false);
  cMinWidth.addEventHandler(this, "slider1_change4");
  cMaxWidth = new GSlider(controlWindow, 324, 432, 144, 36, 10.0);
  cMaxWidth.setShowValue(true);
  cMaxWidth.setShowLimits(true);
  cMaxWidth.setLimits(0.75, 0.0, 1.0);
  cMaxWidth.setNumberFormat(G4P.DECIMAL, 2);
  cMaxWidth.setOpaque(false);
  cMaxWidth.addEventHandler(this, "slider2_change2");
  cMinHeight = new GSlider(controlWindow, 324, 468, 144, 36, 10.0);
  cMinHeight.setShowValue(true);
  cMinHeight.setShowLimits(true);
  cMinHeight.setLimits(0.05, 0.0, 1.0);
  cMinHeight.setNumberFormat(G4P.DECIMAL, 2);
  cMinHeight.setOpaque(false);
  cMinHeight.addEventHandler(this, "slider3_change2");
  cMaxHeight = new GSlider(controlWindow, 324, 504, 144, 36, 10.0);
  cMaxHeight.setShowValue(true);
  cMaxHeight.setShowLimits(true);
  cMaxHeight.setLimits(0.75, 0.0, 1.0);
  cMaxHeight.setNumberFormat(G4P.DECIMAL, 2);
  cMaxHeight.setOpaque(false);
  cMaxHeight.addEventHandler(this, "slider4_change2");
  label17 = new GLabel(controlWindow, 234, 288, 90, 72);
  label17.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label17.setText("Adjacent Merge");
  label17.setOpaque(true);
  cDistanceThreshold = new GSlider(controlWindow, 324, 324, 144, 36, 10.0);
  cDistanceThreshold.setShowValue(true);
  cDistanceThreshold.setShowLimits(true);
  cDistanceThreshold.setLimits(10.0, 0.0, 100.0);
  cDistanceThreshold.setNumberFormat(G4P.DECIMAL, 2);
  cDistanceThreshold.setOpaque(false);
  cDistanceThreshold.addEventHandler(this, "slider1_change5");
  label18 = new GLabel(controlWindow, 234, 162, 90, 36);
  label18.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label18.setText("Erode Kernel Size");
  label18.setOpaque(true);
  erodeKernelSize = new GSlider(controlWindow, 324, 162, 144, 36, 10.0);
  erodeKernelSize.setShowValue(true);
  erodeKernelSize.setShowLimits(true);
  erodeKernelSize.setLimits(1, 1, 50);
  erodeKernelSize.setNumberFormat(G4P.INTEGER, 0);
  erodeKernelSize.setOpaque(false);
  erodeKernelSize.addEventHandler(this, "slider1_change6");
  label19 = new GLabel(controlWindow, 234, 198, 90, 36);
  label19.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label19.setText("Erode Iterations");
  label19.setOpaque(true);
  erodeIterations = new GSlider(controlWindow, 324, 198, 144, 36, 10.0);
  erodeIterations.setShowValue(true);
  erodeIterations.setShowLimits(true);
  erodeIterations.setLimits(1, 1, 50);
  erodeIterations.setNumberFormat(G4P.INTEGER, 0);
  erodeIterations.setOpaque(false);
  erodeIterations.addEventHandler(this, "slider2_change3");
  cAdjacentMerge = new GCheckbox(controlWindow, 324, 288, 144, 36);
  cAdjacentMerge.setIconPos(GAlign.SOUTH);
  cAdjacentMerge.setText("                  Merge?");
  cAdjacentMerge.setOpaque(false);
  cAdjacentMerge.addEventHandler(this, "checkbox1_clicked2");
  cAdjacentMerge.setSelected(true);
  label20 = new GLabel(controlWindow, 234, 360, 90, 36);
  label20.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label20.setText("Right Shadow Removal");
  label20.setOpaque(true);
  cShadowRemove = new GCheckbox(controlWindow, 324, 360, 144, 36);
  cShadowRemove.setIconPos(GAlign.SOUTH);
  cShadowRemove.setTextAlign(GAlign.LEFT, GAlign.WEST);
  cShadowRemove.setText("                 Remove?");
  cShadowRemove.setOpaque(false);
  cShadowRemove.addEventHandler(this, "checkbox2_clicked2");
  cShadowRemove.setSelected(true);
  label21 = new GLabel(controlWindow, 0, 0, 234, 54);
  label21.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label21.setText("Region Of Interest");
  label21.setTextBold();
  label21.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  label21.setOpaque(true);
  label22 = new GLabel(controlWindow, 0, 90, 90, 36);
  label22.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label22.setText("Offset X");
  label22.setOpaque(true);
  label23 = new GLabel(controlWindow, 0, 126, 90, 36);
  label23.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label23.setText("Offset Y");
  label23.setOpaque(true);
  label24 = new GLabel(controlWindow, 0, 162, 90, 36);
  label24.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label24.setText("Width");
  label24.setOpaque(true);
  label25 = new GLabel(controlWindow, 0, 198, 90, 36);
  label25.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label25.setText("Height");
  label25.setOpaque(true);
  label26 = new GLabel(controlWindow, 0, 54, 90, 36);
  label26.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label26.setText("ROI");
  label26.setOpaque(true);
  roi = new GCheckbox(controlWindow, 90, 54, 144, 36);
  roi.setIconPos(GAlign.SOUTH);
  roi.setText("                  Enable?");
  roi.setOpaque(false);
  roi.addEventHandler(this, "checkbox1_clicked3");
  roiX = new GSlider(controlWindow, 90, 90, 144, 36, 10.0);
  roiX.setShowValue(true);
  roiX.setShowLimits(true);
  roiX.setLimits(70, 0, 640);
  roiX.setNumberFormat(G4P.INTEGER, 0);
  roiX.setOpaque(false);
  roiX.addEventHandler(this, "slider1_change7");
  roiY = new GSlider(controlWindow, 90, 126, 144, 36, 10.0);
  roiY.setShowValue(true);
  roiY.setShowLimits(true);
  roiY.setLimits(110, 0, 480);
  roiY.setNumberFormat(G4P.INTEGER, 0);
  roiY.setOpaque(false);
  roiY.addEventHandler(this, "slider2_change4");
  roiWidth = new GSlider(controlWindow, 90, 162, 144, 36, 10.0);
  roiWidth.setShowValue(true);
  roiWidth.setShowLimits(true);
  roiWidth.setLimits(400, 0, 640);
  roiWidth.setNumberFormat(G4P.INTEGER, 0);
  roiWidth.setOpaque(false);
  roiWidth.addEventHandler(this, "slider3_change3");
  roiHeight = new GSlider(controlWindow, 90, 198, 144, 36, 10.0);
  roiHeight.setShowValue(true);
  roiHeight.setShowLimits(true);
  roiHeight.setLimits(355, 0, 480);
  roiHeight.setNumberFormat(G4P.INTEGER, 0);
  roiHeight.setOpaque(false);
  roiHeight.addEventHandler(this, "slider4_change3");
  controlWindow.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow controlWindow;
GLabel label1; 
GLabel label2; 
GToggleGroup togGroup1; 
GOption knn; 
GOption mog2; 
GLabel label3; 
GLabel label4; 
GLabel label5; 
GSlider bgHistory; 
GSlider bgKnnThreshold; 
GCheckbox bgShadows; 
GLabel label6; 
GSlider bgLearning; 
GLabel label7; 
GLabel label8; 
GLabel label9; 
GSlider dilateKernelSize; 
GSlider dilateIterations; 
GButton button1; 
GCheckbox bgLearningAuto; 
GLabel label10; 
GSlider bgMog2Threshold; 
GLabel label11; 
GSlider morphNoiseSize; 
GLabel label12; 
GLabel label13; 
GLabel label14; 
GLabel label15; 
GLabel label16; 
GSlider cMinWidth; 
GSlider cMaxWidth; 
GSlider cMinHeight; 
GSlider cMaxHeight; 
GLabel label17; 
GSlider cDistanceThreshold; 
GLabel label18; 
GSlider erodeKernelSize; 
GLabel label19; 
GSlider erodeIterations; 
GCheckbox cAdjacentMerge; 
GLabel label20; 
GCheckbox cShadowRemove; 
GLabel label21; 
GLabel label22; 
GLabel label23; 
GLabel label24; 
GLabel label25; 
GLabel label26; 
GCheckbox roi; 
GSlider roiX; 
GSlider roiY; 
GSlider roiWidth; 
GSlider roiHeight; 
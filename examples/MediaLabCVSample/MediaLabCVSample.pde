import processing.video.*;

import gbr.medialabcv.MediaLabCV;

import java.awt.*;

import g4p_controls.*;

Movie video;
MediaLabCV mediacv;

boolean initTracking = false;

int areaX,areaY, areaWidth, areaHeight;

boolean doExit = false;

int[] colors = new int[]{
  color(255,255,0,64),
  color(255,0,255,64),
  color(0,255,255,64),
  color(255,0,0,64),
  color(0,255,0,64),
  color(0,0,255,64),
};


void setup() {
  //size(1920, 960);
  
  fullScreen();
  frameRate(60);
  
  
  createGUI();
  
  mediacv = new MediaLabCV(this);
  
  video = new Movie(this, "geoplano2.mp4"); 
  video.loop();
  video.play();
}

void draw() {
  
  if(doExit){
    //noLoop();
    //return;
    video.stop();
    exit();
  }
  
  background(200);
  
  image(video, video.width, 0);
  
  image(video, video.width*2, 0);
  
  tracking();
  
  
}

void movieEvent(Movie m) {
  m.read();
  if(!initTracking && video.width>0 && video.height>0){
    println("Input Video: "+video.width+"x"+video.height);
    resetMediaLabCV();
    initTracking = true;
  }
}
  
void resetMediaLabCV(){
    
    initMediaLabCV();
    setROI();
    startBG();
    
}

void initMediaLabCV(){
  
  mediacv.init(video.width,video.height);
  
  setContourSizes();

}

void startBG(){
  int history = bgHistory.getValueI();
  double threshold = knn.isSelected() ? bgKnnThreshold.getValueF() : bgMog2Threshold.getValueF();
  boolean shadows = bgShadows.isSelected();
  if(knn.isSelected())
    mediacv.createBackgroundSubtractorKNN(history,threshold, shadows);
  else
    mediacv.createBackgroundSubtractorMOG2(history,threshold, shadows);
}


void setROI(){
  if(roi.isSelected()){
    mediacv.enableROI(roiX.getValueI(), roiY.getValueI(), roiWidth.getValueI(), roiHeight.getValueI());
  }else{
    mediacv.disableRoi();
  }
}

void tracking(){
  if(initTracking){
      
    //Send the frame to MediaLabCV
    mediacv.setInput(video);
    
    //Display received frame to ensure correctness
    image(mediacv.getInput(), 0, 0);
    
    //Draw Roi
    noFill();
    strokeWeight(2);
    stroke(0,255,255);
    rect(roiX.getValueI(), roiY.getValueI(), roiWidth.getValueI(), roiHeight.getValueI());
  


    double learningRate = bgLearningAuto.isSelected() ? -1 : bgLearning.getValueF();
    
    //Apply background substractor with sent frame
    if(knn.isSelected())
      mediacv.applyBackgroundSubtractorKNN(learningRate);
    else
      mediacv.applyBackgroundSubtractorMOG2(learningRate);
    
    
    //Remove noise
    int noiseSize = morphNoiseSize.getValueI();
    if(noiseSize>0) mediacv.erode(noiseSize,1);
    image(mediacv.getOutput(), 0, video.height);
    
    
    //Asymmetric closing
    mediacv.dilate(dilateKernelSize.getValueI(),dilateIterations.getValueI());
    image(mediacv.getOutput(), video.width, video.height);
    
    mediacv.erode(erodeKernelSize.getValueI(),erodeIterations.getValueI());
    image(mediacv.getOutput(), video.width*2, video.height);
    
    //Default detections
    
    //Bounding Box
    Rectangle [] boundingBoxes = mediacv.findBoundingBoxes();
    stroke(0, 0, 255);
    for(int i=0; i< boundingBoxes.length;i++) {
        Rectangle rect = boundingBoxes[i];
        rect(rect.x, rect.y, rect.width, rect.height);
    }
    
    //Polygon
    stroke(0, 255, 0);
    Polygon [] temp = mediacv.findTriangle();
    for(int i=0; i< temp.length;i++) {
        Polygon poly = temp[i];
        paintPolygon(poly);
    }

    //Triangle
    stroke(255, 0, 255);
    temp = mediacv.findPolygons(0.1);
    for(int i=0; i< temp.length;i++) {
        Polygon poly = temp[i];
        paintPolygon(poly);
    }
    
    //Advanced detections
    boundingBoxes = mediacv.findBoundingBoxes(cAdjacentMerge.isSelected(), cShadowRemove.isSelected(),
                                              cDistanceThreshold.getValueF(),
                                              contourMinWidth,contourMaxWidth,contourMinHeight,contourMaxHeight);
    stroke(255, 0, 0);
    for(int i=0; i< boundingBoxes.length;i++) {
        Rectangle rect = boundingBoxes[i];
        noFill();
        rect(rect.x+video.width, rect.y, rect.width, rect.height);
        
        fill(255);
        text(i, rect.x+video.width, rect.y);
    }
    
    //Tracking
    boundingBoxes = mediacv.track(boundingBoxes);
    Rectangle [] node = mediacv.getNodes(boundingBoxes);
    for(int i=0; i< node.length;i++) {
      fill(colors[i%colors.length]);
      stroke(colors[i%colors.length]);
      
      Rectangle rect = node[i];
      ellipse(rect.x+video.width*2, rect.y, rect.width, rect.height);
      fill(0);
      text(i, rect.x+video.width*2, rect.y);
    }
    
  }
}

/*************
**GUI Events**
**************/

void onMediaLabCVBgSubtractorParameterChange(){
  startBG();
}

int contourMinWidth,contourMaxWidth,contourMinHeight,contourMaxHeight;

void onMediaLabCVContourParameterChange(){
  setContourSizes();
} 

void onMediaLabCVROIParameterChange(){
  if(roi.isSelected()){
    resetMediaLabCV();
  }
} 

void setContourSizes(){
  contourMinWidth=round(cMinWidth.getValueF()*video.width);
  contourMaxWidth=round(cMaxWidth.getValueF()*video.width);
  contourMinHeight=round(cMinHeight.getValueF()*video.height);
  contourMaxHeight=round(cMaxHeight.getValueF()*video.height);
}


/*********
**Helper**
**********/

void paintPolygon(Polygon poly){
    beginShape();
    for(int n=0;n<poly.npoints;n++){
      vertex(poly.xpoints[n], poly.ypoints[n]);
    }
    endShape(CLOSE);
}

void printBoundingBoxes(Rectangle [] boundingBoxes){
  for(Rectangle rect : boundingBoxes) {
          println("new Rectangle("+rect.x+","+rect.y+","+rect.width+","+rect.height+"),");
  }
  println("-----------------------");
}
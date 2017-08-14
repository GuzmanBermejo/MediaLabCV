package gbr.medialabcv;

import org.opencv.core.*;

import org.opencv.core.Point;
import org.opencv.imgproc.Imgproc;
import org.opencv.video.BackgroundSubtractor;
import org.opencv.video.BackgroundSubtractorKNN;
import org.opencv.video.BackgroundSubtractorMOG2;
import org.opencv.video.Video;

import processing.core.*;

import java.awt.*;
import java.awt.geom.RectangularShape;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.IntBuffer;
import java.util.*;


import static java.lang.Math.toIntExact;


/**
 * MediaLabCV is a Processing library which consists on an OpenCV limited wrapper for object detection and tracking.
 * Created by gbermejo on 09/08/2017.
 */
public class MediaLabCV {
    private final PApplet parent;

    private int width, height;

    private BackgroundSubtractorKNN knn;
    private BackgroundSubtractorMOG2 mog2;

    private Mat input, output, fgmask;
    private PImage image;

    public MediaLabCV(PApplet parent) {
        this.parent = parent;

        parent.registerMethod("dispose", this);

        loadNative();

        initMessage();

    }

    public void dispose() {
        // Anything in here will be called automatically when
        // the parent sketch shuts down. For instance, this might
        // shut down a thread used by this library.
    }

    /********************
     ***Initialization***
     ********************/

    public void init(int width, int height){

        this.width = width;
        this.height = height;

        input = new Mat(height, width, CvType.CV_8UC4);
        output = new Mat(height, width, CvType.CV_8UC4);

        fgmask = new Mat(height, width, CvType.CV_8UC1);

        image = parent.createImage(width, height, PConstants.ARGB);

        isRoiEnabled=false;
    }

    private void initMessage() {
        String message = " **MediaLabCV (OpenCV v." + Core.VERSION+") by @GuzmanBermejo**";
        String asterisks = String.join("", Collections.nCopies(message.length()-1, "*"));
        String nl = System.getProperty("line.separator");
        System.out.println(nl+"/"+asterisks);
        System.out.println(message);
        System.out.println(" "+asterisks+"/"+nl);
    }

    /*********
     ***ROI***
     *********/
    private boolean isRoiEnabled;
    private Rect roi;
    public void enableROI(int roiX, int roiY, int roiWidth, int roiHeight){

        if(roiX<0 || roiY<0 ||
                roiWidth<1 || roiHeight<1 ||
                roiX + roiWidth > width ||roiY + roiHeight > height){
            System.out.println("Roi ("+roiX+", "+roiY+", "+(roiX+roiWidth)+", "+(roiY+roiHeight)+") out of bounds in image (0, 0, "+width+", "+height+").");
            return;
        }

        roi = new Rect(roiX, roiY, roiWidth, roiHeight);

        fgmask = new Mat(roiHeight, roiWidth, CvType.CV_8UC1);

        isRoiEnabled = true;
    }

    public void disableRoi(){
        isRoiEnabled = false;
    }

    public Rectangle getRoi(){
        return new Rectangle(roi.x, roi.y, roi.width, roi.height);
    }

    private Rectangle[] correctRoiRectanglePosition(ArrayList<Rectangle>shapes){

        Rectangle[] corrected = new Rectangle[shapes.size()];

        if(isRoiEnabled){
            for(int i=0;i<corrected.length;i++){
                Rectangle r = shapes.get(i);
                r.translate(roi.x, roi.y);
                corrected[i]=r;
            }
        }else{
            shapes.toArray(corrected);
        }

        return corrected;
    }

    private Polygon[] correctRoiPolygonPosition(ArrayList<Polygon>shapes){

        Polygon[] corrected = new Polygon[shapes.size()];

        if(isRoiEnabled){
            for(int i=0;i<corrected.length;i++){
                Polygon r = shapes.get(i);
                r.translate(roi.x, roi.y);
                corrected[i]=r;
            }
        }else{
            shapes.toArray(corrected);
        }

        return corrected;
    }

    /*********
     ***I/O***
     *********/

    public void setInput(PImage image){
        image2Mat(image, input);
    }

    public PImage getInput(){
        mat2Image(input, image);
        return image;
    }

    public PImage getOutput(){

        if(isRoiEnabled) {
            input.copyTo(output);
            Imgproc.cvtColor(fgmask, output.submat(roi), Imgproc.COLOR_GRAY2RGBA);
        }else {
            Imgproc.cvtColor(fgmask, output, Imgproc.COLOR_GRAY2RGBA);//Convert from grey scale to rgba
        }

        mat2Image(output, image);
        return image;
    }

    /***************************
    ***Background Subtraction***
    ****************************/
    public void createBackgroundSubtractorKNN(){
        createBackgroundSubtractorKNN(500,400,true);
    }

    public void createBackgroundSubtractorKNN(int history, double dist2Threshold, boolean detectShadows){
        knn = Video.createBackgroundSubtractorKNN(history, dist2Threshold, detectShadows);
    }

    public void applyBackgroundSubtractorKNN(){
        applyBackgroundSubtractor(knn);
    }

    public void applyBackgroundSubtractorKNN(double learningRate){
        applyBackgroundSubtractor(knn, learningRate);
    }

    public void createBackgroundSubtractorMOG2(){
        createBackgroundSubtractorMOG2(500,16,true);
    }

    public void createBackgroundSubtractorMOG2(int history, double varThreshold, boolean detectShadows){
        mog2 = Video.createBackgroundSubtractorMOG2(history, varThreshold, detectShadows);
    }

    public void applyBackgroundSubtractorMOG2(){
        applyBackgroundSubtractor(mog2);
    }

    public void applyBackgroundSubtractorMOG2(double learningRate){
        applyBackgroundSubtractor(mog2, learningRate);
    }

    private void applyBackgroundSubtractor(BackgroundSubtractor backgroundSubtractor){
        applyBackgroundSubtractor(backgroundSubtractor,-1);
    }
    private void applyBackgroundSubtractor(BackgroundSubtractor backgroundSubtractor, double learningRate){

        if (isRoiEnabled)
            backgroundSubtractor.apply(input.submat(roi), fgmask, learningRate);
        else
            backgroundSubtractor.apply(input, fgmask, learningRate);


    }

    /***************************
     ***Image Transformations***
     ***************************/

    //Mathematical Morphology
    public void dilate(){
        dilate(3,1);
    }

    public void dilate(int size, int iterations){
        executeMorphOp(Imgproc.MORPH_DILATE, size, iterations);
    }

    public void erode(){
        erode(3,1);
    }

    public void erode(int size, int iterations){
        executeMorphOp(Imgproc.MORPH_ERODE, size, iterations);
    }

    public void opening(){
        opening(3,1);
    }

    public void opening(int size, int iterations){
        executeMorphOp(Imgproc.MORPH_OPEN, size, iterations);
    }

    public void closing(){
        closing(3,1);
    }

    public void closing(int size, int iterations){
        executeMorphOp(Imgproc.MORPH_CLOSE, size, iterations);
    }


    private void executeMorphOp(int operation, int size, int iterations){
        //Done with a square kernel and anchor at the center
        Mat element = Imgproc.getStructuringElement(Imgproc.MORPH_RECT, new  Size(size, size));
        Imgproc.morphologyEx(fgmask, fgmask, operation, element, new Point(-1, -1), iterations);
    }

    //Other
    public void distanceTransform(int maskSize, int distanceType){

        if(maskSize!=0 && maskSize!=3 && maskSize!=5) {
            System.out.println("Mark size " + maskSize + " not supported.");
            return;
        }

        if(!inRange(distanceType, Imgproc.DIST_L1, Imgproc.DIST_HUBER)) {
            System.out.println("Distance type " + distanceType + " not supported.");
            return;
        }

        Mat temp = new Mat();
        Imgproc.distanceTransform(fgmask, temp, distanceType, maskSize);

        //Convert to grey scale 8 bit unsigned
        Core.normalize(temp, temp, 0, 1., Core.NORM_MINMAX);
        temp.convertTo(fgmask,CvType.CV_8UC1,255.0);
    }

    public void threshold(int threshold, int thresholdType) {

        if(!inRange(thresholdType, Imgproc.THRESH_BINARY, Imgproc.THRESH_TOZERO_INV)) {
            System.out.println("Threshold type " + thresholdType + " not supported.");
            return;
        }

        threshold= PApplet.constrain(threshold, 0,255);

        Imgproc.threshold(fgmask, fgmask, threshold, 255, thresholdType);
    }

    /****************
     ***Contouring***
     ****************/

    private ArrayList<MatOfPoint> findContours(){

        ArrayList<MatOfPoint> contours = new ArrayList<>();
        Imgproc.findContours(fgmask, contours,new Mat(), Imgproc.RETR_EXTERNAL,  Imgproc.CHAIN_APPROX_SIMPLE);

        return contours;
    }

    //Bounding Boxes
    public Rectangle[] findBoundingBoxes(){
        return findBoundingBoxes(false, false, 0, 0, fgmask.width(), 0, fgmask.height());
    }

    public Rectangle[] findBoundingBoxes(int minWidth, int maxWidth, int minHeight, int maxHeight){
        return findBoundingBoxes(false, false, 0, minWidth, maxWidth,  minHeight,  maxHeight);
    }

    public Rectangle[] findBoundingBoxes(boolean doAdjacentMerge, boolean doShadowRemoval, double threshold, int minWidth, int maxWidth, int minHeight, int maxHeight){

        ArrayList<MatOfPoint> contours = findContours();

        if(doAdjacentMerge)
            contours = mergeAdjacentContours(contours, threshold);

        ArrayList<Rectangle>boundingBoxes = new ArrayList<>();

        for(MatOfPoint contour: contours){
            //Bounding Box
            Rect r = Imgproc.boundingRect(contour);

            if(doShadowRemoval){
                //Bounding Triangle
                MatOfPoint2f triangle = new MatOfPoint2f();
                Imgproc.minEnclosingTriangle(contour, triangle);

                Point[] trianglePoints = triangle.toArray();

                //Point[] targetPoints =  horizontalFlip(trianglePoints);
                Point[] targetPoints =  new Point[]{
                        r.tl(),//Top Left
                        new Point(r.br().x,r.tl().y),//Top Right
                        //new Point(r.tl().x,r.br().y),//Bottom Left
                        //r.br()//Bottom Right
                };

                double middleX = (r.br().x+r.tl().x)/2.0;
                //double middleX = r.br().x;
                double closestToMiddleX = 0;
                double minDistance = Double.MAX_VALUE;

                for(int n=0; n<trianglePoints.length;n++) {
                    Point t1 = trianglePoints[n];
                    for(int m=n+1; m<trianglePoints.length;m++) {
                        Point t2 = trianglePoints[m];
                        //We have the triangle's edge
                        for(int a=0; a<targetPoints.length;a++) {
                            Point ft1 = targetPoints[a];
                            for(int b=a+1; b<targetPoints.length;b++) {
                                Point ft2 = targetPoints[b];
                                //We have the other edge
                                Point p = intersectionLines(t1,t2,ft1,ft2);
                                if(p!=null){
                                    double dist = Math.abs(middleX-p.x);
                                    if(minDistance>dist){
                                        closestToMiddleX=p.x;
                                        minDistance=dist;
                                    }
                                }

                            }
                        }

                    }
                }

                double distToLeft=Math.abs(r.tl().x-closestToMiddleX);

                int x = toIntExact(Math.round(r.tl().x));
                int width =toIntExact(Math.round(distToLeft));

                if(width<=minWidth)
                    width=minWidth;

                if(inRange(r.width, minWidth, maxWidth) && inRange(r.height, minHeight, maxHeight))
                    boundingBoxes.add(new Rectangle(x, r.y, width, r.height));
            }else{
                if(inRange(r.width, minWidth, maxWidth) && inRange(r.height, minHeight, maxHeight))
                    boundingBoxes.add(new Rectangle(r.x, r.y, r.width, r.height));
            }
        }

        return correctRoiRectanglePosition(boundingBoxes);
    }



    private static ArrayList<MatOfPoint> mergeAdjacentContours(ArrayList<MatOfPoint> contours, double distanceThreshold){

        Rect[] boundingBoxes =getBoundingBoxes(contours);

        ArrayList<Tuple<Integer>> pairs = getPairs(boundingBoxes, distanceThreshold);

        ArrayList<ArrayList<Integer>> sets = mergePairs(pairs);

        ArrayList<MatOfPoint>result = new ArrayList<>();


        //Merge contours boxes
        for(ArrayList<Integer> set : sets){
            ArrayList<Point> points = new ArrayList<>();
            for(int index : set){
                points.addAll(contours.get(index).toList());
            }
            result.add(new MatOfPoint(points.toArray(new Point[points.size()])));
        }

        //Add single ones
        for(int i=0; i<boundingBoxes.length;i++){
            boolean add = true;
            for(ArrayList<Integer> set : sets){
                if(set.contains(i)){
                    add=false;
                    break;
                }
            }
            if(add)result.add(contours.get(i));
        }

        return result;
    }

    //Other Shapes
    public Polygon[] findMinAreaRects(int minWidth, int maxWidth, int minHeight, int maxHeight){

        ArrayList<MatOfPoint> contours = findContours();

        ArrayList<Polygon>polygons = new ArrayList<>();

        for(MatOfPoint contour : contours){
            MatOfPoint2f points = new MatOfPoint2f();
            contour.convertTo(points, CvType.CV_32F);

            RotatedRect rot = Imgproc.minAreaRect(points);
            Rect r = rot.boundingRect();
            if(inRange(r.width, minWidth, maxWidth) && inRange(r.height, minHeight, maxHeight)) {
                Polygon polygon = new Polygon();

                Point[] pts = new Point[4];
                rot.points(pts);

                for(Point p : pts) {
                    polygon.addPoint((int)p.x, (int)p.y);
                }

                polygons.add(polygon);
            }
        }

        return correctRoiPolygonPosition(polygons);
    }


    public Polygon[] findPolygons(double epsilon){

        ArrayList<MatOfPoint> contours = findContours();

        ArrayList<Polygon>polygons = new ArrayList<>();

        for(MatOfPoint contour : contours){
            MatOfPoint2f curve = new MatOfPoint2f();
            contour.convertTo(curve, CvType.CV_32F);

            MatOfPoint2f approxCurve = new MatOfPoint2f();
            Imgproc.approxPolyDP(curve, approxCurve, epsilon, true);

            Polygon polygon = new Polygon();

            Point[] pts = approxCurve.toArray();

            for(Point p : pts) {
                polygon.addPoint((int)p.x, (int)p.y);
            }

            polygons.add(polygon);

        }

        return correctRoiPolygonPosition(polygons);
    }

    public Polygon[] findConvexHulls(){

        ArrayList<MatOfPoint> contours = findContours();

        ArrayList<Polygon>polygons = new ArrayList<>();

        for(MatOfPoint contour : contours){
            MatOfInt hull = new MatOfInt();
            Imgproc.convexHull(contour, hull);

            Polygon polygon = new Polygon();

            int[] indexes = hull.toArray();

            Point[] pts = contour.toArray();

            for(int n : indexes) {
                Point p = pts[n];
                polygon.addPoint((int)p.x, (int)p.y);
            }

            polygons.add(polygon);

        }

        return correctRoiPolygonPosition(polygons);
    }

    public Polygon[] findTriangle(){

        ArrayList<MatOfPoint> contours = findContours();

        ArrayList<Polygon>polygons = new ArrayList<>();

        for(MatOfPoint contour : contours){
            MatOfPoint2f triangle = new MatOfPoint2f();
            Imgproc.minEnclosingTriangle(contour, triangle);

            Polygon polygon = new Polygon();

            Point[] pts =  triangle.toArray();

            for(Point p : pts) {
                polygon.addPoint((int)p.x, (int)p.y);
            }

            polygons.add(polygon);

        }

        return correctRoiPolygonPosition(polygons);
    }

    public Rectangle[] getNodes(Rectangle[] boundingBoxes){

        Rectangle[] nodes = new Rectangle[boundingBoxes.length];

        for(int i = 0; i<boundingBoxes.length;i++){
            Rectangle bb = boundingBoxes[i];
            int radius = Math.max(bb.width, bb.height);

            java.awt.Point center = getCenter(bb);
            nodes [i] = new Rectangle(center.x,center.y,radius, radius);
        }

        return nodes;
    }


    //Helper

    private static ArrayList<Tuple<Integer>>getPairs(Rect[] boundingBoxes, double distanceThreshold){

        ArrayList<Tuple<Integer>> pairs = new ArrayList<>();

        //Make pairs of linked elements
        for(int i = 0; i<boundingBoxes.length;i++){
            for(int j = i+1; j<boundingBoxes.length;j++) {
                Rect a = boundingBoxes[i];
                Rect b = boundingBoxes[j];

                if(distance(a, b)<=distanceThreshold)pairs.add(new Tuple<>(i, j));
            }
        }

        return pairs;
    }


    private static ArrayList<ArrayList<Integer>> mergePairs(ArrayList<Tuple<Integer>> pairs){
        ArrayList<ArrayList<Integer>>sets = new ArrayList<>();

        //Merge pairs into sets
        for(int i = pairs.size()-1; i>=0 ; i--){
            Tuple<Integer> pair = pairs.get(i);

            ArrayList<Integer> set = new ArrayList<>();

            set.add(pair.x);
            set.add(pair.y);

            for(int j=0;j<set.size();j++){
                int s = set.get(j);
                for(int k = pairs.size()-1; k>=0;k--) {
                    Tuple<Integer> p = pairs.get(k);
                    if(p.contains(s)) {
                        int n = s!= p.x ? p.x:p.y;
                        if (!set.contains(n))set.add(n);
                        pairs.remove(p);
                    }
                }
            }

            sets.add(set);
            i = pairs.size()-1;
        }
        return sets;
    }

    /**************
     ***Tracking***
     **************/

    private Rectangle[] oldBoundingBoxes = new Rectangle[0];

    public Rectangle[] track(Rectangle[] newBoundingBoxes){

        Rectangle[] result = new Rectangle[newBoundingBoxes.length];

        //Really simple tracking
        //TODO improve tracking algorithm


        int oldSize = Math.min(oldBoundingBoxes.length, newBoundingBoxes.length);

        double[][] distances = new double[newBoundingBoxes.length][oldSize];
        for(int i=0; i<newBoundingBoxes.length;i++){
            java.awt.Point n = getCenter(newBoundingBoxes[i]);
            for(int j=0; j<oldSize;j++){
                java.awt.Point o = getCenter(oldBoundingBoxes[j]);
                distances[i][j]= n.distance(o);
            }
        }

        //Sort by min distances
        boolean[] newSeen = new boolean[newBoundingBoxes.length];
        boolean[] oldSeen = new boolean[oldSize];
        int seen=0;
        while(seen<newBoundingBoxes.length){
            int indexNew = -1;
            int indexOld = -1;
            double minDistance = Double.MAX_VALUE;
            for(int i=0; i<newSeen.length;i++){
                if(newSeen[i])continue;
                for(int j=0; j<oldSeen.length;j++){
                    if(oldSeen[j])continue;
                    if(minDistance>distances[i][j]){
                        minDistance = distances[i][j];
                        indexNew = i;
                        indexOld = j;
                    }
                }
            }
            if(indexNew<0 && indexOld<0) {
                for(int k=0; k<newSeen.length;k++) {
                    if (newSeen[k]) continue;
                    result[seen++] = newBoundingBoxes[k];
                }
            }else {
                newSeen[indexNew] = true;
                oldSeen[indexOld] = true;
                result[indexOld] = newBoundingBoxes[indexNew];
                seen++;
            }
        }

        //Update history, always grows
        if(result.length>oldBoundingBoxes.length) oldBoundingBoxes = new Rectangle[result.length];

        System.arraycopy(result,0,oldBoundingBoxes,0,result.length);

        return result;
    }




    /**********************
     ***Helper Functions***
     **********************/
    //OpenCV

    private static double distance(Point p1, Point p2){

        return Math.sqrt(Math.pow((p2.x-p1.x),2)+Math.pow((p2.y-p1.y),2));
    }

    private static double distance(Rect r1, Rect r2){
        double distance;

        boolean left = r2.br().x < r1.tl().x;
        boolean right = r1.br().x < r2.tl().x;
        boolean bottom = r2.br().y < r1.tl().y;
        boolean top = r1.br().y < r2.tl().y;

        if (top && left){
            distance= distance(new Point(r1.tl().x, r1.br().y), new Point(r2.br().x, r2.tl().y));
        }else if (left && bottom){
            distance= distance(new Point(r1.tl().x, r1.tl().y), new Point(r2.br().x, r2.br().y));
        }else if (bottom && right){
            distance= distance(new Point(r1.br().x, r1.tl().y), new Point(r2.tl().x, r2.br().y));
        }else if (right && top){
            distance= distance(new Point(r1.br().x, r1.br().y), new Point(r2.tl().x, r2.tl().y));
        }else if (left){
            distance= r1.tl().x - r2.br().x;
        }else if (right){
            distance= r2.tl().x - r1.br().x;
        }else if (bottom){
            distance= r1.tl().y - r2.br().y;
        }else if ( top){
            distance= r2.tl().y - r1.br().y;
        }else{//Intersection
            distance = 0;
        }
        return distance;
    }

    private static Rect [] getBoundingBoxes(ArrayList<MatOfPoint> contours){
        Rect[] boundingBoxes = new Rect[contours.size()];

        for(int i=0;i<contours.size();i++){
            boundingBoxes[i]= Imgproc.boundingRect(contours.get(i));
        }

        return boundingBoxes;
    }


    private static Point intersectionLines(Point p1, Point p2, Point p3, Point p4)
    {
        double denominator = (p1.x-p2.x)*(p3.y-p4.y)-(p1.y-p2.y)*(p3.x-p4.x);

        if(denominator==0)return null;//Parallel

        double x = ((p1.x*p2.y-p1.y*p2.x)*(p3.x-p4.x)-(p1.x-p2.x)*(p3.x*p4.y-p3.y*p4.x))/denominator;

        double y = ((p1.x*p2.y-p1.y*p2.x)*(p3.y-p4.y)-(p1.y-p2.y)*(p3.x*p4.y-p3.y*p4.x))/denominator;

        return new Point(x,y);
    }

    public static Point[] horizontalFlip(Point[] originalPoints){
        Point[] points = new Point[originalPoints.length];

        double minX = Double.MAX_VALUE;
        double maxX = Double.MIN_VALUE;
        for(Point p : originalPoints){
            minX = Math.min(minX, p.x);
            maxX = Math.max(maxX, p.x);
        }

        double axisY = (maxX+minX)/2.0;

        for(int i=0;i< originalPoints.length;i++){
            Point p = originalPoints[i];
            double interval = axisY-p.x;
            points[i]=new Point(axisY+interval,p.y);
        }

        return points;
    }

    //Java AWT
    private static java.awt.Point getCenter(RectangularShape shape){
        return new java.awt.Point(toIntExact(Math.round(shape.getCenterX())),
                toIntExact(Math.round(shape.getCenterY())));
    }

    //General
    private static boolean inRange(double value, double min, double max){
        return value>=min && value <=max;

    }

    /**********************
     ***PImage <---> Mat***
     **********************/
    private static void image2Mat(PImage image, Mat mat){

        //From PImage to Mat

        //ARGB to BGRA aka LITTLE_ENDIAN since not support with cvtColor
        ByteBuffer bb = ByteBuffer.allocate(image.pixels.length * Integer.BYTES).order(ByteOrder.LITTLE_ENDIAN);
        IntBuffer ib = bb.asIntBuffer();
        ib.put(image.pixels);


        mat.put(0,0, bb.array());
    }

    private static void mat2Image(Mat mat, PImage image){

        int[] imagePixels = new int[mat.width()*mat.height()];

        byte[] matPixels = new byte[imagePixels.length*Integer.BYTES];
        mat.get(0,0, matPixels);

        //ARGB to BGRA aka LITTLE_ENDIAN since not support with cvtColor
        ByteBuffer.wrap(matPixels).order(ByteOrder.LITTLE_ENDIAN).asIntBuffer().get(imagePixels);

        image.loadPixels();
        image.pixels = imagePixels;
        image.updatePixels();

    }

    /*******************
     ***Native OpenCV***
     *******************/

    private static boolean isNativeLoaded = false;

    //Load library
    private void loadNative(){
        if(!isNativeLoaded) {
            try {
                System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
            } catch (UnsatisfiedLinkError e) {
                try {
                    System.out.println("/lib/opencv/" + System.getProperty("sun.arch.data.model") + "/" + Core.NATIVE_LIBRARY_NAME + ".dll");
                    loadLibraryFromJar("/lib/opencv/" + System.getProperty("sun.arch.data.model") + "/" + Core.NATIVE_LIBRARY_NAME + ".dll",  parent.sketchPath());
                } catch (Exception exception) {
                    throw new RuntimeException(exception);
                }
            }
            isNativeLoaded = true;
        }
    }
    /*static{

    }*/


    private static void loadLibraryFromJar(String inPath, String sketchPath) throws IOException {


        //Filename
        String[] parts = inPath.split("/");
        String filename = parts[parts.length - 1];

        File libraryFolder  = new File(sketchPath, "opencv_native");
        libraryFolder.mkdirs();

        File libraryFile  = new File(libraryFolder, filename);

        if (!libraryFile.exists()) {

            libraryFile.createNewFile();

            InputStream is = MediaLabCV.class.getResourceAsStream(inPath);
            if (is == null) {
                throw new FileNotFoundException("File " + inPath + " not found.");
            }

            byte[] buffer = new byte[2048];
            int readBytes;

            OutputStream os = new FileOutputStream(libraryFile);
            try {
                while ((readBytes = is.read(buffer)) != -1) {
                    os.write(buffer, 0, readBytes);
                }
            } finally {
                os.close();
                is.close();
            }
        }
        System.out.println("OpenCV stored in "+libraryFile.getAbsolutePath());
        System.load(libraryFile.getAbsolutePath());
    }


}

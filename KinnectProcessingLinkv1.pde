//Code adapted and modified for Serial Connection to Arduino from 
//https://github.com/JoeMWatson/Processing/blob/master/Kinect4WinExample/Kinect4WinExample.pde

import kinect4WinSDK.*;

import processing.serial.*;


Serial port;                      // Create object from Serial class



//



Kinect kinect;
ArrayList <SkeletonData> bodies;

public void setup()
{
  size(640, 480);
   String portName = Serial.list()[1];
   noStroke(); 
  frameRate(60); 
  port = new Serial(this, portName, 9600);  
  
  
  background(0);
  kinect = new Kinect(this);
  smooth();
  bodies = new ArrayList<SkeletonData>();
}

public void draw()
{

  
  background(0);
  image(kinect.GetImage(), 320, 0, 320, 240);
  image(kinect.GetDepth(), 320, 240, 320, 240);
  image(kinect.GetMask(), 0, 240, 320, 240);
  for (int i=0; i<bodies.size (); i++) 
  {
    drawSkeleton(bodies.get(i));
    drawPosition(bodies.get(i));
    
    DrawBone(bodies.get(i),Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, Kinect.NUI_SKELETON_POSITION_HAND_LEFT);
    DrawBone(bodies.get(i),Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, Kinect.NUI_SKELETON_POSITION_HAND_RIGHT);
    
    // Get Points for the Shoulder, Elbow, and Normal  
PVector v1 = new PVector(bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT].x*width/2, bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT].y*height/2);
PVector v2 = new PVector(bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT].x*width/2, bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT].y*height/2); 
PVector v3 = new PVector(bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT].x*width/2, (bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT].y*height/2)-1);
//Convert to angle and send!
float a = getAngle(v1,v2,v3);
 a = (Math.abs(a)) - 180; 
int angle = Math.round(Math.abs(a));
int anglef = PApplet.parseInt(map(angle, 0, 180, 1, 180));
//println('a');
//println(anglef);  // Prints "10.304827"
//port.write('a');
//port.write(anglef);

   
//Do it again for the elbow and hands
 PVector v1b = new PVector(bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT].x*width/2, bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT].y*height/2);
PVector v2b = new PVector(bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_WRIST_LEFT].x*width/2, bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_WRIST_LEFT].y*height/2); 
PVector v3b = new PVector(bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT].x*width/2, (bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT].y*height/2)-1);
//Convert to angle and send!
float a2 = getAngle(v1b,v2b,v3b);
 a2 = (Math.abs(a2)) - 180; 
int angle2 = Math.round(Math.abs(a2));
int anglef2 = PApplet.parseInt(map(angle2, 0, 180, 1, 180));
//println('b');
//println(anglef2); // Prints "10.304827"
//port.write('b');
//port.write(anglef2);
port.write(anglef + "," + anglef2)
   
  }
}
 public float getAngle(PVector v1, PVector v2, PVector v3) {
  float l1x = v2.x - v1.x;
  float l1y = v2.y - v1.y;
  float l2x = v3.x - v1.x;
  float l2y = v3.y - v1.y;

  float angle1 = (float)Math.atan2(l1y, l1x);
  float angle2 = (float) Math.atan2(l2y, l2x);
  float degree=degrees((float)angle1-(float)angle2);

  if (degree < 0) { 
    degree += 360;
  }
  return degree;
}
public void drawPosition(SkeletonData _s) 
{
  noStroke();
  fill(0, 100, 255);
  String s1 = str(_s.dwTrackingID);
  
  text(s1, _s.position.x*width/2, _s.position.y*height/2);
}

public void drawSkeleton(SkeletonData _s) 
{
  
  // Body
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HEAD, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
  Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, 
  Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SPINE, 
  Kinect.NUI_SKELETON_POSITION_HIP_CENTER);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HIP_CENTER, 
  Kinect.NUI_SKELETON_POSITION_HIP_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HIP_CENTER, 
  Kinect.NUI_SKELETON_POSITION_HIP_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HIP_LEFT, 
  Kinect.NUI_SKELETON_POSITION_HIP_RIGHT);

  // Left Arm
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, 
  Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT, 
  Kinect.NUI_SKELETON_POSITION_WRIST_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_WRIST_LEFT, 
  Kinect.NUI_SKELETON_POSITION_HAND_LEFT);

  // Right Arm
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_HAND_RIGHT);

  // Left Leg
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HIP_LEFT, 
  Kinect.NUI_SKELETON_POSITION_KNEE_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_KNEE_LEFT, 
  Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT, 
  Kinect.NUI_SKELETON_POSITION_FOOT_LEFT);

  // Right Leg
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HIP_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_FOOT_RIGHT);
}

public void DrawBone(SkeletonData _s, int _j1, int _j2) 
{
  noFill();
  stroke(255, 255, 0);
  if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j2] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
    line(_s.skeletonPositions[_j1].x*width/2, 
    _s.skeletonPositions[_j1].y*height/2, 
    _s.skeletonPositions[_j2].x*width/2, 
    _s.skeletonPositions[_j2].y*height/2);
    
  }
}

public void appearEvent(SkeletonData _s) 
{
  if (_s.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    bodies.add(_s);
  }
}

public void disappearEvent(SkeletonData _s) 
{
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_s.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.remove(i);
      }
    }
  }
}

public void moveEvent(SkeletonData _b, SkeletonData _a) 
{
  if (_a.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_b.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.get(i).copy(_a);
        break;
      }
    }
  }
}

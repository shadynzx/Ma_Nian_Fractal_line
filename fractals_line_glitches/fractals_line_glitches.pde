import ddf.minim.*;
import ddf.minim.analysis.*;

int _numChildren = 3;
int _maxLevels =7;
Minim minim;
VizAudio vizAudio;
Branch _trunk;
float moveZ ;
ArrayList<PImage>buffer=new ArrayList<PImage>();
ArrayList<color[]>colorList=new ArrayList<color[]>();
float   m_faudioX = 0.;
float   m_faudioY = 0.;
boolean drawBranchFlag = false;
boolean start=false;
boolean startGlitchFlag = false;
boolean slit_glitchFlag = false;
int n=0;
int lines_num=720;



void setup() {
  size(1280, 768, P3D);
  smooth();
  noFill();
  newTree();
  minim = new Minim(this);
  vizAudio = new VizAudio(minim);
  frameRate(30);
}
void draw() {
  pushMatrix();
  vizAudio.draw();  
  background(m_faudioX*255);
  rectMove();

  //fill(0, 0, 222);

  // rect(0,0,width/2,height/2);
  translate(width/2, height/2, -3000);
  rotateX(180);
  _trunk.updateMe(0, 0, 0);
  if (drawBranchFlag) {

    _trunk.drawMe();
    _trunk. maudioMove();
  }
  popMatrix();
  if (startGlitchFlag) {
    onscene_glitch(15, 3, 0.9);
    digital_glitch(2);
    
    println(mouseX, mouseY);
  }
  if(slit_glitchFlag){
    slit_glitch(0, 0, width, height, 0.8);
  }
}
void newTree() {
  _trunk = new Branch(1, 0, width/2, 50, 1000);
  //_trunk.drawMe();
}
void rectMove() {
  for (int i = -1000; i < 50000; i+=200) {
    pushMatrix();
    translate(0, 0, m_faudioX*500);
    pushMatrix();
    translate(width/2, height/2, -i);
    //rotate(moveZ);
    rectMode(CENTER);
    //stroke(225, 0, 0);
    strokeWeight(0.8*m_faudioY/2);
    noFill();
    rect(1, -1*m_faudioX, 2000, 2000);
    moveZ+=0.05;
    if (moveZ >5500) {
      moveZ =0.00001;
    }
    popMatrix();
    popMatrix();
  }
}


void keyPressed() {
  if (key == 'a')
    drawBranchFlag =! drawBranchFlag;
  else if (key == 's')
    startGlitchFlag =! startGlitchFlag;
  else if (key == 'd')
    slit_glitchFlag =! slit_glitchFlag;
}
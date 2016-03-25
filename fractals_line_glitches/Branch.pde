class Branch {
  float strokeW, alph;
  float len, lenChange;
  float rot, rotChange;

  float m_audioX;
  float m_audioY;
  float level, index;
  float x, y, z;
  float endx, endy, endz;
  Branch[]children = new Branch[0];

  Branch(float lev, float ind, float ex, float why, float zed) {
    level = lev;
    index = ind;
    updateMe(ex, why, zed);
    strokeW = (1/level)*100;
    alph = 255/level;
    len = (1/level)*random(200);
    rot = random(360);
    lenChange = random(10)-5;
    rotChange = random(10)-5;
    if (level < _maxLevels) {
      children = new Branch[_numChildren];
      for (int x = 0; x < _numChildren; x++) {
        children[x] = new Branch(level+1, x, endx, endy, endz);
      }
    }
  }


  void updateMe(float ex, float why, float zed) {
    x = ex;
    y = why;
    z = zed;
    rot += rotChange;
    if (rot >360) {
      rot = 0;
    } else if (rot < 0) {
      rot = 360;
    }
    len -= lenChange;
    if (len < 0) {
      lenChange *= -1;
    } else if (len > 300) {
      lenChange *= -1;
    }
    float radian = radians(rot);
    endx = x+ (len*cos(radian));
    endy = y+ (len*sin(radian));
    endz = z+ (-len*cos(radian));
    for (int i = 0; i < children.length; i++) {
      children[i].updateMe(endx, endy, endz);
    }
  }

  void drawMe() {
    if (level>1) {
      stroke(alph*len, alph/len, endy, alph);
      fill(0);
      strokeWeight(strokeW/6);
      bezier(x*m_faudioX, y*m_faudioX, z, x*2.3, y*m_faudioY, z*2.5, endx*5.6, endy*6.5, 20, endx, endy, endz);

      line(x*m_faudioX, y*m_faudioX, endy, endy, endz, z);
      //line(x, y+1000, endx, endy, x*endx/20, y*endy/20);

      ellipse(endx, endy, len/12, len/12);
      strokeWeight(strokeW/6*m_faudioX);
      point(endy-1000, endy+600, endz);
    }

    for (int i = 0; i <children.length; i ++) {
      children[i].drawMe();
    }
  }
  void maudioMove() {
    m_faudioX=map(m_faudioX, 0, 100, 0, 1); 
    m_faudioY=map(m_faudioY, 0, 100, 0, 1); 
    m_faudioX=constrain(m_faudioX, 0, 10);
    m_faudioY=constrain(m_faudioY, 0, 10)/3.;

    println(m_audioX);
  }
}
void slit_glitch(int sX,int sY,int w,int h,float threashhold) {
  loadPixels();
  color[] tempColor2=new color[pixels.length];
  for (int i=0; i<pixels.length; i++) {
    tempColor2[i]=pixels[i];
  }
  //println(pixels.length);
  colorList.add(tempColor2);
  n++;
  if (n==lines_num) {
    n=0;  
    start=true;
  }
  if (start==true) {
    //int scale=(height)/lines_num;
    for (int k=sY; k<h; k++) {
      for (int p=sX; p<w; p++) {
        if (k<lines_num) {
          pixels[k*width+p]=colorList.get(k)[k*width+p];
        }
      }
    }
    colorList.remove(0);
  }

  updatePixels();
  //image(tempImg, 0, 0);
  //for (int i =0; i<buffer.size(); i++) {
  //  image(buffer.get(i).get(0, i*scale, width*2, (i+1)*scale), 0, i*scale);
  //}
  if (random(1)<threashhold) {
    for (int i=0; i<pixels.length; i++) {
      pixels[i]=tempColor2[i];
    }
    updatePixels();
  }
}

void onscene_glitch(int size, int max_num,float threashhold) {
  int start_point=int(random(height-size));
  for (int i=0; i<max_num; i++) {
    PImage temp_canvas=get(0, start_point, width*2, int(random(size)));
    buffer.add(temp_canvas);
  }

  if (random(1)<threashhold) {
    for (int i=0; i<buffer.size(); i++) {
      image(buffer.get(0), 0, random(height-size));
      buffer.clear();
    }
  }
}

void digital_glitch(int size) {
  int new_random=int(random(width-size));
  if (int(random(3))==0) {
    stroke(255, 0, 0);
  } else if (int(random(3))==0) {
    stroke(0, 0, 255);
  } else {
    stroke(0, 255, 0);
  }
  line(new_random, 0, new_random, height*2);
}
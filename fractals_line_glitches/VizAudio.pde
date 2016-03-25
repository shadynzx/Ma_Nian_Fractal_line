class VizAudio {

  int startX = 10;
  int leftY = height-20;
  int rightY = height-200;
  int specY = height-100;
  int avgY = height-180;
  int logY = height-260;
  int scaleY = 200;
  int spectrumScale = 4;
  int avgSize=30;
  int aw = 512/avgSize;
  int sw = 2;
  float[] faudio = new float[avgSize];

  AudioInput in;
  FFT fftLin;
  FFT fftLog;

  VizAudio(Minim minim) {
    in = minim.getLineIn();
    fftLin = new FFT(in.bufferSize(), in.sampleRate());
    fftLin.linAverages(30);
    fftLog = new FFT(in.bufferSize(), in.sampleRate());
    fftLog.logAverages(22, 3);
  }

  void draw() {
    int  i;
    fftLin.forward(in.mix);
    fftLog.forward(in.mix);
    text("faudioX "+(int)(m_faudioX*100.), 15, height-330);
    text("faudioY "+(int)(m_faudioY*100.), 15, height-360);
    for (i=0; i<fftLin.avgSize(); i++) {
      faudio[i]=fftLin.getAvg(i);
    }
    m_faudioY=(faudio[0]+faudio[1])/2.;
    m_faudioX=(faudio[3]+faudio[4])/2.;
  }

  float getValue() {
    return in.left.get(0);
  }
}
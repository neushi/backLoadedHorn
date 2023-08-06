// 完全幅一定のバックロードホーンスピーカーの設計支援ツール
// design support tool for Back Loaded Horn speakers (#PURE# Constant Width only)
// neushi作成　Ver.0.1 dataVer.1  誰でも無償で利用できます

// 位置合わせ線の表示
// Kを多段に
// メジャー機能
// 数字の表示  on/off
// 寸法線の表示
// マニュアルはgithubに置いたhtmlを見てもらう


void settings() {
  size(int(BoxDepth), int(BoxHeight));
  pixelDensity(displayDensity());

}

void setup() {
  frameRate(100);
  background(0);
  surface.setResizable(true);
//  LogFile = createWriter("log_BLHD"+String.valueOf(year())+nfs(month(),2,0)+nfs(day(),2,0)+nfs(hour(),2,0)+nfs(minute(),2,0)+nfs(second(),2,0)+".txt");  
  presetDesign(); 
};

// draw //////////////////////////////////////////////////////////
void draw() {
  background(0);
  translate(TranslateX, TranslateY);  // translate量がscaleに影響されないように、必ずscaleの前に置く
  scale(DisplayMagnification);
  Size_nearestCorner = Size_nearestCorner_preference/DisplayMagnification;
  sideBoard.show();
  horn.show();
  lumber.show();
  if (KeyPressedOption == KeyPressedType.SIDE_BOARD) {
    sideBoard.edit();
  } else if (KeyPressedOption == KeyPressedType.SOUND_PATH) {
    horn.edit();
  } else if (KeyPressedOption == KeyPressedType.LUMBER_PLACEMENT) {
    lumber.edit();
  }
//   println(frameRate);
}

// functions /////////////////////////////////////////////////////

void log(final String s) {
  println(s);
//  LogFile.println(s);
//  LogFile.flush();
}

void snapShot(final String s) {
  DesignFile.println(s);
  DesignFile.flush();
}

void saveAllInfo() {
  DesignFile = createWriter("designSnapshot_BLHD"+String.valueOf(year())+nfs(month(),2,0)+nfs(day(),2,0)+nfs(hour(),2,0)+nfs(minute(),2,0)+nfs(second(),2,0)+".txt");
  sideBoard.info();
  horn.info();
  lumber.info();
  DesignFile.flush();DesignFile.close();  
}

void updateMagnification() {
  final float oldMaginification = DisplayMagnification;
  if (CumulativeMouseCount < 0) {
    CumulativeMouseCount = 0;
  }
//  log("updateMagnification():" + str(DisplayMagnification));       


  DisplayMagnification = min((width/(horn.maxPosition()[0]+2*BorderMargin)), 
                             (height/(horn.maxPosition()[1]+2*BorderMargin)))
                             * (1 + CumulativeMouseCount/10);
// log(" => " + str(DisplayMagnification));        

  TranslateX = mouseX -(mouseX - TranslateX) * DisplayMagnification / oldMaginification;
  TranslateY = mouseY -(mouseY - TranslateY) * DisplayMagnification / oldMaginification;
  setMinimalTranslation();
}

void setMinimalTranslation() {
  // log("setMinimalTranslation: " + str(TranslateX) + ":" + str(TranslateY)); 
  if ((BoxDepth + BorderMargin) * DisplayMagnification < (width - TranslateX)) {
    TranslateX = width - (BoxDepth + BorderMargin) * DisplayMagnification;
  }
  if (BorderMargin * DisplayMagnification < TranslateX) {
    TranslateX = BorderMargin * DisplayMagnification;
  }

  if ((BoxHeight + BorderMargin) * DisplayMagnification < (height - TranslateY)) {
    TranslateY = height - (BoxHeight + BorderMargin) * DisplayMagnification;
  }
  if (BorderMargin * DisplayMagnification < TranslateY) {
    TranslateY = BorderMargin * DisplayMagnification;
  }  
  // log(" => " + str(TranslateX) + ":" + str(TranslateY));
}

float xInModel(final float wx) {
  // wx = modelX * DisplayMagnification + TranslateX;
  return (wx - TranslateX) / DisplayMagnification;
}

float yInModel(final float wy) {
  return (wy - TranslateY) / DisplayMagnification;
}

float xPixelsToMouse(final float x) {
  return (mouseX - TranslateX) - x * DisplayMagnification;
}

float yPixelsToMouse(final float y) {
  return (mouseY - TranslateY) - y * DisplayMagnification;
}
///////////////////////////////////////////////////////////////////

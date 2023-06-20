// 完全幅一定のバックロードホーンスピーカーの設計支援ツール
// design support tool for Back Loaded Horn speakers (#PURE# Constant Width only)

void settings() {
  size(int(BoxDepth), int(BoxHeight));
  pixelDensity(displayDensity());
}

void setup() {
  // size(600, 800, P2D);
  // fullScreen(P2D);
  windowResize(int(BoxDepth)+1,int(BoxHeight)+1);
  blendMode(REPLACE);
  strokeWeight(1); // 1.5 seems minimum
  ellipseMode(RADIUS);
  frameRate(100);
  textSize(24);
  surface.setResizable(true);
  LogFile = createWriter("BLHornDesigner_log"+String.valueOf(year())+nfs(month(),2,0)+nfs(day(),2,0)+nfs(hour(),2,0)+nfs(minute(),2,0)+nfs(second(),2,0)+".txt");  
  presetDesign();
};

// draw //////////////////////////////////////////////////////////
void draw() {
  translate(TranslateX, TranslateY);  // translate量がscaleに影響されないように、必ずscaleの前に置く
  scale(DisplayMagnification);
  background(0);
  size_nearestCorner = 5/DisplayMagnification;
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
}

// functions /////////////////////////////////////////////////////

void log(final String s) {
  println(s);
  LogFile.println(s);
  LogFile.flush();
}

void snapShot(final String s) {
  DesignFile.println(s);
  DesignFile.flush();
}

void updateMagnification() {
  if (CumulativeMouseCount < 0) {
    CumulativeMouseCount = 0;
  }
  
  DisplayMagnification = min(((width - 2 * BorderMargin)/horn.maxPosition()[0]), 
                             ((height - 2* BorderMargin)/horn.maxPosition()[1])) 
                                * (1 + CumulativeMouseCount/10);
  updateTranslation();
}

void updateTranslation() {
  updateTranslationX();
  updateTranslationY();
}

void updateTranslationX() {
  if (BorderMargin < TranslateX) {
    TranslateX = BorderMargin;
    return;
  }
  if (BoxDepth * DisplayMagnification < width) {
        TranslateX = BorderMargin;
        return;
  }
  if (TranslateX < -BoxDepth * DisplayMagnification + width - BorderMargin) {
    TranslateX = -BoxDepth * DisplayMagnification + width - BorderMargin;
  }
}

void updateTranslationY() {
  if (BorderMargin < TranslateY) {
    TranslateY = BorderMargin;
    return;
  }
  if (BoxHeight * DisplayMagnification < height) {
        TranslateY = BorderMargin;
        return;
  }
  if (TranslateY < -BoxHeight * DisplayMagnification + height - BorderMargin) {
    TranslateY = -BoxHeight * DisplayMagnification + height - BorderMargin;
  }
}

float windowPointX(final float realX) {
  return realX * DisplayMagnification + TranslateX;
}

float windowPointY(final float realY) {
  return realY * DisplayMagnification + TranslateY;
}

float realPointX(final float x) {
  return (x - TranslateX) / DisplayMagnification;
}

float realPointY(final float y) {
  return (y - TranslateY) / DisplayMagnification;
}
///////////////////////////////////////////////////////////////////

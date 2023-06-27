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
  LogFile = createWriter("log_BLHD"+String.valueOf(year())+nfs(month(),2,0)+nfs(day(),2,0)+nfs(hour(),2,0)+nfs(minute(),2,0)+nfs(second(),2,0)+".txt");  
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

void saveAllInfo() {
  DesignFile = createWriter("designSnapshot_BLHD"+String.valueOf(year())+nfs(month(),2,0)+nfs(day(),2,0)+nfs(hour(),2,0)+nfs(minute(),2,0)+nfs(second(),2,0)+".txt");
  sideBoard.info();
  horn.info();
  lumber.info();
  DesignFile.flush();DesignFile.close();  
}

void updateMagnification() {
  if (CumulativeMouseCount < 0) {
    CumulativeMouseCount = 0;
  }
//  log("updateMagnification():" + str(DisplayMagnification));                           
  
  DisplayMagnification = min((width/(horn.maxPosition()[0]+2*BorderMargin)), 
                             (height/(horn.maxPosition()[1]+2*BorderMargin)))
                             * (1 + CumulativeMouseCount/10);
// log(" => " + str(DisplayMagnification));                           
   updateTranslation();
}

void updateTranslation() {
  // log("updateTranslation: " + str(TranslateX) + ":" + str(TranslateY));
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

///////////////////////////////////////////////////////////////////

// 完全幅一定のバックロードホーンスピーカーの設計支援ツール
// design support tool for Back Loaded Horn speakers (#PURE# Constant Width only)

void settings() {
  size(int(Box_depth), int(Box_height));
  pixelDensity(displayDensity());
}

void setup() {
  // size(600, 800, P2D);
  // fullScreen(P2D);
  windowResize(int(Box_depth)+1,int(Box_height)+1);
  blendMode(REPLACE);
  strokeWeight(1); // 1.5 seems minimum
  ellipseMode(RADIUS);
  frameRate(100);
  surface.setResizable(true);
  LogFile = createWriter("BLHornDesigner_log"+String.valueOf(year())+nfs(month(),2,0)+nfs(day(),2,0)+nfs(hour(),2,0)+nfs(minute(),2,0)+nfs(second(),2,0)+".txt"); 
};

// draw //////////////////////////////////////////////////////////
void draw() {
  translate(TranslateX, TranslateY);  // translate量がscaleに影響されないように、必ずscaleの前に置く
  scale(DisplayMagnification);
  background(0);
  size_nearestCorner = 5/DisplayMagnification;
  // frame
  push();
    noStroke(); 
    rect(0,0, Box_depth, Box_height);
  pop();  
  horn.show();
  horn.edit();
}

// functions /////////////////////////////////////////////////////
void log(final String s) {
  println(s);
  LogFile.println(s);
  LogFile.flush();
}

void updateMagnification() {
  if (CumulativeMouseCount < 0) {
    CumulativeMouseCount = 0;
  }
  DisplayMagnification = min(((width - 2 * BorderMargin)/Box_depth), 
                             ((height - 2* BorderMargin)/Box_height )) 
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
  if (Box_depth * DisplayMagnification < width) {
        TranslateX = BorderMargin;
        return;
  }
  if (TranslateX < -Box_depth * DisplayMagnification + width - BorderMargin) {
    TranslateX = -Box_depth * DisplayMagnification + width - BorderMargin;
  }
}

void updateTranslationY() {
  if (BorderMargin < TranslateY) {
    TranslateY = BorderMargin;
    return;
  }
  if (Box_height * DisplayMagnification < height) {
        TranslateY = BorderMargin;
        return;
  }
  if (TranslateY < -Box_height * DisplayMagnification + height - BorderMargin) {
    TranslateY = -Box_height * DisplayMagnification + height - BorderMargin;
  }
}
///////////////////////////////////////////////////////////////////

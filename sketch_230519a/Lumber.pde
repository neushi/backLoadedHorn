class Lumber {
  private ArrayList<APiece_lumber> pieces;
  private Target target;
    
  Lumber() {
    pieces = new ArrayList<APiece_lumber>();
  }
  
  void edit() {
    if (EditStatus == EditStatusType.CANCELED) {
      target = findNearest();
      if (target.index != -1) { showTarget(target); }
      return;
    }
    if (EditStatus == EditStatusType.MOVING){
      final int i = target.index;
      final boolean start = target.start;
      
      push();
        if (start) {
          line(pieces.get(i).startX, pieces.get(i).startY, 
              (mouseX - TranslateX)/ DisplayMagnification, (mouseY - TranslateY) / DisplayMagnification);
        } else {
          line(pieces.get(i).endX, pieces.get(i).endY, 
              (mouseX - TranslateX)/ DisplayMagnification, (mouseY - TranslateY) / DisplayMagnification);          
        }
      pop();
      return;
    }
    if (EditStatus == EditStatusType.FIXED) { 
      move();
      EditStatus = EditStatusType.CANCELED;
      return;
    }    
  }
  
  void shift(final int dx, final int dy) {
    final APiece_lumber p1 = pieces.get(target.index);
    final APiece_lumber p2;
    if (target.start) {
      p2 = new APiece_lumber(p1.startX+dx, p1.startY+dy, p1.endX, p1.endY, p1.thickness, p1.referenceSideIsRight);
    } else {
      p2 = new APiece_lumber(p1.startX, p1.startY, p1.endX+dx, p1.endY+dy, p1.thickness, p1.referenceSideIsRight);      
    }
    pieces.remove(target.index);
    pieces.add(target.index, p2);
    log("shift(lumber)");
  }
  
  void move() {
    final APiece_lumber newPiece;
    final APiece_lumber old = pieces.get(target.index);
    if (target.start) {
      newPiece = new APiece_lumber((mouseX - TranslateX)/DisplayMagnification, 
                                   (mouseY - TranslateY)/DisplayMagnification, old.endX, old.endY, 
                                   old.thickness, old.referenceSideIsRight);
    } else {
      newPiece = new APiece_lumber(old.startX, old.startY, 
                                   (mouseX - TranslateX)/DisplayMagnification, 
                                   (mouseY - TranslateY)/DisplayMagnification,
                                   old.thickness, old.referenceSideIsRight);
    }
    pieces.remove(target.index);
    pieces.add(target.index, newPiece);
    log("move lumber");
  }
  
  void add() {
    final float startX = (mouseX - TranslateX)/DisplayMagnification;
    final float startY = (mouseY - TranslateY)/DisplayMagnification;
    final float endX = (mouseX - TranslateX) / DisplayMagnification + defaultLumberLength/sqrt(2);
    final float endY = (mouseY - TranslateY) / DisplayMagnification + defaultLumberLength/sqrt(2);
    add(startX, startY, endX, endY, WallThickness, true);
    log("add lumber");
  }
  
  void add(final float startX, final float startY, final float endX, final float endY, 
           final float WallThickness, final boolean referenceSideIsRight) {
    final APiece_lumber l = new APiece_lumber(startX, startY, endX, endY, WallThickness, referenceSideIsRight);
    pieces.add(l);      
  }

  void delete() {
    final Target t = findNearest();
    if (t.index == -1) { return;}
    pieces.remove(t.index);
    log("del lumber");
  }
  
  void changeSide() {
    final Target t = findNearest();
    final APiece_lumber old = pieces.get(t.index); 
    final APiece_lumber newPiece = new APiece_lumber(old.startX, old.startY, old.endX, 
                                                     old.endY, old.thickness, !old.referenceSideIsRight);
    pieces.remove(t.index);
    pieces.add(t.index, newPiece);
    log("change side");
  }
  
  void lineUp() {
    final Target t = findNearest();
    final APiece_lumber old = pieces.get(t.index); 
    final APiece_lumber newPiece;
    
    if (abs(old.endY - old.startY) < diff_verticalOrHorisontal) {
      newPiece = new APiece_lumber(old.startX, old.startY, old.endX, old.startY,
                                   old.thickness, old.referenceSideIsRight);
      pieces.remove(t.index);
      pieces.add(t.index, newPiece);
      log("lineup 1");
      return;
    }
    
    final float ratio = abs((old.endX - old.startX)/(old.endY - old.startY));
    if (ratio < 1/ratio_verticalOrHorisontal) {
      newPiece = new APiece_lumber(old.startX, old.startY, old.startX, old.endY,
                                                       old.thickness, old.referenceSideIsRight);
      pieces.remove(t.index);
      pieces.add(t.index, newPiece);
      log("lineup 2");
      return; 
    } else if (ratio_verticalOrHorisontal < ratio) {
      newPiece = new APiece_lumber(old.startX, old.startY, old.endX, old.startY,
                                   old.thickness, old.referenceSideIsRight);
      pieces.remove(t.index);
      pieces.add(t.index, newPiece);
      log("lineup 3");
      return;       
    }
  }
    
  void reverseDirection() {
    final Target t = findNearest();
    final APiece_lumber old = pieces.get(t.index); 
    final APiece_lumber newPiece;
    
    newPiece = new APiece_lumber(old.endX, old.endY, old.startX, old.startY, 
                                   old.thickness, !old.referenceSideIsRight);
      pieces.remove(t.index);
      pieces.add(t.index, newPiece);
      log("reverseDirection");
      return;
    
    // この処理不要?
    // 終点を始点を入れ替え
  }
  
  void show(){
    for (int i = 0; i < pieces.size(); i++) {
      pieces.get(i).show();
    }
  }
  
  void showTarget(final Target t){
    if (KeyPressedOption == KeyPressedType.LUMBER_PLACEMENT) {
      push();
        final APiece_lumber p = pieces.get(t.index);
        noFill();
        if (t.start == true) {
            rectMode(RADIUS);
            rect(p.startX, p.startY, size_nearestCorner, size_nearestCorner);
        } else {            
            circle(p.endX, p.endY, size_nearestCorner);      
        }
        blendMode(EXCLUSION);  
        noStroke(); fill(LumberColor,125); 
        quad(p.startX, p.startY, p.endX, p.endY, p.endX_another, p.endY_another, p.startX_another, p.startY_another);
        rectMode(CENTER);
        fill(#000000,255);  
        textAlign(CENTER);
        textLeading(10);
        textSize(15);
        blendMode(DIFFERENCE);  
        fill(200);
        text("(" + nf(p.startX,0,1) + "," + nf(p.startY,0,1) + ")", p.startX, p.startY, 80, 40);
        text("(" + nf(p.endX,0,1) + "," + nf(p.endY,0,1) + ")", p.endX, p.endY, 80, 40);
      pop();
    }
  }
  
  void info() {
    for (int i = 0; i < pieces.size(); i++) {
      pieces.get(i).info();
    }
  }
    
  private Target findNearest() {
    float squaredDistance_s = VeryBigInteger; // 無限大の代わり
    int nearestIndex_s = -1;
    for (int i = 0; i < pieces.size(); i++) {
      float sd =   sq((mouseX - TranslateX) - pieces.get(i).startX * DisplayMagnification) 
                 + sq((mouseY - TranslateY) - pieces.get(i).startY * DisplayMagnification);
      // 後ろ優先
      if (sd <= squaredDistance_s ) {
        squaredDistance_s = sd;
        nearestIndex_s = i;
      }
    }
    float squaredDistance_e = VeryBigInteger; // 無限大の代わり
    int nearestIndex_e = -1;
    for (int i = 0; i < pieces.size(); i++) {
      float sd =   sq((mouseX - TranslateX) - pieces.get(i).endX * DisplayMagnification) 
                 + sq((mouseY - TranslateY) - pieces.get(i).endY * DisplayMagnification);
      // 後ろ優先
      if (sd <= squaredDistance_e ) {
        squaredDistance_e = sd;
        nearestIndex_e = i;
      }
    }
    if (squaredDistance_s < squaredDistance_e) { // 後ろ優先
      return new Target(nearestIndex_s, true); 
    } else {
      return new Target(nearestIndex_e, false);       
    }      
  }
}

class Target {
  final int index;
  final boolean start;
  
  Target(final int i, final boolean b) {
    index = i;
    start = b;
  }
}

class APiece_lumber {
  private final float startX;  // 整数値
  private final float startY;  // 整数値
  private final float length;  // 整数値
  private final float endX;
  private final float endY;
  private final float startX_another;
  private final float startY_another;
  private final float endX_another;
  private final float endY_another;
  private final float thickness;
  private final boolean referenceSideIsRight;  // startX/Y-endX/Yの座標が右端の辺ならtrue;

  APiece_lumber(final float x1, final float y1, final float x2, final float y2,
                final float th, final boolean r) {
    final float vx = x2 - x1;
    final float vy = y2 - y1;
    length = round(dist(x1, y1, x2, y2));
    startX = round(x1);
    startY = round(y1);
    endX = startX + vx * length / dist(x1, y1, x2, y2);
    endY = startY + vy * length / dist(x1, y1, x2, y2);
    thickness = th;
    referenceSideIsRight = r;  // startX-endYの座標が右側を表すならtrue;
        
    if (!referenceSideIsRight) {
      startX_another = startX - thickness * (endY - startY)/length;
      startY_another = startY + thickness * (endX - startX)/length;
    } else {
      startX_another = startX + thickness * (endY - startY)/length;
      startY_another = startY - thickness * (endX - startX)/length;       
    }
    endX_another = startX_another + (endX - startX);
    endY_another = startY_another + (endY - startY);
  }
  
  void show() {
    final float[] xs = {startX, endX, endX_another, startX_another}; 
    final float[] ys = {startY, endY, endY_another, startY_another}; 
    push();
      // 外形
      noStroke(); fill(LumberColor,255); 
      blendMode(REPLACE);
      // blendMode(EXCLUSION);  // focusしてる時だけ
      quad(startX, startY, endX, endY, endX_another, endY_another, startX_another, startY_another);
      // 基準点
      stroke(0);  
      line(startX - size_corner, startY, startX + size_corner, startY);
      line(startX, startY - size_corner, startX, startY + size_corner);
      // 長さ
      blendMode(REPLACE);
      rectMode(CENTER);
      fill(#000000,255);  
      textAlign(CENTER);
      textLeading(10);
      textSize(15);
      blendMode(DIFFERENCE);  // 常に
      fill(200);
      text(str(length), (startX + endX_another)/2, (startY + endY_another)/2, 80, 40);
    pop();
  }
  
  void info() {
    snapShot("lumber.add(" + nf(startX, 5, 2) + ", " + nf(startY, 5, 2)  + ", " 
        + nf(endX, 5, 2) + ", " + nf(endY, 5, 2) + ", " 
        + nf(thickness, 5, 2) + ", " + str(referenceSideIsRight) + "); // "
        + round(dist(startX, startY, endX, endY)) + "mm" );
  }
}

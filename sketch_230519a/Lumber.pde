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
      final APiece_lumber p = pieces.get(i);
      final float x = (mouseX - TranslateX)/DisplayMagnification;
      final float y = (mouseY - TranslateY)/DisplayMagnification;
      
      push();
        if (target.selectType == SelectType.START) {
          line(p.startX, p.startY, x, y);
        } else if (target.selectType == SelectType.END) {
          line(p.endX, p.endY, x, y);         
        } else {
      final float dx = x - (p.startX + p.endX_another)/2;
      final float dy = y - (p.startY + p.endY_another)/2;
          quad(p.startX +dx, p.startY +dy, p.endX +dx, p.endY +dy, 
               p.endX_another +dx, p.endY_another +dy, p.startX_another +dx, p.startY_another +dy);
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
    if (target.selectType == SelectType.START) {
      p2 = new APiece_lumber(p1.startX+dx, p1.startY+dy, p1.endX, p1.endY, p1.thickness, p1.referenceSideIsRight);
    } else if (target.selectType == SelectType.END) {
      p2 = new APiece_lumber(p1.startX, p1.startY, p1.endX+dx, p1.endY+dy, p1.thickness, p1.referenceSideIsRight);      
    } else {
      p2 = new APiece_lumber(p1.startX+dx, p1.startY+dy, p1.endX+dx, p1.endY+dy, p1.thickness, p1.referenceSideIsRight);            
    }

    pieces.remove(target.index);
    pieces.add(target.index, p2);
//    log("shift(lumber)");
  }
  
  void move() {
    final APiece_lumber newPiece;
    final APiece_lumber old = pieces.get(target.index);
    final float x = (mouseX - TranslateX)/DisplayMagnification;
    final float y = (mouseY - TranslateY)/DisplayMagnification;
    
    if (target.selectType == SelectType.START) {
      newPiece = new APiece_lumber(x, y, old.endX, old.endY, 
                                   old.thickness, old.referenceSideIsRight);
    } else if (target.selectType == SelectType.END) {
      newPiece = new APiece_lumber(old.startX, old.startY, x, y,
                                   old.thickness, old.referenceSideIsRight);
    } else {
      final float dx = x - (old.startX + old.endX_another)/2;
      final float dy = y - (old.startY + old.endY_another)/2;
      newPiece = new APiece_lumber(old.startX + dx, old.startY + dy, old.endX + dx, old.endY + dy,
                                   old.thickness, old.referenceSideIsRight);      
    }

    pieces.remove(target.index);
    pieces.add(target.index, newPiece);
    // log("move lumber");
  }
  
  void add() {
    final Target t = findNearest();
    final APiece_lumber l = pieces.get(t.index);
    final float mx = (mouseX - TranslateX)/DisplayMagnification;
    final float my = (mouseY - TranslateY)/DisplayMagnification;
    if (target.selectType == SelectType.START) {
      add(mx, my, l.endX + mx - l.startX, l.endY + my - l.startY, WallThickness, true);
    } else if (target.selectType == SelectType.END) {
      add(l.startX + mx - l.endX, l.startY + my - l.endY, mx, my, WallThickness, true);      
    } else {
      final float dx = mx - (l.startX + l.endX_another)/2;
      final float dy = my - (l.startY + l.endY_another)/2;
      add(l.startX + dx, l.startY + dy, l.endX + dx, l.endY + dy, WallThickness, true);            
    }
  }
  
  void add(final float startX, final float startY, final float endX, final float endY, 
           final float WallThickness, final boolean referenceSideIsRight) {
    /* log("add lumber(4) : " + str(startX) + " : " + str(startY) + " : " +  str(endX) + " : " +  str(endY) 
         + " : " +  str(WallThickness) + " : " +  str(referenceSideIsRight) );   */
    final APiece_lumber l = new APiece_lumber(startX, startY, endX, endY, WallThickness, referenceSideIsRight);
    pieces.add(l);     
  }

  void delete() {
    final Target t = findNearest();
    if (t.index == -1) { return;}
    pieces.remove(t.index);
    // log("del lumber");
  }
  
  void changeSide() {
    final Target t = findNearest();
    final APiece_lumber old = pieces.get(t.index); 
    final APiece_lumber newPiece = new APiece_lumber(old.startX_another, old.startY_another, old.endX_another, 
                                                     old.endY_another, old.thickness, !old.referenceSideIsRight);
    pieces.remove(t.index);
    pieces.add(t.index, newPiece);
    // log("change side");
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
      // log("lineup 1");
      return;
    }
    
    final float ratio = abs((old.endX - old.startX)/(old.endY - old.startY));
    if (ratio < 1/ratio_verticalOrHorisontal) {
      newPiece = new APiece_lumber(old.startX, old.startY, old.startX, old.endY,
                                                       old.thickness, old.referenceSideIsRight);
      pieces.remove(t.index);
      pieces.add(t.index, newPiece);
      // log("lineup 2");
      return; 
    } else if (ratio_verticalOrHorisontal < ratio) {
      newPiece = new APiece_lumber(old.startX, old.startY, old.endX, old.startY,
                                   old.thickness, old.referenceSideIsRight);
      pieces.remove(t.index);
      pieces.add(t.index, newPiece);
      // log("lineup 3");
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
      // log("reverseDirection");
      return;
  }
    
  void changeColor(){
    for (int i = 0; i < pieces.size(); i++) {
      pieces.get(i).changeColor();
    }
  }
  
  void show(){
    if (!ShowLumber ) { return; }
    for (int i = 0; i < pieces.size(); i++) {
      pieces.get(i).show_shape();
    }
    for (int i = 0; i < pieces.size(); i++) {
      pieces.get(i).show_length(i);  // 上書きされないよう、文字は最後に書く
    }
  }
  
  void showTarget(final Target t){
    if (KeyPressedOption != KeyPressedType.LUMBER_PLACEMENT && !ShowLumber) { return; }
    if (KeyPressedOption == KeyPressedType.LUMBER_PLACEMENT) {
      push();
        final APiece_lumber p = pieces.get(t.index);
        noFill();
        if (target.selectType == SelectType.START) {
            rectMode(RADIUS);
            rect(p.startX, p.startY, Size_nearestCorner, Size_nearestCorner);
        } else if (target.selectType == SelectType.END) {            
            circle(p.endX, p.endY, Size_nearestCorner);      
        }
        blendMode(EXCLUSION);  
        noStroke(); fill(LumberColor,125); 
        quad(p.startX, p.startY, p.endX, p.endY, p.endX_another, p.endY_another, p.startX_another, p.startY_another);
        rectMode(CENTER);
        fill(#000000,255);  
        textAlign(CENTER);
        textLeading(10);
        textSize(TextSize/DisplayMagnification);
        blendMode(DIFFERENCE);  
        fill(200);
        text("(" + nf(p.startX,0,1) + "," + nf(p.startY,0,1) + ")", p.startX, p.startY, 200, 40);
        text("(" + nf(p.endX,0,1) + "," + nf(p.endY,0,1) + ")", p.endX, p.endY, 200, 40);
      pop();
    }
  }
  
  void info() {
    sortPieces(pieces);
    for (int i = 0; i < pieces.size(); i++) {
      pieces.get(i).info();
    }
    for (int i = 0; i < pieces.size(); i++) {
      pieces.get(i).info_piece(i);
    }
  }
    
  private Target findNearest() {
    float squaredDistance_s = VeryBigInteger; // 無限大の代わり
    float squaredDistance_e = VeryBigInteger; // 無限大の代わり
    float squaredDistance_w = VeryBigInteger; // 無限大の代わり
    
    int nearestIndex_s = -1;
    if (pieces.size() < 1) {
      add(10,10,100,100,WallThickness, true);  // 一つもないときの処理が厄介なので、、、追加する位置に意味はない。
    }
    for (int i = 0; i < pieces.size(); i++) {
      float sd = sq(xPixelsToMouse(pieces.get(i).startX)) + sq(yPixelsToMouse(pieces.get(i).startY));
      // 後ろ優先
      if (sd <= squaredDistance_s ) {
        squaredDistance_s = sd;
        nearestIndex_s = i;
      }
    }
    int nearestIndex_e = -1;
    for (int i = 0; i < pieces.size(); i++) {
      float sd = sq(xPixelsToMouse(pieces.get(i).endX)) + sq(yPixelsToMouse(pieces.get(i).endY));
      // 後ろ優先
      if (sd <= squaredDistance_e ) {
        squaredDistance_e = sd;
        nearestIndex_e = i;
      }
    }
    int nearestIndex_w = -1;
    for (int i = 0; i < pieces.size(); i++) {
      float sd = sq(xPixelsToMouse((pieces.get(i).startX + pieces.get(i).endX_another)/2))
                 + sq(yPixelsToMouse((pieces.get(i).startY + pieces.get(i).endY_another)/2));
      // 後ろ優先
      if (sd <= squaredDistance_w ) {
        squaredDistance_w = sd;
        nearestIndex_w = i;
      }
    }
    final float minSd = min(squaredDistance_s, squaredDistance_e, squaredDistance_w);
    if (minSd == squaredDistance_w) { 
      return new Target(nearestIndex_w, SelectType.WHOLE); 
    } else if (minSd == squaredDistance_s) {
      return new Target(nearestIndex_s, SelectType.START);       
    } else {
      return new Target(nearestIndex_e, SelectType.END);       
    }      
  }

  class Target {
    final SelectType selectType;
    final int index;
    
    Target(final int i, final SelectType st) {
      index = i;
      selectType = st;
    }
  }
}

class APiece_lumber {
  private final float startX;  // 整数値に丸めるよ
  private final float startY;  // 整数値に丸めるよ
  private final float length;  // 整数値に丸めるよ
  private final float endX;
  private final float endY;
  private final float startX_another;
  private final float startY_another;
  private final float endX_another;
  private final float endY_another;
  private final float thickness;
  private final boolean referenceSideIsRight;  // startX/Y-endX/Yの座標が右端の辺ならtrue;
  private int color_r = int(random(255));
  private int color_g = int(random(255));
  private int color_b = int(random(255));

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
  
  void changeColor() {
    color_r = int(random(255));
    color_g = int(random(255));
    color_b = int(random(255));
  }
  
  void show_shape() {
    if (KeyPressedOption != KeyPressedType.LUMBER_PLACEMENT && !ShowLumber) { return; }
    push();
      // 外形
      noStroke(); fill(LumberColor,255); 
      blendMode(REPLACE);
      if (ShowLumberOverlap) {
        fill(color_r, color_g, color_b);
      }
      quad(startX, startY, endX, endY, endX_another, endY_another, startX_another, startY_another);
      // 基準点
      stroke(0);
      if (ShowLumberDirection) {
        strokeCap(SQUARE); strokeWeight(1);  
        line(startX, startY, endX, endY);
        stroke(0, 50);
        line(startX, startY, endX_another, endY_another);
      } else if (!ShowLumberOverlap) {
        strokeCap(ROUND);
        line(startX - size_corner, startY, startX + size_corner, startY);
        line(startX, startY - size_corner, startX, startY + size_corner);
      }
    pop();
  }

  void show_length(final int index) {
    push();
      stroke(0);
      rectMode(CENTER);
      textAlign(CENTER);
      textLeading(10);
      textSize(TextSize/DisplayMagnification);
      blendMode(DIFFERENCE);  // 常に
      fill(200);
      text("#" + str(index) + " : " + nf(length,0,0), (startX + endX_another)/2, (startY + endY_another)/2, 200, 40);
    pop();    
  }
  
  void info() {
    // 0を前置してはならない。presetDataに入れて実行した時に数値が正しく読めなくなる（バグ?）
    snapShot("lumber.add(" + str(startX) + ", " + str(startY)  + ", " 
        + str(endX) + ", " + str(endY) + ", " 
        + str(thickness) + ", " + str(referenceSideIsRight) + ");");
  }
  
  void info_piece(final int i) {
    String s;
    if (referenceSideIsRight) {
      s = "// #" + nf(i,2,0) + "  " + nfs(startX, 4,0) + ", " + nfs(startY, 4,0)  + "\t-R-\t" 
        + nfs(endX, 4, 1) + ", " + nfs(endY, 4, 1) + ", \t" 
        + nfs(round(dist(startX, startY, endX, endY)),4,0) + "mm";
    } else {
      s = "// #" + nf(i,2,0) + "  " + nfs(startX, 4,0) + ", " + nfs(startY, 4,0)  + "\t-L-\t" 
        + nfs(endX, 4, 1) + ", " + nfs(endY, 4, 1) + ", \t" 
        + nfs(round(dist(startX, startY, endX, endY)),4,0) + "mm";
    }
    if ((startX + endX_another) / 2 < 0 || BoxDepth < (startX + endX_another) / 2
        || (startY + endY_another) / 2 < 0 || BoxHeight < (startY + endY_another) / 2 ) {
            s = s + " out of sideBoard ";
          }
    snapShot(s);
  }
}

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
    log("shift(lumber)");
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
    log("move lumber");
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
    final APiece_lumber newPiece = new APiece_lumber(old.startX_another, old.startY_another, old.endX_another, 
                                                     old.endY_another, old.thickness, !old.referenceSideIsRight);
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
      pieces.get(i).show(i);
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
            rect(p.startX, p.startY, size_nearestCorner, size_nearestCorner);
        } else if (target.selectType == SelectType.END) {            
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
        text("(" + nf(p.startX,0,1) + "," + nf(p.startY,0,1) + ")", p.startX, p.startY, 200, 40);
        text("(" + nf(p.endX,0,1) + "," + nf(p.endY,0,1) + ")", p.endX, p.endY, 200, 40);
      pop();
    }
  }
  
  void info() {
    for (int i = 0; i < pieces.size(); i++) {
      pieces.get(i).info(i);
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
      float sd = sq(xDistanceToMouse(pieces.get(i).startX)) + sq(yDistanceToMouse(pieces.get(i).startY));
      // 後ろ優先
      if (sd <= squaredDistance_s ) {
        squaredDistance_s = sd;
        nearestIndex_s = i;
      }
    }
    int nearestIndex_e = -1;
    for (int i = 0; i < pieces.size(); i++) {
      float sd = sq(xDistanceToMouse(pieces.get(i).endX)) + sq(yDistanceToMouse(pieces.get(i).endY));
      // 後ろ優先
      if (sd <= squaredDistance_e ) {
        squaredDistance_e = sd;
        nearestIndex_e = i;
      }
    }
    int nearestIndex_w = -1;
    for (int i = 0; i < pieces.size(); i++) {
      float sd = sq(xDistanceToMouse((pieces.get(i).startX + pieces.get(i).endX_another)/2))
                 + sq(yDistanceToMouse((pieces.get(i).startY + pieces.get(i).endY_another)/2));
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
  
  float xDistanceToMouse(final float x) {
    return (mouseX - TranslateX) - x * DisplayMagnification;
  }
  
  float yDistanceToMouse(final float y) {
    return (mouseY - TranslateY) - y * DisplayMagnification;
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
  
  void show(final int index) {
    if (KeyPressedOption != KeyPressedType.LUMBER_PLACEMENT && !ShowLumber) { return; }
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
      text("#" + str(index) + " : " + nf(length,0,0), (startX + endX_another)/2, (startY + endY_another)/2, 200, 20);
    pop();
  }
  
  void info(final int i) {
    snapShot("lumber.add(" + nf(startX, 4,0) + ", " + nf(startY, 4,0)  + ", " 
        + nf(endX, 4, 2) + ", " + nf(endY, 4, 2) + ", " 
        + nf(thickness, 2, 1) + ", " + str(referenceSideIsRight) + "); \t// #" + nf(i,2,0) 
        + "  " + nf(round(dist(startX, startY, endX, endY)),4,0) + "mm" );
  }
}

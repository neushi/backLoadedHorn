class Horn {
  private ArrayList<Horn_corner> corners ;
  int targetIndex = 0;

  Horn() {
    corners = new ArrayList<Horn_corner>();
    presetHorn();
    targetIndex = 0;
  }
  
  private void show(){
    // wall
    for (int i = 1; i < corners.size(); i++) {
      float[] p8 = find8Points_nthHornElement(i); // Throatを背にして、左(手前 奥 奥外 手前外) 右(同)
      push();
        fill(#50b2b3,200);
        noStroke(); 
        if (ShowWall) {
          quad(p8[0],p8[1],p8[2] ,p8[3] ,p8[4] ,p8[5] ,p8[6] ,p8[7]);
          quad(p8[8],p8[9],p8[10],p8[11],p8[12],p8[13],p8[14],p8[15]);
        }
      pop();
    }
    // ends of partial horn
    for (int i = 0; i < corners.size(); i++) {
      final float radius = halfThroat * pow(NAGAOKA_K, partialLength(i)/100);
      push();
        fill(#d0d0d0,100);
        noStroke(); 
        circle(corners.get(i).p.x, corners.get(i).p.y, radius);
      pop();
    }
    // horn
    for (int i = 1; i < corners.size(); i++) {
      float[] four_points= find4Points_nthHornElement(i); // Throatを背にして、左手前 左奥 右手前 右奥 //<>//
      push();
        fill(#f0d2c0,200);
        noStroke(); 
        if (ShowHorn) {
          quad(four_points[0],four_points[1],four_points[2],four_points[3],four_points[4],four_points[5],four_points[6],four_points[7]);
        }
      pop();
    }
    // cornerww
    if (corners.size() == 0) {return;}
    if (corners.size() == 1) { 
      corners.get(0).show();
      return;
    }
    // more than two corners at a same position
    for (int i = 0; i < corners.size(); i++) {  
      push();
        strokeWeight(3); // 1.5 seems minimum
        if ((0 < i) && 
            abs(corners.get(i - 1).p.x - corners.get(i).p.x) < tooNear &&
            abs(corners.get(i - 1).p.y - corners.get(i).p.y) < tooNear) {
          fill(overlappingColor);
          circle(corners.get(i-1).p.x, corners.get(i-1).p.y, size_nearestCorner * 2);
        }
      pop();
      corners.get(i).show();
    }
    
    // center line
    for (int i = 1; i < corners.size(); i++) {
      final Horn_corner c1 = corners.get(i-1);
      final Horn_corner c2 = corners.get(i);
      push();
        stroke(#8f208f,88);
        strokeWeight(7); // 1.5 seems minimum
        line(c1.p.x, c1.p.y, c2.p.x, c2.p.y);
      pop();
    }
  }
  private void showTarget(final int index){ //マウスに連動して動くと困るので引数が必要
      push();
        if (Grid) {
          fill(TargetColor_grid);
          rectMode(RADIUS);
          rect(corners.get(index).p.x, corners.get(index).p.y,size_nearestCorner,size_nearestCorner);
        } else {
          fill(TargetColor);
          circle(corners.get(index).p.x, corners.get(index).p.y, size_nearestCorner);
        }
      pop(); 
  }
  
  private void edit() {
    Horn_corner c1, c2;
    
    if (edit_status == Edit_status.CANCELED) {
      targetIndex = horn.findNearest();
      showTarget(targetIndex);
      return;
    }
    if (edit_status == Edit_status.MOVING){
      push();
        fill(TargetColor);
        if (0 < targetIndex) {
          c1 = corners.get(targetIndex-1);
          line(c1.p.x, c1.p.y, 
               (mouseX - TranslateX)/ DisplayMagnification, 
               (mouseY - TranslateY)/ DisplayMagnification );
        }
        if (targetIndex < corners.size() - 1) {
          c2 = corners.get(targetIndex+1);
          line((mouseX - TranslateX)/ DisplayMagnification, 
               (mouseY - TranslateY)/ DisplayMagnification, 
                c2.p.x, c2.p.y);
        }
        circle(corners.get(targetIndex).p.x, corners.get(targetIndex).p.y, size_nearestCorner);
      pop();
      return;
    }
    if (edit_status == Edit_status.FIXED) { 
      move(targetIndex, (mouseX - TranslateX)/ DisplayMagnification, (mouseY - TranslateY) / DisplayMagnification);
      edit_status = Edit_status.CANCELED;
      return;
    }
  }
  
  private void move(final int index, final float x, final float y) {
    float x_new, y_new;
    if (Grid) {
      x_new = round(x); y_new = round(y);
    } else {
      x_new = x; y_new = y;
    }    
    final Horn_corner c = new Horn_corner(x_new, y_new);   
    corners.remove(index);
    corners.add(index, c);
    info();    
  }
   
  private void shift(final int dx, final int dy) {
    final Horn_corner c1 = corners.get(targetIndex);
    final Horn_corner c2 = new Horn_corner(c1.p.x + dx, c1.p.y + dy);   
    corners.remove(targetIndex);
    corners.add(targetIndex, c2);
    info();
  }
  
  private void add() {
    final int index = findNearest();
    float x = corners.get(index).p.x;
    float y = corners.get(index).p.y;     
    if (Grid) {
      x = round(x); y = round(y);
    } 
    final Horn_corner c = new Horn_corner(x, y);
    corners.add(index, c);
    info();
  }

  private void delete() {
    // cornersは空にしないこと
    if (corners.size() <= 1) {return;}
    final int index = findNearest();
    corners.remove(index);    
    info();
  }
  
  private int findNearest(){
    float squaredDistance = 999999999; // 無限大の代わり
    int nearestIndex = 0;
    for (int i = 0; i < corners.size(); i++) {
      float sd =   sq((mouseX - TranslateX) - corners.get(i).p.x * DisplayMagnification) 
                 + sq((mouseY - TranslateY) - corners.get(i).p.y * DisplayMagnification);
      // 後ろ優先
      if (sd <= squaredDistance ) {
        squaredDistance = sd;
        nearestIndex = i;
      }
    }
    return nearestIndex;
  }

  private void info() {
    float x1,y1;
    for (int i = 0; i < corners.size(); i++) {
      x1 = corners.get(i).p.x;
      y1 = corners.get(i).p.y;
      log("corners.add(new Horn_corner(" + nf(x1, 5,2) +  ", " + nf(y1,5,2) + "));" );
    }  
    for (int i = corners.size() -1 ; 0 < i; i--) {
      float cos = cos_nthHornAngle(i);
      log("// 音道長 : " + nf(partialLength(i),4,1) + "mm"
             + ",   幅 : " + nf(halfThroat * pow(NAGAOKA_K, partialLength(i)/100), 3, 1) 
             + ",   出口開き角度 : " + nf(degrees(acos(cos)),2,1) + "度"
             + ",   100mm当たりホーン拡大係数 K : " + str(NAGAOKA_K));
    }   
    log("// 音道長 : " + nf(partialLength(0),4,1) + "mm"
             + ",   幅 : " + nf(halfThroat * pow(NAGAOKA_K, partialLength(0)/100), 3, 1) 
             + ",   出口開き角度 : ------"
             + ",   100mm当たりホーン拡大係数 K : " + str(NAGAOKA_K));
  }
  
  // nは 0 から corners.size()-1
  private float partialLength(final int n) {
    float x1,y1,x2,y2;
    float sum = 0;
    if (n < 0) {
      log("partialLength : n < 0" );
      return -999999999;
    }
    if (corners.size() <= n) {
      log("partialLength : corners.size() <= n" );
      return -999999999;
    }
    for (int i = 0; i < n; i++) {
      x1 = corners.get(i).p.x;
      y1 = corners.get(i).p.y;
      x2 = corners.get(i+1).p.x;
      y2 = corners.get(i+1).p.y;
      sum += sqrt(sq(x1 - x2)+sq(y1 - y2));
    }
    return sum;
  }

  // nは 1 から corners.size()-1
  private float[] find4Points_nthHornElement(final int n) {
    if (n < 1) {
      log("find4Points_nthHornElement: n < 1");
      final float[] ps = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
      return ps;
    }
    if (corners.size() <= n) {
      log("find4Points_nthHornElement : corners.size() <= n");
      final float[] ps = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
      return ps;
    }
    final Horn_corner c1 = corners.get(n-1);
    final Horn_corner c2 = corners.get(n);
    final float l = partialLength(n) - partialLength(n - 1); //<>//
    final float w1 = halfThroat * pow(NAGAOKA_K, partialLength(n - 1)/100);
    final float w2 = halfThroat * pow(NAGAOKA_K, partialLength(n)/100) ;
    final float cx = c2.p.x - c1.p.x;
    final float cy = c2.p.y - c1.p.y;
    final float p1lx = c1.p.x - w1 * cy / l;  // 左手前
    final float p1ly = c1.p.y + w1 * cx / l;
    final float p1rx = c1.p.x + w1 * cy / l;  // 右手前
    final float p1ry = c1.p.y - w1 * cx / l;
    final float p2lx = c2.p.x - w2 * cy / l;  // 左奥
    final float p2ly = c2.p.y + w2 * cx / l;
    final float p2rx = c2.p.x + w2 * cy / l;  // 右奥
    final float p2ry = c2.p.y - w2 * cx / l;
    // Throatを背にして、左手前 左奥 右手前 右奥
    final float[] found4Points = new float[] {p1lx, p1ly, p2lx, p2ly, p2rx, p2ry, p1rx, p1ry}; 
    return found4Points;  
  }
  
  // nは 1 から corners.size()-1
  private float cos_nthHornAngle(final int n) {
    if (n < 1) {
      log("cos_nthHornAngle : n < 1" );
      return -999999999;
    }
    if (corners.size() <= n) {
      log("cos_nthHornAngle : corners.size() <= n" );
      return -999999999;
    }    
    float[] p = find4Points_nthHornElement(n); // Throatを背にして、左手前 左奥 右奥 右手前
    float lx, ly, rx, ry;
    lx = p[2]-p[0]; ly = p[3]-p[1]; rx = p[4]-p[6]; ry = p[5]-p[7];
    return (lx*rx+ly*ry)/sqrt((sq(lx)+sq(ly))*(sq(rx)+sq(ry)));
  }
  
  // nは 1 から corners.size()-1
  private float[] find8Points_nthHornElement(final int n) {
    if (n < 1) {
      log("find8Points_nthHornElement : n < 1" );
      return new float[] {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    }
    if (corners.size() <= n) {
      log("find8Points_nthHornElement : corners.size() <= n" );
      return new float[] {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    } 
    final Horn_corner c1 = corners.get(n-1);
    final Horn_corner c2 = corners.get(n);
    final float l = partialLength(n) - partialLength(n - 1);
    final float w1 = halfThroat * pow(NAGAOKA_K, partialLength(n - 1)/100);
    final float w2 = halfThroat * pow(NAGAOKA_K, partialLength(n)/100) ;
    final float cx = c2.p.x - c1.p.x;
    final float cy = c2.p.y - c1.p.y;
    final float p1lx = c1.p.x - w1 * cy / l;  // 左手前
    final float p1ly = c1.p.y + w1 * cx / l;
    final float p1rx = c1.p.x + w1 * cy / l;  // 右手前
    final float p1ry = c1.p.y - w1 * cx / l;
    final float p2lx = c2.p.x - w2 * cy / l;  // 左奥
    final float p2ly = c2.p.y + w2 * cx / l;
    final float p2rx = c2.p.x + w2 * cy / l;  // 右奥
    final float p2ry = c2.p.y - w2 * cx / l;
    //////////////////////////////////////////////////////////////////
    final float cos = cos_nthHornAngle(n);
    final float w1_thickness = halfThroat * pow(NAGAOKA_K, partialLength(n - 1)/100) + wall_thickness/cos;
    final float w2_thickness = halfThroat * pow(NAGAOKA_K, partialLength(n)/100) + wall_thickness/cos;
    //println(w1,w2,w1_thickness,w2_thickness, cos);
    final float p1lx_thickness = c1.p.x - w1_thickness * cy / l;  // 左手前
    final float p1ly_thickness = c1.p.y + w1_thickness * cx / l;
    final float p1rx_thickness = c1.p.x + w1_thickness * cy / l;  // 右手前
    final float p1ry_thickness = c1.p.y - w1_thickness * cx / l;
    final float p2lx_thickness = c2.p.x - w2_thickness * cy / l;  // 左奥
    final float p2ly_thickness = c2.p.y + w2_thickness * cx / l;
    final float p2rx_thickness = c2.p.x + w2_thickness * cy / l;  // 右奥
    final float p2ry_thickness = c2.p.y - w2_thickness * cx / l;
    return new float[] {p1lx,p1ly,p2lx,p2ly,p2lx_thickness,p2ly_thickness,p1lx_thickness,p1ly_thickness,
                        p1rx,p1ry,p2rx,p2ry,p2rx_thickness,p2ry_thickness,p1rx_thickness,p1ry_thickness};
  }

  
  private void presetHorn() {
// ここにログをコピーして直前の設計作業を再開
/* Ver.1   ユニットとホーンが近い   
corners.add(new Horn_corner(00132.86, 00022.57));
corners.add(new Horn_corner(00575.29, 00026.14));
corners.add(new Horn_corner(00574.86, 00064.86));
corners.add(new Horn_corner(00157.14, 00062.71));
corners.add(new Horn_corner(00155.71, 00113.86));
corners.add(new Horn_corner(00560.71, 00118.43));
corners.add(new Horn_corner(00521.57, 01221.14));
corners.add(new Horn_corner(00367.29, 01211.86));
corners.add(new Horn_corner(00352.14, 00362.86));
corners.add(new Horn_corner(-00000.29, 00363.43));*/
/* Ver.2 作り易そう   */
corners.add(new Horn_corner(00132.86, 00021.57));
corners.add(new Horn_corner(00574.71, 00025.71));
corners.add(new Horn_corner(00554.57, 01171.86));
corners.add(new Horn_corner(00473.71, 01171.43));
corners.add(new Horn_corner(00463.00, 00131.71));
corners.add(new Horn_corner(00273.57, 00142.57));
corners.add(new Horn_corner(00222.00, 01012.00));
corners.add(new Horn_corner(00000.00, 01013.00));
// 音道全長 : 3991.53mm,  出口開き角度 : 19.77度,  100mm当たりホーン拡大係数 K : 1.085    
/* 曲がりは滑らか
corners.add(new Horn_corner(00132.86, 00022.57));
corners.add(new Horn_corner(00574.29, 00026.14));
corners.add(new Horn_corner(00573.86, 00064.86));
corners.add(new Horn_corner(00157.14, 00063.71));
corners.add(new Horn_corner(00155.71, 00114.86));
corners.add(new Horn_corner(00560.71, 00118.43));
corners.add(new Horn_corner(00521.00, 01102.00));
corners.add(new Horn_corner(00393.00, 01221.00));
corners.add(new Horn_corner(00152.57, 01187.71));
corners.add(new Horn_corner(00124.00, 01002.71));
corners.add(new Horn_corner(00315.00, 00669.00));
corners.add(new Horn_corner(00317.00, 00564.00));
corners.add(new Horn_corner(00242.71, 00454.57));
corners.add(new Horn_corner(00092.86, 00384.29));
corners.add(new Horn_corner(00002.29, 00384.29));*/

  }
}

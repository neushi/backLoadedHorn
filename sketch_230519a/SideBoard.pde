class SideBoard {
  boolean blink = true;
  int lastTime = 0;
  
  SideBoard() {
  }
  
  void size(final float h, final float d){
    BoxHeight = h; BoxDepth = d;
  }

  void size_mouse(){
      BoxHeight = round((mouseY - TranslateY)/ DisplayMagnification);
      BoxDepth = round((mouseX - TranslateX)/ DisplayMagnification);
  }
  
  void edit() {
    if (lastTime +350 < millis()) {
      blink = !blink;
      lastTime = millis();
    }
    if (blink) {
      push();
        stroke(#FFCC00); 
        strokeWeight(5); 
        noFill();
        rect(0,0, BoxDepth, BoxHeight);
      pop(); 
    } 
    push();
      //scale(1.0);
      rectMode(CENTER);
      blendMode(EXCLUSION);  
      fill(#ffffff, 70);
      rect(xInModel(width/2), yInModel(height * 2/10), width/2.5 / DisplayMagnification, height/(10 * DisplayMagnification));
      rect(xInModel(width/2), yInModel(height * 4/10), width/(2.5 * DisplayMagnification), height/(10 * DisplayMagnification));
      rect(xInModel(width/2), yInModel(height * 6/10), width/(2.5 * DisplayMagnification), height/(10 * DisplayMagnification));
      blendMode(REPLACE);  
      fill(#000000, 110);
      //textLeading(20);
      textSize(width/DisplayMagnification/50);
      textAlign(CENTER);
      text("arrow keys\nSideBoard : " + nf(BoxHeight,0,0) + " x " + nf(BoxDepth,0,0) , 
           xInModel(width/2), yInModel(height * 2/10), width/2.5 / DisplayMagnification, height/(10 * DisplayMagnification));
      text("j k l\nMagnification per 10 cm, K : " + nf(NAGAOKA_K,1,3) + "\nn m ," , 
           xInModel(width/2), yInModel(height * 4/10), width/2.5/ DisplayMagnification, height/(10 * DisplayMagnification));
      text("[ ]\nBorderMargin : " + nf(BorderMargin,0,0)  , 
           xInModel(width/2), yInModel(height * 6/10), width/2.5 / DisplayMagnification, height/(10* DisplayMagnification));
    pop();     
  }

  void show(){
      push();
        noStroke(); 
        rect(0,0, BoxDepth, BoxHeight);
      pop(); 
      return;
  }
  
  void info() {
    snapShot("sideBoard.size(" + nf(BoxHeight,0,1) + ", " + nf(BoxDepth,0,1) + ");" );    
    snapShot("NAGAOKA_K = " + str(NAGAOKA_K) + ";" );    
  }
}

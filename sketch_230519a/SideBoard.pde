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
      rectMode(CORNER);
      textLeading(20);
      textSize(30);
      blendMode(EXCLUSION);  
      fill(#ffffff, 90);
      rect(BoxDepth/8, BoxHeight * 2/10 , 400, 50);
      rect(BoxDepth/8, BoxHeight * 3/10 , 400, 50);
      blendMode(REPLACE);  
      fill(#000000, 110);
      textAlign(CENTER);
      text("SideBoard : " + nf(BoxHeight,0,0) + " x " + nf(BoxDepth,0,0) , BoxDepth/8, BoxHeight * 2/10, 400, 80);
      text("NAGAOKA_K : " + nf(NAGAOKA_K,1,3)  , BoxDepth/8, BoxHeight * 3/10, 400, 80);
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
  }
}

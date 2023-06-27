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
      scale(1.0);
      rectMode(CENTER);
      blendMode(EXCLUSION);  
      fill(#ffffff, 70);
      rect(width/2, height * 2/10 , width, 120);
      rect(width/2, height * 4/10 , width, 170);
      rect(width/2, height * 7/10 , width, 120);
      blendMode(REPLACE);  
      fill(#000000, 110);
      textLeading(20);
      textSize(30);
      textAlign(CENTER);
      text("arrow keys\nSideBoard : " + nf(BoxHeight,0,0) + " x " + nf(BoxDepth,0,0) , width/2, height * 2/10 +10, width, 120);
      text("j k l\nMagnification per 10 cm, K : " + nf(NAGAOKA_K,1,3) + "\nn m ," , width/2, height * 4/10+10, width, 150);
      text("[ ]\nBorderMargin : " + nf(BorderMargin,0,0)  , width/2, height * 7/10+10, width, 120);
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

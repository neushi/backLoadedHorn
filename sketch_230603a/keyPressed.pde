enum Edit_status {CANCELED, MOVING, FIXED};
Edit_status edit_status = Edit_status.CANCELED;
//boolean Dragging = false;
float DragX = 0.0;
float DragFromX = 0.0;
float DragY = 0.0;
float DragFromY = 0.0;


void keyPressed() {
    switch(key) {
      // ESCは設定にかかわらず、プログラム自体が終了する。
      case ESC: edit_status = Edit_status.CANCELED; break; 
      case CODED:
// shift corners
        switch(keyCode) {
          case UP: horn.shift(0,-1);break;
          case DOWN: horn.shift(0,1);break; 
          case RIGHT: horn.shift(1,0);break; 
          case LEFT: horn.shift(-1,0);break; 
        }
        break; 
// edit corners
//      case 'm': edit_status = Edit_status.MOVING; break;
      case ' ': edit_status = Edit_status.CANCELED; break;
      case ENTER: 
      case RETURN: 
        if (edit_status == Edit_status.CANCELED) {
          edit_status = Edit_status.MOVING;
          break;
        }
        if (edit_status == Edit_status.MOVING) {
          edit_status = Edit_status.FIXED;
          break;
        }
// add new corners
      case 'a': 
        if (edit_status == Edit_status.CANCELED) {
           println("add");
          horn.add();
        }
        break;
// delete corners
      case 'D': 
        if (edit_status == Edit_status.CANCELED) {
          println("delete");
          horn.delete();
        }
        break;
// info
      case 'i': 
        horn.info();
        break;
// ShowHorn
      case 'h': 
        ShowHorn = !ShowHorn;
        break;
// ShowWall
      case 'w': 
        ShowWall = !ShowWall;
        break;
// round coordinate
      case 'g': 
        Grid = false;
        break;
      case 'G': 
        Grid = true;
        break;
// fit the window
      case 'f':         
        CumulativeMouseCount = 0;
        updateMagnification();
        TranslateX = BorderMargin;
        TranslateY = BorderMargin;
        break;
        
      default:;
    }
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    if (edit_status == Edit_status.CANCELED) {
      edit_status = Edit_status.MOVING;
      return;
    }
    if (edit_status == Edit_status.MOVING) {
      edit_status = Edit_status.FIXED;
      return;
    }
  } else {
    edit_status = Edit_status.CANCELED;
  }
}

void mouseWheel(MouseEvent event) {
  float count = event.getCount();
  CumulativeMouseCount -= count;
  updateMagnification();
}

void mousePressed() {
  DragFromX = mouseX;
  DragFromY = mouseY;
}

void mouseDragged(MouseEvent event) {
  DragX = DragFromX - event.getX();
  DragY = DragFromY - event.getY();
}

void mouseReleased() {
  TranslateX -= DragX;
  TranslateY -= DragY;
  updateTranslation();
}

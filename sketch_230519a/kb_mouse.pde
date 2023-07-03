enum KeyPressedType {SIDE_BOARD, SOUND_PATH, LUMBER_PLACEMENT};
// KeyPressedType KeyPressedOption =  KeyPressedType.SOUND_PATH;
KeyPressedType KeyPressedOption =  KeyPressedType.LUMBER_PLACEMENT;
enum EditStatusType {CANCELED, MOVING, FIXED};
EditStatusType EditStatus = EditStatusType.CANCELED;
boolean ShiftKey = false;
float DragFromX = 0.0;
float DragX = 0.0;
float DragFromY = 0.0;
float DragY = 0.0;

void keyPressed() {
  switch(key) {
    // ESCは設定にかかわらず、プログラム自体が終了する、、、
    case ESC: EditStatus = EditStatusType.CANCELED; break; 
    case TAB: // SIDE_BOARD/SOUND_PATH/LUMBER_PLACEMENTモード切り替え　#SIDE_BOARD #SOUND_PATH #LUMBER_PLACEMENT
      EditStatus = EditStatusType.CANCELED;
      if (KeyPressedOption == KeyPressedType.LUMBER_PLACEMENT) { 
        KeyPressedOption =  KeyPressedType.SIDE_BOARD;
      } else if (KeyPressedOption == KeyPressedType.SIDE_BOARD) {
        KeyPressedOption =  KeyPressedType.SOUND_PATH;   
      } else {
        KeyPressedOption =  KeyPressedType.LUMBER_PLACEMENT; 
      }
      break; 
    case '1': 
      ShowCenterLine = !ShowCenterLine;break;
    case '2': // show virtual Horn　#SIDE_BOARD #SOUND_PATH #LUMBER_PLACEMENT
      ShowHorn = !ShowHorn;break;
    case '3': // show virtual Wall of sound path　#SIDE_BOARD #SOUND_PATH #LUMBER_PLACEMENT
      ShowWall = !ShowWall;break;
    case '4': // show lumber　
      ShowLumber = !ShowLumber;break;
    case '5': // for overlap check
      ShowLumberOverlap = !ShowLumberOverlap;
      if (ShowLumberOverlap) {
        lumber.changeColor();
        ShowLumberDirection = false;
      } 
      break;
    case '6': // for printing final design
      ShowLumberDirection = !ShowLumberDirection;break;
    case '0': 
      ShowCenterLine = false; ShowHorn = false; ShowWall = false; 
      ShowLumber = true; ShowLumberDirection = true; ShowLumberOverlap = false;
      break;
    case 'f': // Fit blueprints to window size 　#SIDE_BOARD #SOUND_PATH #LUMBER_PLACEMENT        
      CumulativeMouseCount = 0;
      updateMagnification();
      break;
    case 'i': // save design data and other Information　#SIDE_BOARD #SOUND_PATH #LUMBER_PLACEMENT
      EditStatus = EditStatusType.CANCELED;
      saveAllInfo();
      ShowCenterLine = false; ShowHorn = false; ShowWall = false; 
      ShowLumber = true; ShowLumberDirection = true; ShowLumberOverlap = false;
      CumulativeMouseCount = 0;
      updateMagnification();
      KeyPressedOption = KeyPressedType.SOUND_PATH;
      break;
    case 'p': // 
      EditStatus = EditStatusType.CANCELED;
      saveAllInfo();
      save("screenshot_BLHD"+String.valueOf(year())+nfs(month(),2,0)+nfs(day(),2,0)+nfs(hour(),2,0)+nfs(minute(),2,0)+nfs(second(),2,0)+".png");
      break;
    case '?': 
      PApplet.runSketch(new String[] { "help" }, new HelpWindow());
      break;
    default:;
  }
  if (KeyPressedOption == KeyPressedType.LUMBER_PLACEMENT) {
    keyPressed_LumberPlacement();return;
  }
  if (KeyPressedOption == KeyPressedType.SOUND_PATH) {
    keyPressed_SoundPath();return;
  } 
  keyPressed_SideBoard();
}

void keyPressed_LumberPlacement() {
  switch(key) {
    case CODED:
      switch(keyCode) {
        case UP: lumber.shift(0,-1);break;
        case DOWN: lumber.shift(0,1);break; 
        case RIGHT: lumber.shift(1,0);break; 
        case LEFT: lumber.shift(-1,0);break; 
        case SHIFT: ShiftKey = true;break;
        default:break;
      }
      break; 
    case ' ': // stop editing the sound path　 
        EditStatus = EditStatusType.CANCELED; break;
    case 'a': // Add new lumber　 #LUMBER_PLACEMENT
      if (EditStatus == EditStatusType.CANCELED) {
        lumber.add();
      }
      break;
    case 'D': // Delete a piece of lumber  #
      if (EditStatus == EditStatusType.CANCELED) {
        lumber.delete();
      }
      break;
    case 's': // 
      lumber.changeSide(); break;
    case 'l': 
      lumber.lineUp();break;
    case 'r': 
      lumber.reverseDirection();break;
    default:;
  }
}

void keyPressed_SideBoard() {
  switch(key) {
    case CODED:
      switch(keyCode) {
        case UP: BoxHeight = round(BoxHeight - 1) ;break; // Change the size of the side board　#SIDE_BOARD
        case DOWN: BoxHeight = round(BoxHeight + 1);break;// Change the size of the side board　#SIDE_BOARD
        case RIGHT: BoxDepth = round(BoxDepth + 1) ;break;// Change the size of the side board　#SIDE_BOARD
        case LEFT: BoxDepth = round(BoxDepth - 1) ;break; // Change the size of the side board　#SIDE_BOARD
        default:break;
      }
      break; 
    case 'j':
      NAGAOKA_K += 0.1; break; 
    case 'k':
      NAGAOKA_K += 0.01; break; 
    case 'l':
      NAGAOKA_K += 0.001; break; 
    case 'n':
      NAGAOKA_K -= 0.1; break; 
    case 'm':
      NAGAOKA_K -= 0.01; break; 
    case ',':
      NAGAOKA_K -= 0.001; break; 
    case '[':
      BorderMargin -= 1; break; 
    case ']':
      BorderMargin += 1; break; 
    default:;
  }  
}

void keyPressed_SoundPath() {
  switch(key) {
    case CODED:
// shift corners
      switch(keyCode) {
        case UP: horn.shift(0,-1);break;   // shift the position of the corner of sound path　 #SOUND_PATH 
        case DOWN: horn.shift(0,1);break;  // shift the position of the corner of sound path　 #SOUND_PATH 
        case RIGHT: horn.shift(1,0);break; // shift the position of the corner of sound path　 #SOUND_PATH 
        case LEFT: horn.shift(-1,0);break; // shift the position of the corner of sound path　 #SOUND_PATH 
        default:break;
      }
      break; 
    case ' ': // stop editing the sound path　 #SOUND_PATH
        EditStatus = EditStatusType.CANCELED; break;
    case 'a': // Add new corner on the sound path　 #SOUND_PATH 
      if (EditStatus == EditStatusType.CANCELED) {
        horn.add();
      }
      break;
    case 'D': // Delete a corner of the sound path  #SOUND_PATH
      if (EditStatus == EditStatusType.CANCELED) {
        horn.delete();
      }
      break;
    case 'g': 
      Grid = false;
      break;
    case 'G': 
      Grid = true;
      break;
    default:;
  }
}

void keyReleased() {
  switch(key) {
    case CODED:
      switch(keyCode) {
        case SHIFT: ShiftKey = false;break;
        default:break;
      }
    default: break;
  }
}

void mouseClicked() {
  if (KeyPressedOption == KeyPressedType.SIDE_BOARD) {
    mouseClicked_SIDE_BOARD();
  } else if (KeyPressedOption == KeyPressedType.SOUND_PATH) {
    mouseClicked_SOUND_PATH();    
  }   else if (KeyPressedOption == KeyPressedType.LUMBER_PLACEMENT) {
    mouseClicked_LUMBER_PLACEMENT();    
  } else {
    // log("bad KeyPressedOption");
  }
}

void mouseClicked_SIDE_BOARD() {
  if ( mouseButton == LEFT) {
    sideBoard.size_mouse(); return;
  }
  EditStatus = EditStatusType.CANCELED; return;
}

void mouseClicked_SOUND_PATH() {
  if ( mouseButton == RIGHT) {
    EditStatus = EditStatusType.CANCELED; return;
  }
  if (EditStatus == EditStatusType.CANCELED) {
    EditStatus = EditStatusType.MOVING; return;
  }
  if (EditStatus == EditStatusType.MOVING) {
    EditStatus = EditStatusType.FIXED; return;
  }
}

void mouseClicked_LUMBER_PLACEMENT() {
  if ( mouseButton == RIGHT) {
    EditStatus = EditStatusType.CANCELED; return;
  }
  if (EditStatus == EditStatusType.CANCELED) {
    EditStatus = EditStatusType.MOVING; return;
  }
  if (EditStatus == EditStatusType.MOVING) {
    EditStatus = EditStatusType.FIXED; return;
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
  setMinimalTranslation();
}

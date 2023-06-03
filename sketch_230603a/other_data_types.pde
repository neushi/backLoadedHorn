// Data types /////////////////////////////////////////////////////
class Horn_corner {
  final Position p;
  
  Horn_corner (final float x, final float y){
    p = new Position (x, y);
  }
   
  void show() {circle(p.x, p.y, size_corner);}
}

class Position {
  final float x;
  final float y;
  
  Position (final float x_init, final float y_init) {
    if (x_init <0) {log("bad Point1");}
    if (Box_depth < x_init) {log("bad Point2");}
    if (y_init <0) {log("bad Point3");}
    if (Box_height < y_init) {
      log("bad Point4");
    }
    x = x_init;
    y = y_init;
  }
}

// speaker global /////////////////////////////////////////////////////////
final float Box_height = 1300; // 前から見たスピーカーの高さ、単位はmm
final float Box_depth = 600; // 前から見たスピーカーの奥行き、単位はmm
final float Box_width_inner_method = 100;  // 前から見スピーカーの幅。ただし、音道の幅計算に使うので、内法。このプログラムでは定数。単位はmm
final float wall_thickness = 12; // 音道の壁に使う板の厚さ、単位はmm
final float halfThroat = 9;  // スロート幅の半分、単位はmm
final float NAGAOKA_K = 1.085; // 10cm当たりの幅拡大率, 標準的には1.08程度、
                       // 4mで45度になるには1.1017程度だが、箱が巨大になる。カットオフ周波数も上がるらしい。
// system global
PrintWriter LogFile;
boolean Grid = true;  // only for new corner coordinates, not for preset
int BorderMargin = 30;

// display global //////////////////////////////////////////////////
float CumulativeMouseCount = 0.0;  // 拡大率変更のためのマウスwheelカウント
float DisplayMagnification = 0.7; 
float TranslateX = BorderMargin;
float TranslateY = BorderMargin;
final float size_corner = 4;
float size_nearestCorner = 5;
final int TargetColor = #FF99FF;
final int TargetColor_grid = #FF9900;
final int overlappingColor = #00ff00;
final float tooNear = 1;
boolean ShowHorn = true;
boolean ShowWall = true;


// data global //////////////////////////////////////////////////
final Horn horn = new Horn();

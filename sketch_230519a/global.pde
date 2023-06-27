// speaker /////////////////////////////////////////////////////////
float BoxHeight = 1300; // 前から見たスピーカーの高さ、単位はmm
float BoxDepth = 600; // 前から見たスピーカーの奥行き、単位はmm
//未使用 final float Box_width_inner_method = 100;  // 前から見スピーカーの幅。ただし、音道の幅計算に使うので、内法。このプログラムでは定数。単位はmm
final float WallThickness = 12; // 音道の壁に使う板の厚さ、単位はmm
final float halfThroat = 9;  // スロート幅の半分、単位はmm
float NAGAOKA_K = 1.085; // 10cm当たりの音道面積拡大率(Constant Widthの場合は幅の拡大率になる)
    // 標準的には1.08程度、大きくするとカットオフ周波数が上がるらしい。
    // 4mで開き角度が45度になるには1.1017程度だが、箱が巨大になる。
    
// system //////////////////////////////////////////////////
PrintWriter LogFile;
PrintWriter DesignFile;
enum SelectType {START, END, WHOLE};
boolean Grid = true;  // only for new(or moving) corner coordinates, not for preset
final int VeryBigInteger = 999999999;
final float defaultLumberLength = 100;  // lumberを追加するときの初期値は100mm
final float ratio_verticalOrHorisontal = 20;
final float diff_verticalOrHorisontal = 0.05;
// display //////////////////////////////////////////////////
int BorderMargin = 20;
float CumulativeMouseCount = 0.0;  // 拡大率変更のためのマウスwheelカウント
float DisplayMagnification = 0.7; 
float TranslateX = BorderMargin * DisplayMagnification;
float TranslateY = BorderMargin * DisplayMagnification;
final float size_corner = 4;
float size_nearestCorner = 5;
final int TargetColor = #FF99FF;
final int TargetColor_grid = #FF9900;
final int overlappingColor = #00ff00;
final int LumberColor = #f0b2b3;
final float tooNear = 1;
boolean ShowHorn = true;
boolean ShowWall = true;
boolean ShowLumber = true;
boolean ShowLumberDirection = true;
boolean ShowCenterLine = true;

// data //////////////////////////////////////////////////
final Horn horn = new Horn();
final SideBoard sideBoard = new SideBoard();
final Lumber lumber = new Lumber();

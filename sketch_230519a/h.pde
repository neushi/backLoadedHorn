/*

各モード共通
  SPCキー  移動のキャンセル
  TABキー  モード切り替え。LUMBER_PLACEMENTモード、SIDE_BOARDモード、SOUND_PATHモードと順に変わる。
  マウスホイール  表示倍率の変更
  マウスドラッグ  表示領域の移動
  f  表示倍率を最適化
  i  設計データの保存 + f
  p  設計データの保存 + スクリーンショット保存

  1  音道のセンターラインの表示（トグル）
  2  仮想ホーンの表示（トグル）
  3  仮想ホーン壁の表示（トグル）
  4  部材の表示（トグル）
  5  部材の重なりを見るためにランダムな表示色で表示　<=>　デフォルト色に戻す
  6  部材の位置原点を表示（トグル）
  0  部材配置図を出すために上記4、6のみONで表示


LUMBER_PLACEMENTモード
  矢印キー  カーソルに一番近い対象を1mmずつ移動
  a  カーソルに一番近い部材の複製
  D  カーソルに一番近い部材の削除
  l  部材の方向を水平または垂直に修正
  r  部材位置原点を長さ方向の逆側に変更
  s  部材位置原点を厚み方向の逆側に変更
  
  マウスクリック  カーソルに一番近い部材の移動

 
SIDE_BOARDモード
  矢印キー  側板のサイズを1mmずつ修正
  j  10cm当たりの音道面積拡大率を0.1増加
  k  10cm当たりの音道面積拡大率を0.01増加
  l  10cm当たりの音道面積拡大率を0.001増加
  n  10cm当たりの音道面積拡大率を0.1減少
  m  10cm当たりの音道面積拡大率を0.01減少
  ,  10cm当たりの音道面積拡大率を0.001減少
  [  側板の外側の表示を1mm減少
  ]  側板の外側の表示を1mm増加

  マウスクリック  側板のサイズを変更


SOUND_PATHモード
  矢印キー  カーソルに一番近い対象を1mmずつ移動
  a  音道頂点の追加
  D  カーソルに一番近い音道頂点の削除
  
  マウスクリック  カーソルに一番近い音道頂点の移動

*/


// もしこのプログラムを使ってみたいと思ったら、メール

/* 
このプログラムは
　Constant Width型のバックロードホーンスピーカーの
　音道の形状を試行錯誤しながら決めるのを支援するものです。
　ただし、音道幅はスロートから開口端まで完全に一定なのが前提で、
　音道がどんなに扁平になっても知りません！
　
使い方　もし欲しい人がいたら書きます、、、いないか、、、、
　曲がり角
　部分ホーン
　ホーン長
　
曲がり角の移動
曲がり角の追加
曲がり角の削除
設計データの取り出し方
設計データの読み込み方

設定できるパラメタ

*/
import processing.core.*;

public class HelpWindow extends PApplet {
  
  HelpWindow() {
    
  }
  
  public void settings() {
    size(400, 400);
  }
  
  public void setup() {
    background(255);
    textSize(15);
    rectMode(CENTER);
    fill(200,255);  
    textAlign(CENTER);
    textLeading(10);
    textSize(20);
    blendMode(DIFFERENCE);  
    text("writing help now", 100,100);
    t();
  }
    
  void t() {
    text("writing help now", 200,200);
    if (KeyPressedOption == KeyPressedType.SOUND_PATH) {
      text("11111", 300,300);
    } else if (KeyPressedOption == KeyPressedType.LUMBER_PLACEMENT) {
      text("22222", 300,300);      
    } else {
            text("33333", 300,300);      
    }
  }
    
  public void exit() {
    dispose();
  }
  
  public void close() {
    surface.setVisible(false);
    dispose();
  }

}

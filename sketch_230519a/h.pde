// もしこのプログラムを使ってみたいと思ったら、メール


/* 
このプログラムは
　Constant Width型のバックロードホーンスピーカーの
　音道の形状を試行錯誤しながら決めるのを支援するものです。
　ただし、音道幅はスロートから開口端まで完全に一定なのが前提で、
　音道がどんなに扁平になっても知りません！
　
使い方　もし欲しい人がいたら書きます、、、いないか、、、、
　プリセットホーンの説明
　曲がり角
　部分ホーン
　ホーン長
　
曲がり角の移動
曲がり角の追加
曲がり角の削除
設計データの取り出し方
ログについて

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

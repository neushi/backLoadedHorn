/* lumber.add(0120, 0100, 0120.02, 0018.00, 12.0, false);   // #03  0082mm
  のように0を前置すると引数の数値を正しく読まないバグがあるようだ  */
  
void presetDesign() {  

sideBoard.size(1276.0, 448.0);
NAGAOKA_K = 1.0970001;
horn.corners.add(new Horn_corner(00091.00, 00018.00));
horn.corners.add(new Horn_corner(00081.00, 00885.00));
horn.corners.add(new Horn_corner(00132.00, 00884.00));
horn.corners.add(new Horn_corner(00157.00, 00076.00));
horn.corners.add(new Horn_corner(00187.00, 00046.00));
horn.corners.add(new Horn_corner(00342.00, 00053.00));
horn.corners.add(new Horn_corner(00380.00, 00094.00));
horn.corners.add(new Horn_corner(00310.00, 00971.00));
horn.corners.add(new Horn_corner(00233.00, 01055.00));
horn.corners.add(new Horn_corner(00000.00, 01088.00));
// 音道長 : 3209.0mm,   幅 : 175.6,   出口開き角度 : 16.6度,   100mm当たりホーン拡大率 K : 1.0970001
// 音道長 : 2973.7mm,   幅 : 141.2,   出口開き角度 : 14.1度,   100mm当たりホーン拡大率 K : 1.0970001
// 音道長 : 2859.7mm,   幅 : 127.1,   出口開き角度 : 09.2度,   100mm当たりホーン拡大率 K : 1.0970001
// 音道長 : 1979.9mm,   幅 : 056.3,   出口開き角度 : 05.8度,   100mm当たりホーン拡大率 K : 1.0970001
// 音道長 : 1924.0mm,   幅 : 053.4,   出口開き角度 : 05.3度,   100mm当たりホーン拡大率 K : 1.0970001
// 音道長 : 1768.9mm,   幅 : 046.3,   出口開き角度 : 04.8度,   100mm当たりホーン拡大率 K : 1.0970001
// 音道長 : 1726.5mm,   幅 : 044.5,   出口開き角度 : 03.3度,   100mm当たりホーン拡大率 K : 1.0970001
// 音道長 : 0918.1mm,   幅 : 021.1,   出口開き角度 : 02.2度,   100mm当たりホーン拡大率 K : 1.0970001
// 音道長 : 0867.1mm,   幅 : 020.1,   出口開き角度 : 01.5度,   100mm当たりホーン拡大率 K : 1.0970001
// 音道長 : 0000.0mm,   幅 : 009.0,   出口開き角度 : ------,   100mm当たりホーン拡大率 K : 1.0970001
lumber.add(0.0, 0.0, 448.0, 0.0, 12.0, true);
lumber.add(118.0, 49.0, 157.24174, 6.2906876, 12.0, true);
lumber.add(374.0, 8.0, 428.38428, 59.646397, 12.0, true);
lumber.add(0.0, 200.0, 0.0034925628, -12.0, 12.0, true);
lumber.add(211.0, 95.0, 309.59296, 103.96823, 12.0, false);
lumber.add(0.0, 188.0, 66.0, 188.0, 12.0, false);
lumber.add(100.0, 865.0, 100.0, 0.0, 12.0, false);
lumber.add(60.0, 903.0, 81.94611, 18.272156, 12.0, true);
lumber.add(152.0, 903.0, 199.94221, 94.420044, 12.0, false);
lumber.add(191.0, 917.0, 320.57953, 106.290344, 12.0, true);
lumber.add(448.0, 0.0, 448.0, 1276.0, 12.0, false);
lumber.add(0.0, 915.0, 179.99722, 916.0, 12.0, true);
lumber.add(330.0, 1159.0, 424.22742, 1027.2229, 12.0, false);
lumber.add(4.0, 1288.0, 433.7068, 1147.7998, 12.0, true);
lumber.add(448.0, 1276.0, 43.0, 1276.0, 12.0, true);
// #00   0000,  0000  -R-   0448.0,  0000.0,    0448mm out of sideBoard 
// #01   0118,  0049  -R-   0157.2,  0006.3,    0058mm
// #02   0374,  0008  -R-   0428.4,  0059.6,    0075mm
// #03   0000,  0200  -R-   0000.0, -0012.0,    0212mm out of sideBoard 
// #04   0211,  0095  -L-   0309.6,  0104.0,    0099mm
// #05   0000,  0188  -L-   0066.0,  0188.0,    0066mm
// #06   0100,  0865  -L-   0100.0,  0000.0,    0865mm
// #07   0060,  0903  -R-   0081.9,  0018.3,    0885mm
// #08   0152,  0903  -L-   0199.9,  0094.4,    0810mm
// #09   0191,  0917  -R-   0320.6,  0106.3,    0821mm
// #10   0448,  0000  -L-   0448.0,  1276.0,    1276mm
// #11   0000,  0915  -R-   0180.0,  0916.0,    0180mm
// #12   0330,  1159  -L-   0424.2,  1027.2,    0162mm
// #13   0004,  1288  -R-   0433.7,  1147.8,    0452mm
// #14   0448,  1276  -R-   0043.0,  1276.0,    0405mm out of sideBoard 



/**/
}
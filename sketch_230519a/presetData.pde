
  
void presetDesign() {  
sideBoard.size(1300.0, 600.0);
horn.corners.add(new Horn_corner(00132.86, 00021.57));
horn.corners.add(new Horn_corner(00574.71, 00025.71));
horn.corners.add(new Horn_corner(00554.57, 01171.86));
horn.corners.add(new Horn_corner(00473.71, 01171.43));
horn.corners.add(new Horn_corner(00463.00, 00131.71));
horn.corners.add(new Horn_corner(00273.57, 00142.57));
horn.corners.add(new Horn_corner(00222.00, 01012.00));
horn.corners.add(new Horn_corner(00000.00, 01013.00));
// 音道長 : 3991.5mm,   幅 : 233.6,   出口開き角度 : 19.8度,   100mm当たりホーン拡大係数 K : 1.085
// 音道長 : 3769.5mm,   幅 : 194.9,   出口開き角度 : 13.0度,   100mm当たりホーン拡大係数 K : 1.085
// 音道長 : 2898.6mm,   幅 : 095.8,   出口開き角度 : 08.3度,   100mm当たりホーン拡大係数 K : 1.085
// 音道長 : 2708.8mm,   幅 : 082.0,   出口開き角度 : 05.2度,   100mm当たりホーン拡大係数 K : 1.085
// 音道長 : 1669.1mm,   幅 : 035.1,   出口開き角度 : 03.2度,   100mm当たりホーン拡大係数 K : 1.085
// 音道長 : 1588.2mm,   幅 : 032.9,   出口開き角度 : 02.0度,   100mm当たりホーン拡大係数 K : 1.085
// 音道長 : 0441.9mm,   幅 : 012.9,   出口開き角度 : 01.0度,   100mm当たりホーン拡大係数 K : 1.085
// 音道長 : 0000.0mm,   幅 : 009.0,   出口開き角度 : ------,   100mm当たりホーン拡大係数 K : 1.085
lumber.add(00160.00, 00397.00, 00261.12, 00498.12, 00012.00, true); // 143mm
lumber.add(00207.00, 00593.00, 00308.12, 00694.12, 00012.00, true); // 143mm
lumber.add(00157.00, 00459.00, 00258.12, 00560.12, 00012.00, true); // 143mm
}
/* Ver.1   ユニットとホーンが近い   
horn.corners.add(new Horn_corner(00132.86, 00022.57));
horn.corners.add(new Horn_corner(00575.29, 00026.14));
horn.corners.add(new Horn_corner(00574.86, 00064.86));
horn.corners.add(new Horn_corner(00157.14, 00062.71));
horn.corners.add(new Horn_corner(00155.71, 00113.86));
horn.corners.add(new Horn_corner(00560.71, 00118.43));
horn.corners.add(new Horn_corner(00521.57, 01221.14));
horn.corners.add(new Horn_corner(00367.29, 01211.86));
horn.corners.add(new Horn_corner(00352.14, 00362.86));
horn.corners.add(new Horn_corner(-00000.29, 00363.43));*/
/* Ver.2 作り易そう   
horn.corners.add(new Horn_corner(00132.86, 00021.57));
horn.corners.add(new Horn_corner(00574.71, 00025.71));
horn.corners.add(new Horn_corner(00554.57, 01171.86));
horn.corners.add(new Horn_corner(00473.71, 01171.43));
horn.corners.add(new Horn_corner(00463.00, 00131.71));
horn.corners.add(new Horn_corner(00273.57, 00142.57));
horn.corners.add(new Horn_corner(00222.00, 01012.00));
horn.corners.add(new Horn_corner(00000.00, 01013.00));*/
// 音道全長 : 3991.53mm,  出口開き角度 : 19.77度,  100mm当たりホーン拡大係数 K : 1.085    
/* 曲がりは滑らか
horn.corners.add(new Horn_corner(00132.86, 00022.57));
horn.corners.add(new Horn_corner(00574.29, 00026.14));
horn.corners.add(new Horn_corner(00573.86, 00064.86));
horn.corners.add(new Horn_corner(00157.14, 00063.71));
horn.corners.add(new Horn_corner(00155.71, 00114.86));
horn.corners.add(new Horn_corner(00560.71, 00118.43));
horn.corners.add(new Horn_corner(00521.00, 01102.00));
horn.corners.add(new Horn_corner(00393.00, 01221.00));
horn.corners.add(new Horn_corner(00152.57, 01187.71));
horn.corners.add(new Horn_corner(00124.00, 01002.71));
horn.corners.add(new Horn_corner(00315.00, 00669.00));
horn.corners.add(new Horn_corner(00317.00, 00564.00));
horn.corners.add(new Horn_corner(00242.71, 00454.57));
horn.corners.add(new Horn_corner(00092.86, 00384.29));
horn.corners.add(new Horn_corner(00002.29, 00384.29));*/

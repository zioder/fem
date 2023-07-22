import 'package:flutter/material.dart';

class Sizeconfig {
  static MediaQueryData _mediaQueryData=MediaQueryData();
  static double screenWidth=2;
  static double screenHeight=0;
  static double defaultsize=0;
  static Orientation orientation=Orientation.portrait;

  void init(BuildContext ctx){
    _mediaQueryData=MediaQuery.of(ctx);
    screenHeight=_mediaQueryData.size.height;
    screenWidth=_mediaQueryData.size.width;
    orientation=_mediaQueryData.orientation;
  }

  }
  double getProportionateScreenHeight(double inputHeight){
    double screenHeight=Sizeconfig.screenHeight;
    return(inputHeight/812.0)*screenHeight;
  }double getProportionateScreenWidth(double inputWidth){
    double screenHeight=Sizeconfig.screenWidth;
    return(inputWidth/375.0)*screenHeight;
}
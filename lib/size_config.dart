import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double realWidthPixels;
  static late double realHeightPixels;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    realWidthPixels = screenWidth * _mediaQueryData.devicePixelRatio;
    realHeightPixels = screenHeight * _mediaQueryData.devicePixelRatio;
    orientation = _mediaQueryData.orientation;
    if (orientation == Orientation.landscape) {
      defaultSize = screenHeight * 0.024;
    } else {
      defaultSize = screenWidth * 0.024;
    }
  }
}

double getSize(double size) {
  return ((SizeConfig.defaultSize * size) / 10);
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

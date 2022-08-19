import 'package:flutter/material.dart';

class GetSize{
  GetSize._();
  static double? _screenHeight;
  static double? _screenWidth;
  static double? _pixelHeight;
  static double? _pixelWidth;

  static void init(BuildContext context){
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    _pixelHeight = _screenHeight! / 360;
    _pixelWidth = _screenWidth! /360;
  }

  static double get getScreenHeight => _screenHeight!;
  static double get getScreenWidth => _screenWidth!;

  static double get getPixelHeight => _pixelHeight!;
  static double get getPixelWidth => _pixelWidth!;


}
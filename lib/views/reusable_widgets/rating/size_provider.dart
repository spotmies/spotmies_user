import 'dart:math';

import 'package:flutter/material.dart';

class SizeProvider {
  static  double screenWidthFactor;
  static  double screenHeightFactor;
  static  Orientation orientation;
  void init(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    orientation = mediaQueryData.orientation;
    var size = mediaQueryData.size;
    screenWidthFactor = orientation == Orientation.portrait
        ? (size.width / 411)
        : (size.width / 891);
    screenHeightFactor = orientation == Orientation.portrait
        ? (size.height / 891)
        : (size.height / 411);
  }
}

double getProportionateWidth(double width) {
  return SizeProvider.screenWidthFactor * width;
}

double getProportionateHeight(double height) {
  return SizeProvider.screenHeightFactor * height;
}

double getProportionateSize(double size) {
  return max(getProportionateHeight(size), getProportionateWidth(size));
}
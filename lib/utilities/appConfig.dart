import 'package:flutter/material.dart';

class AppColors {
  static var primaryColorLite = Colors.indigo[900];
  static var secondaryColorLite = Colors.indigo[50];
  static var white = Colors.white;
  static var dark = Colors.grey[900];
  static var grey = Colors.grey;
}



 height(context) {
  return MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      kToolbarHeight;
}
 width(context) {
  return MediaQuery.of(context).size.width;
}

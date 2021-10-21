import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spotmies/utilities/textWidget.dart';

waiting(double hight, double width) {
  return Scaffold(
      body: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        height: hight * 0.55,
        width: width,
        child: Lottie.asset('assets/waiting.json'),
      ),
      Column(
        children: [
          TextWidget(
            text: 'Please Wait.....',
            size: width * 0.05,
            color: Colors.grey[900],
            weight: FontWeight.w600,
          ),
          SizedBox(
            height: hight * 0.01,
          ),
          TextWidget(
            text: 'We are trying to update your personal information',
            size: width * 0.04,
            color: Colors.grey[900],
            weight: FontWeight.w500,
          ),
        ],
      ),
    ],
  ));
}

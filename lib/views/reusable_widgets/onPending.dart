import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spotmies/utilities/textWidget.dart';

onPending(double hight, double width) {
  return Scaffold(
      body: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        height: hight * 0.3,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info,
              size: width * 0.2,
              color: Colors.amber,
            ),
            SizedBox(height: hight*0.02,),
             TextWidget(
              text: 'Do not press back button',
              size: width * 0.05,
              color: Colors.grey[900],
              weight: FontWeight.w600,
            ),
            SizedBox(height: hight*0.005,),
            TextWidget(
              text: 'We are trying to place the service',
              size: width * 0.05,
              color: Colors.grey[900],
              weight: FontWeight.w600,
            ),
          ],
        ),
      ),
      Container(
        height: hight * 0.55,
        width: width,
        child: Lottie.asset('assets/onPending.json'),
      ),
      TextWidget(
        text: 'Please Wait...',
        size: width * 0.05,
        color: Colors.grey[900],
        weight: FontWeight.w600,
      ),
    ],
  ));
}

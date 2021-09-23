import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/textWidget.dart';

onFail(double hight, double width, BuildContext context) {
  return Scaffold(
      body: Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        // height: hight * 0.4,
        width: width,
        child: Lottie.asset('assets/fail.json',
            height: hight * 0.3, width: hight * 0.3),
      ),
      Container(
        height: hight * 0.3,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextWidget(
              text: 'Request Failed',
              size: width * 0.06,
              color: Colors.grey[900],
              weight: FontWeight.w700,
            ),
            SizedBox(
              height: hight * 0.005,
            ),
            Container(
              width: width * 0.8,
              child: TextWidget(
                text:
                    'Something went wrong, Please make sure your internet connection good \n or we are going to fix it,Try later',
                size: width * 0.04,
                flow: TextOverflow.visible,
                align: TextAlign.center,
                color: Colors.grey[900],
                weight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: hight * 0.1,
            ),
            ElevatedButtonWidget(
              minWidth: width * 0.35,
              height: hight * 0.06,
              bgColor: Colors.white,
              borderSideColor: Colors.grey[900],
              buttonName: 'Back',
              textStyle: FontWeight.w600,
              textSize: width * 0.04,
              leadingIcon: Icon(
                Icons.arrow_back,
                color: Colors.grey[900],
                size: width * 0.045,
              ),
              borderRadius: 10.0,
              onClick: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    ],
  ));
}

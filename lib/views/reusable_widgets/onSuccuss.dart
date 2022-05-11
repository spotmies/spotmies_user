import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/textWidget.dart';

class OnSuccuss extends StatelessWidget {
  const OnSuccuss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          // height: height(context) * 0.4,
          width: width(context),
          child: Lottie.asset('assets/succuss.json',
              height: height(context) * 0.3, width: height(context) * 0.3),
        ),
        Container(
          height: height(context) * 0.3,
          width: width(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextWidget(
                text: 'Succussfully Published',
                size: width(context) * 0.06,
                color: Colors.grey[900],
                weight: FontWeight.w700,
              ),
              SizedBox(
                height: height(context) * 0.005,
              ),
              Container(
                width: width(context) * 0.8,
                child: TextWidget(
                  text:
                      'Your service request is succussfully posted, please keep checking responses, technician will contact you as soon as possible',
                  size: width(context) * 0.04,
                  flow: TextOverflow.visible,
                  align: TextAlign.center,
                  color: Colors.grey[900],
                  weight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: height(context) * 0.1,
              ),
              ElevatedButtonWidget(
                minWidth: width(context) * 0.35,
                height: height(context) * 0.06,
                bgColor: Colors.white,
                borderSideColor: Colors.grey[900],
                buttonName: 'Back',
                textStyle: FontWeight.w600,
                textSize: width(context) * 0.04,
                leadingIcon: Icon(
                  Icons.arrow_back,
                  color: Colors.grey[900],
                  size: width(context) * 0.045,
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
}

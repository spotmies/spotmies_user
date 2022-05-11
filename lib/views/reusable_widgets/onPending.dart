import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/textWidget.dart';

class OnPending extends StatelessWidget {
  const OnPending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: height(context) * 0.3,
          width: width(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info,
                size: width(context) * 0.2,
                color: Colors.amber,
              ),
              SizedBox(
                height: height(context) * 0.02,
              ),
              TextWidget(
                text: 'Do not press back button',
                size: width(context) * 0.05,
                color: Colors.grey[900],
                weight: FontWeight.w600,
              ),
              SizedBox(
                height: height(context) * 0.005,
              ),
              TextWidget(
                text: 'We are trying to place the service',
                size: width(context) * 0.05,
                color: Colors.grey[900],
                weight: FontWeight.w600,
              ),
            ],
          ),
        ),
        Container(
          height: height(context) * 0.55,
          width: width(context),
          child: Lottie.asset('assets/onPending.json'),
        ),
        TextWidget(
          text: 'Please Wait...',
          size: width(context) * 0.05,
          color: Colors.grey[900],
          weight: FontWeight.w600,
        ),
      ],
    ));
  }
}

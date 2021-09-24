import 'package:flutter/material.dart';
import 'package:spotmies/controllers/home_controllers/ad_controll.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/maps/onLine_placesSearch.dart';
import 'package:spotmies/views/reusable_widgets/steps.dart';

import '../../maps/maps.dart';

Widget page3(double hight, double width, user, AdController adController,
    BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: hight * 0.05,
        ),
        width: width * 1,
        child: Container(
          height: hight * 1,
          width: width,
          padding: EdgeInsets.only(top: hight * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom: width * 0.05,
                ),
                height: hight * 0.1,
                width: width * 0.8,
                child: Center(
                  child: steps(3, width),
                ),
              ),
              Container(
                height: hight * 0.75,
                width: width * 0.87,
                child: ListView(
                  children: [
                    TextWidget(
                      text: 'Choose Service Location',
                      size: width * 0.06,
                      align: TextAlign.center,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: hight * 0.022,
                    ),
                    Container(
                      height: hight * 0.3,
                      child: Maps(),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            blurRadius: 5,
                            spreadRadius: 2)
                      ]),
                    ),
                    SizedBox(
                      height: hight * 0.022,
                    ),
                    Container(
                      height: hight * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  TextWidget(text: adController.latitude + ","),
                                  TextWidget(text: adController.longitude),
                                ],
                              ),
                              TextWidget(
                                text: adController.fullAddress.isNotEmpty
                                    ? adController.fullAddress['addressLine']
                                    : "Unable to Get your Location",
                                size: width * 0.04,
                                flow: TextOverflow.visible,
                                weight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: hight * 0.03,
                              ),
                            ],
                          ),
                          Container(
                            height: hight * 0.1,
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButtonWidget(
                                  buttonName: 'My Location',
                                  bgColor: Colors.transparent,
                                  borderSideColor: Colors.indigo[900],
                                  textSize: width * 0.035,
                                  borderRadius: 15.0,
                                  onClick: () {
                                    adController.getCurrentLocation();
                                    adController.getAddressofLocation();
                                  },
                                  height: hight * 0.07,
                                  minWidth: width * 0.35,
                                ),
                                ElevatedButtonWidget(
                                  buttonName: 'Change Location',
                                  bgColor: Colors.transparent,
                                  borderSideColor: Colors.indigo[900],
                                  borderRadius: 15.0,
                                  textSize: width * 0.035,
                                  height: hight * 0.07,
                                  minWidth: width * 0.35,
                                  onClick: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OnlinePlaceSearch()));
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: hight * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButtonWidget(
                      onClick: () {
                        adController.sliderKey.currentState.previous();
                      },
                      buttonName: 'Back',
                      bgColor: Colors.indigo[50],
                      textColor: Colors.indigo[900],
                      height: hight * 0.05,
                      minWidth: width * 0.30,
                      textSize: hight * 0.02,
                      leadingIcon: Icon(
                        Icons.arrow_back_ios,
                        size: hight * 0.015,
                        color: Colors.indigo[900],
                      ),
                      borderRadius: 10.0,
                    ),
                    ElevatedButtonWidget(
                      onClick: () async {
                        await adController.step3(user);
                      },
                      buttonName: 'Finish',
                      bgColor: Colors.indigo[900],
                      textColor: Colors.white,
                      height: hight * 0.05,
                      minWidth: width * 0.60,
                      textSize: hight * 0.02,
                      trailingIcon: Icon(
                        Icons.arrow_forward_ios,
                        size: hight * 0.015,
                      ),
                      borderRadius: 10.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

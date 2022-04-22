import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spotmies/controllers/home_controllers/ad_controll.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/maps/offLine_placesModel.dart';
import 'package:spotmies/views/maps/onLine_placesSearch.dart';
import 'package:spotmies/views/reusable_widgets/steps.dart';

Widget page3(double hight, double width, user, AdController adController,
    BuildContext context, GetOrdersProvider? ordersProvider) {
  // adController.getCurrentLocation();
  return Scaffold(
    backgroundColor: SpotmiesTheme.background,
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
                      color: SpotmiesTheme.secondaryVariant,
                    ),
                    SizedBox(
                      height: hight * 0.022,
                    ),
                    Container(
                      height: hight * 0.3,
                      child: Maps(
                        isSearch: false,
                        isNavigate: false,
                        onSave: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => Maps(),
                          // ));
                        },
                      ),
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
                                  TextWidget(
                                    text: adController.fullAddress['latitude']
                                            .toString() +
                                        ",",
                                    color: SpotmiesTheme.primaryVariant,
                                  ),
                                  TextWidget(
                                    text: adController.fullAddress['logitude']
                                        .toString(),
                                    color: SpotmiesTheme.primaryVariant,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextWidget(
                                text: adController.fullAddress.isNotEmpty
                                    ? '${adController.fullAddress['name']},${adController.fullAddress['street']}, ${adController.fullAddress['subLocality']}, ${adController.fullAddress['locality']}, ${adController.fullAddress['subAdminArea']}, ${adController.fullAddress['adminArea']}, ${adController.fullAddress['postalCode']}, ${adController.fullAddress['isoCountryCode']}'
                                        .toString()
                                    : "Unable to Get your Location",
                                size: width * 0.04,
                                flow: TextOverflow.visible,
                                weight: FontWeight.w500,
                                color: SpotmiesTheme.secondaryVariant,
                              ),
                              SizedBox(
                                height: hight * 0.03,
                              ),
                            ],
                          ),
                          Container(
                            height: hight * 0.1,
                            width: width * 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButtonWidget(
                                  buttonName: 'My Location',
                                  bgColor:
                                      SpotmiesTheme.primary.withOpacity(0.2),
                                  borderSideColor: Colors.transparent,
                                  textSize: width * 0.035,
                                  textColor: SpotmiesTheme.onBackground,
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
                                  textColor: SpotmiesTheme.onBackground,
                                  borderSideColor: SpotmiesTheme.primary,
                                  borderRadius: 15.0,
                                  textSize: width * 0.035,
                                  height: hight * 0.07,
                                  minWidth: width * 0.4,
                                  onClick: () {
                                    // var add =
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OnlinePlaceSearch(
                                                  onSave: (cords, fullAddress) {
                                                    log("cor $cords $fullAddress");
                                                    adController
                                                        .updateLocations(
                                                            cords['lat'],
                                                            cords['log'],
                                                            fullAddress);
                                                  },
                                                )));
                                    // log(add.toString());
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
                        adController.sliderKey.currentState?.previous();
                      },
                      buttonName: 'Back',
                      bgColor: SpotmiesTheme.primaryVariant,
                      borderSideColor: SpotmiesTheme.primaryVariant,
                      textColor: SpotmiesTheme.primary,
                      height: hight * 0.05,
                      minWidth: width * 0.30,
                      textSize: hight * 0.02,
                      leadingIcon: Icon(
                        Icons.arrow_back_ios,
                        size: hight * 0.015,
                        color: SpotmiesTheme.primary,
                      ),
                      borderRadius: 10.0,
                    ),
                    ElevatedButtonWidget(
                      onClick: () async {
                        await adController.step3(
                            user, context, ordersProvider!);
                      },
                      buttonName: 'Review',
                      bgColor: SpotmiesTheme.primary,
                      borderSideColor: SpotmiesTheme.primary,
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

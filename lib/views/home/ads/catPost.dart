import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spotmies/controllers/home_controllers/ad_controll.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/home/data.dart';
import 'package:spotmies/views/maps/offLine_placesModel.dart';
import 'package:spotmies/views/maps/onLine_placesSearch.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

Widget catPost(
    BuildContext context,
    AdController adController,
    UniversalProvider universalProvider,
    catData,
    GetOrdersProvider? ordersProvider,
    user) {
  return Container(
      // alignment: Alignment.center,
      padding: EdgeInsets.only(
          // left: width(context) * 0.03,
          // right: width(context) * 0.03,
          top: width(context) * 0.02),
      decoration: BoxDecoration(
          color: SpotmiesTheme.surfaceVariant,
          borderRadius: BorderRadius.circular(15)),
      width: width(context),
      child: Column(children: [
        AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back,
                color: SpotmiesTheme.onBackground,
              )),
        ),
        Container(
          width: width(context) * 0.82,
          padding: EdgeInsets.only(
              left: width(context) * 0.03, top: width(context) * 0.02),
          child: TextWidget(
            text: 'Schedule:',
            color: SpotmiesTheme.secondaryVariant,
            size: width(context) * 0.04,
            weight: FontWeight.w600,
          ),
        ),
        InkWell(
            onTap: () async {
              await adController.pickDate(context);
              adController.refresh();
              await adController.picktime(context);
              adController.datePickColor = 0;
              adController.refresh();
            },
            child: Container(
              height: height(context) * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: width(context) * 0.45,
                      // color: Colors.amber[50],
                      child: Row(
                        children: [
                          TextWid(
                            text: DateFormat('dd').format(
                                (DateTime.fromMillisecondsSinceEpoch(
                                    (adController
                                        .pickedDate.millisecondsSinceEpoch)))),
                            size: width(context) * 0.12,
                          ),
                          SizedBox(
                            width: width(context) * 0.02,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWid(
                                text: DateFormat('MMM').format(
                                    (DateTime.fromMillisecondsSinceEpoch(
                                        (adController.pickedDate
                                            .millisecondsSinceEpoch)))),
                                weight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: width(context) * 0.01,
                              ),
                              TextWid(
                                text: DateFormat('EEEE').format(
                                    (DateTime.fromMillisecondsSinceEpoch(
                                        (adController.pickedDate
                                            .millisecondsSinceEpoch)))),
                              )
                            ],
                          ),
                          SizedBox(
                            width: width(context) * 0.02,
                          ),
                          Icon(Icons.calendar_today,
                              color: SpotmiesTheme.equal,
                              size: width(context) * 0.06)
                        ],
                      )),
                  SizedBox(
                    width: width(context) * 0.02,
                  ),
                  InkWell(
                    onTap: () async {
                      adController.pickedDate = await DateTime.now();
                      adController.datePickColor = 1;
                      adController.refresh();
                    },
                    child: Container(
                      height: height(context) * 0.06,
                      width: width(context) * 0.15,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: adController.datePickColor == 1
                                  ? SpotmiesTheme.primary
                                  : SpotmiesTheme.equal),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextWid(
                            text: DateFormat('dd MMM').format(
                                (DateTime.fromMillisecondsSinceEpoch(
                                    (DateTime.now().millisecondsSinceEpoch)))),
                            weight: FontWeight.w600,
                            size: width(context) * 0.025,
                          ),
                          TextWid(
                            text: 'Today',
                            weight: FontWeight.w500,
                            size: width(context) * 0.025,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width(context) * 0.02,
                  ),
                  InkWell(
                    onTap: () async {
                      adController.pickedDate =
                          await DateTime.now().add(Duration(days: 1));
                      adController.datePickColor = 2;
                      adController.refresh();
                    },
                    child: Container(
                      height: height(context) * 0.06,
                      width: width(context) * 0.15,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: adController.datePickColor == 2
                                  ? SpotmiesTheme.primary
                                  : SpotmiesTheme.equal),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextWid(
                            text: DateFormat('dd MMM').format(
                                (DateTime.fromMillisecondsSinceEpoch(
                                    (DateTime.now()
                                        .add(Duration(days: 1))
                                        .millisecondsSinceEpoch)))),
                            weight: FontWeight.w600,
                            size: width(context) * 0.025,
                          ),
                          TextWid(
                            text: 'Tomorrow',
                            weight: FontWeight.w500,
                            size: width(context) * 0.025,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
        Container(
          width: width(context) * 0.8,
          padding: EdgeInsets.only(left: width(context) * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextWid(
                text: 'Service :',
                weight: FontWeight.w600,
                size: width(context) * 0.055,
                color: SpotmiesTheme.onBackground,
              ),
              SizedBox(
                width: width(context) * 0.05,
              ),
              TextWid(
                text: toBeginningOfSentenceCase(catData["name"].toString())
                    .toString(),
                weight: FontWeight.w500,
                size: width(context) * 0.055,
                color: SpotmiesTheme.onBackground,
              ),
            ],
          ),
        ),
        Container(
          width: width(context) * 0.8,
          padding: EdgeInsets.only(left: width(context) * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextWid(
                text: 'Price     :',
                weight: FontWeight.w600,
                size: width(context) * 0.055,
                color: SpotmiesTheme.onBackground,
              ),
              SizedBox(
                width: width(context) * 0.05,
              ),
              TextWid(
                text: toBeginningOfSentenceCase(catData["price"].toString())
                    .toString(),
                weight: FontWeight.w500,
                size: width(context) * 0.055,
                color: SpotmiesTheme.onBackground,
              ),
            ],
          ),
        ),
        Container(
          height: height(context) * 1,
          width: width(context),
          padding: EdgeInsets.only(
              top: height(context) * 0.03, left: width(context) * 0.03),
          child: Column(
            children: [
             
              Container(
                height: height(context) * 0.75,
                width: width(context) * 0.8,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    TextWidget(
                      text: 'Choose Service Location',
                      size: width(context) * 0.06,
                      align: TextAlign.start,
                      weight: FontWeight.w500,
                      color: SpotmiesTheme.secondaryVariant,
                    ),
                    SizedBox(
                      height: height(context) * 0.022,
                    ),
                    Container(
                      height: height(context) * 0.3,
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
                      height: height(context) * 0.022,
                    ),
                    Container(
                      height: height(context) * 0.3,
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
                                          ","),
                                  TextWidget(
                                      text: adController.fullAddress['logitude']
                                          .toString()),
                                ],
                              ),
                              TextWidget(
                                text: adController.fullAddress.isNotEmpty
                                    ? '${adController.fullAddress['name']},${adController.fullAddress['street']}, ${adController.fullAddress['subLocality']}, ${adController.fullAddress['locality']}, ${adController.fullAddress['subAdminArea']}, ${adController.fullAddress['adminArea']}, ${adController.fullAddress['postalCode']}, ${adController.fullAddress['isoCountryCode']}'
                                        .toString()
                                    : "Unable to Get your Location",
                                size: width(context) * 0.04,
                                flow: TextOverflow.visible,
                                weight: FontWeight.w500,
                                color: SpotmiesTheme.secondaryVariant,
                              ),
                              SizedBox(
                                height: height(context) * 0.03,
                              ),
                            ],
                          ),
                          Container(
                            height: height(context) * 0.1,
                            width: width(context) * 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButtonWidget(
                                  buttonName: 'My Location',
                                  bgColor: Colors.transparent,
                                  borderSideColor: SpotmiesTheme.primary,
                                  textSize: width(context) * 0.035,
                                  textColor: SpotmiesTheme.onBackground,
                                  borderRadius: 15.0,
                                  onClick: () {
                                    adController.getCurrentLocation();
                                    adController.getAddressofLocation();
                                  },
                                  height: height(context) * 0.07,
                                  minWidth: width(context) * 0.35,
                                ),
                                ElevatedButtonWidget(
                                  buttonName: 'Change Location',
                                  bgColor: Colors.transparent,
                                  textColor: SpotmiesTheme.onBackground,
                                  borderSideColor: SpotmiesTheme.primary,
                                  borderRadius: 15.0,
                                  textSize: width(context) * 0.035,
                                  height: height(context) * 0.07,
                                  minWidth: width(context) * 0.4,
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
                height: height(context) * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButtonWidget(
                      onClick: () {
                        adController.sliderKey.currentState?.previous();
                      },
                      buttonName: 'Back',
                      bgColor: Colors.indigo[50],
                      borderSideColor: Colors.indigo[50],
                      textColor: Colors.indigo[900],
                      height: height(context) * 0.05,
                      minWidth: width(context) * 0.30,
                      textSize: height(context) * 0.02,
                      leadingIcon: Icon(
                        Icons.arrow_back_ios,
                        size: height(context) * 0.015,
                        color: Colors.indigo[900],
                      ),
                      borderRadius: 10.0,
                    ),
                    ElevatedButtonWidget(
                      onClick: () async {
                        await adController.catFinish(
                            user, context, ordersProvider!,catData: catData);
                      },
                      buttonName: 'Finish',
                      bgColor: SpotmiesTheme.primary,
                      borderSideColor: SpotmiesTheme.primary,
                      textColor: Colors.white,
                      height: height(context) * 0.05,
                      minWidth: width(context) * 0.60,
                      textSize: height(context) * 0.02,
                      trailingIcon: Icon(
                        Icons.arrow_forward_ios,
                        size: height(context) * 0.015,
                      ),
                      borderRadius: 10.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]));
}

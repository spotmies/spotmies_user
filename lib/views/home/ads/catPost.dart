import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/home_controllers/ad_controll.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/progressIndicator.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/maps/offLine_placesModel.dart';
import 'package:spotmies/views/maps/onLine_placesSearch.dart';
import 'package:spotmies/views/reusable_widgets/onFailure.dart';
import 'package:spotmies/views/reusable_widgets/onPending.dart';
import 'package:spotmies/views/reusable_widgets/onSuccuss.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class CatBook extends StatefulWidget {
  final dynamic cat;
  final dynamic user;
  const CatBook({Key? key, this.cat, this.user}) : super(key: key);

  @override
  _CatBookState createState() => _CatBookState();
}

class _CatBookState extends StateMVC<CatBook> {
  late AdController adController;
  _CatBookState() : super(AdController()) {
    this.adController = controller as AdController;
  }
  UniversalProvider? universalProvider;

  GetOrdersProvider? ordersProvider;
  @override
  void initState() {
    ordersProvider = Provider.of<GetOrdersProvider>(context, listen: false);
    universalProvider = Provider.of<UniversalProvider>(context, listen: false);
    // log("39 " + widget.cat.toString());
    universalProvider?.getSingleCatelog(widget.cat);
    adController.getAddressofLocation();
    adController.pickedDate = DateTime.now();
    adController.pickedTime = TimeOfDay.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UniversalProvider>(builder: (context, data, child) {
      dynamic sc = data.singleCatelog;
      log("52----->" + sc.toString());
      if (sc == null) return circleProgress();
      switch (adController.isUploading) {
        case 1:
          return OnPending();
        case 2:
          return OnFail();
        case 3:
          return OnSuccuss();

        default:
          break;
      }
      return Container(
        height: height(context),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[50],
            elevation: 0,
            title: TextWid(
              text: "Confirm booking",
              size: width(context) * 0.055,
              weight: FontWeight.w600,
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: SpotmiesTheme.onBackground,
                )),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            height: height(context) * 0.1,
            width: width(context),
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
                        widget.user, context, ordersProvider!,
                        catData: sc);
                  },
                  buttonName: 'Confirm',
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
          body: SingleChildScrollView(
            child: Container(
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
                  Container(
                    width: width(context) * 0.82,
                    padding: EdgeInsets.only(
                        left: width(context) * 0.03,
                        top: width(context) * 0.02),
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
                                              (adController.pickedDate
                                                  .millisecondsSinceEpoch)))),
                                      size: width(context) * 0.12,
                                    ),
                                    SizedBox(
                                      width: width(context) * 0.02,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWid(
                                          text: DateFormat('MMM').format((DateTime
                                              .fromMillisecondsSinceEpoch(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextWid(
                                      text: DateFormat('dd MMM').format(
                                          (DateTime.fromMillisecondsSinceEpoch(
                                              (DateTime.now()
                                                  .millisecondsSinceEpoch)))),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                          // text: sc["name"],
                          text: toBeginningOfSentenceCase(sc["name"].toString())
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
                          text: sc["price"]
                              // toBeginningOfSentenceCase(
                              //         widget.cat["price"].toString())
                              .toString(),
                          weight: FontWeight.w500,
                          size: width(context) * 0.055,
                          color: SpotmiesTheme.onBackground,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: height(context) * 1.3,
                    width: width(context),
                    padding: EdgeInsets.only(
                        top: height(context) * 0.03,
                        left: width(context) * 0.03),
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
                                child: Stack(
                                  children: [
                                    Maps(
                                      isSearch: false,
                                      isNavigate: false,
                                      onSave: () {
                                        // Navigator.of(context).push(MaterialPageRoute(
                                        //   builder: (context) => Maps(),
                                        // ));
                                      },
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        child: Container(
                                          alignment: Alignment.center,
                                          color: SpotmiesTheme.background,
                                          height: height(context) * 0.07,
                                          width: width(context) * 0.8,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButtonWidget(
                                                buttonName: 'My Location',
                                                bgColor:
                                                    SpotmiesTheme.background,
                                                borderSideColor:
                                                    SpotmiesTheme.shadow,
                                                textSize:
                                                    width(context) * 0.035,
                                                textColor:
                                                    SpotmiesTheme.primary,
                                                borderRadius: 5.0,
                                                onClick: () {
                                                  adController
                                                      .getCurrentLocation();
                                                  adController
                                                      .getAddressofLocation();
                                                },
                                                height: height(context) * 0.05,
                                                minWidth: width(context) * 0.35,
                                              ),
                                              ElevatedButtonWidget(
                                                buttonName: 'Change',
                                                bgColor:
                                                    SpotmiesTheme.background,
                                                textColor:
                                                    SpotmiesTheme.primary,
                                                borderSideColor:
                                                    SpotmiesTheme.shadow,
                                                borderRadius: 5.0,
                                                textSize:
                                                    width(context) * 0.035,
                                                height: height(context) * 0.05,
                                                minWidth: width(context) * 0.35,
                                                onClick: () {
                                                  // var add =
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              OnlinePlaceSearch(
                                                                onSave: (cords,
                                                                    fullAddress) {
                                                                  log("cor $cords $fullAddress");
                                                                  adController.updateLocations(
                                                                      cords[
                                                                          'lat'],
                                                                      cords[
                                                                          'log'],
                                                                      fullAddress);
                                                                },
                                                              )));
                                                  // log(add.toString());
                                                },
                                              )
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height(context) * 0.022,
                              ),
                              Container(
                                height: height(context) * 0.5,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            TextWidget(
                                                text: adController
                                                        .fullAddress['latitude']
                                                        .toString() +
                                                    ","),
                                            TextWidget(
                                                text: adController
                                                    .fullAddress['logitude']
                                                    .toString()),
                                          ],
                                        ),
                                        TextWidget(
                                          text: adController
                                                  .fullAddress.isNotEmpty
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
                                        Container(
                                          width: width(context) * 0.8,
                                          // height: height(context) * 0.3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                text: 'More about service',
                                                size: width(context) * 0.06,
                                                align: TextAlign.start,
                                                weight: FontWeight.w500,
                                                color: SpotmiesTheme
                                                    .secondaryVariant,
                                              ),
                                              SizedBox(
                                                height: height(context) * 0.022,
                                              ),
                                              moreText(
                                                  "1. " +
                                                      sc["termsAndConditions"]
                                                          [0],
                                                  context),
                                              moreText(
                                                  "2. " + sc["whatIncluds"][0],
                                                  context),
                                              moreText(
                                                  "3. " +
                                                      sc["whatNotIncluds"][0],
                                                  context),
                                              moreText(
                                                  "4. " + sc["warrantyDetails"],
                                                  context),
                                              moreText(
                                                  "5. " +
                                                      "Warranty valid only " +
                                                      sc["warrantyDays"]
                                                          .toString() +
                                                      " days after service",
                                                  context),
                                              moreText(
                                                  "6. " +
                                                      "Time take to do service is " +
                                                      sc["daysToComplete"]
                                                          .toString() +
                                                      " days and " +
                                                      sc["hoursToComplete"]
                                                          .toString() +
                                                      "hrs",
                                                  context)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ])),
          ),
        ),
      );
    });
  }
}

moreText(text, BuildContext context) {
  return TextWidget(
    text: text,
    size: width(context) * 0.045,
    align: TextAlign.start,
    weight: FontWeight.w500,
    color: SpotmiesTheme.secondaryVariant,
    flow: TextOverflow.visible,
  );
}

// Widget catPost(
//     BuildContext context,
//     AdController adController,
//     UniversalProvider universalProvider,
//     catData,
//     GetOrdersProvider? ordersProvider,
//     user) {
//   return Container(
//       // alignment: Alignment.center,
//       padding: EdgeInsets.only(
//           // left: width(context) * 0.03,
//           // right: width(context) * 0.03,
//           top: width(context) * 0.02),
//       decoration: BoxDecoration(
//           color: SpotmiesTheme.surfaceVariant,
//           borderRadius: BorderRadius.circular(15)),
//       width: width(context),
//       child: Column(children: [
//         AppBar(
//           backgroundColor: Colors.grey[50],
//           elevation: 0,
//           leading: IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: SpotmiesTheme.onBackground,
//               )),
//         ),
//         Container(
//           width: width(context) * 0.82,
//           padding: EdgeInsets.only(
//               left: width(context) * 0.03, top: width(context) * 0.02),
//           child: TextWidget(
//             text: 'Schedule:',
//             color: SpotmiesTheme.secondaryVariant,
//             size: width(context) * 0.04,
//             weight: FontWeight.w600,
//           ),
//         ),
//         InkWell(
//             onTap: () async {
//               await adController.pickDate(context);
//               adController.refresh();
//               await adController.picktime(context);
//               adController.datePickColor = 0;
//               adController.refresh();
//             },
//             child: Container(
//               height: height(context) * 0.1,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                       width: width(context) * 0.45,
//                       // color: Colors.amber[50],
//                       child: Row(
//                         children: [
//                           TextWid(
//                             text: DateFormat('dd').format(
//                                 (DateTime.fromMillisecondsSinceEpoch(
//                                     (adController
//                                         .pickedDate.millisecondsSinceEpoch)))),
//                             size: width(context) * 0.12,
//                           ),
//                           SizedBox(
//                             width: width(context) * 0.02,
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               TextWid(
//                                 text: DateFormat('MMM').format(
//                                     (DateTime.fromMillisecondsSinceEpoch(
//                                         (adController.pickedDate
//                                             .millisecondsSinceEpoch)))),
//                                 weight: FontWeight.w600,
//                               ),
//                               SizedBox(
//                                 height: width(context) * 0.01,
//                               ),
//                               TextWid(
//                                 text: DateFormat('EEEE').format(
//                                     (DateTime.fromMillisecondsSinceEpoch(
//                                         (adController.pickedDate
//                                             .millisecondsSinceEpoch)))),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             width: width(context) * 0.02,
//                           ),
//                           Icon(Icons.calendar_today,
//                               color: SpotmiesTheme.equal,
//                               size: width(context) * 0.06)
//                         ],
//                       )),
//                   SizedBox(
//                     width: width(context) * 0.02,
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       adController.pickedDate = await DateTime.now();
//                       adController.datePickColor = 1;
//                       adController.refresh();
//                     },
//                     child: Container(
//                       height: height(context) * 0.06,
//                       width: width(context) * 0.15,
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                               color: adController.datePickColor == 1
//                                   ? SpotmiesTheme.primary
//                                   : SpotmiesTheme.equal),
//                           borderRadius: BorderRadius.circular(5)),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           TextWid(
//                             text: DateFormat('dd MMM').format(
//                                 (DateTime.fromMillisecondsSinceEpoch(
//                                     (DateTime.now().millisecondsSinceEpoch)))),
//                             weight: FontWeight.w600,
//                             size: width(context) * 0.025,
//                           ),
//                           TextWid(
//                             text: 'Today',
//                             weight: FontWeight.w500,
//                             size: width(context) * 0.025,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: width(context) * 0.02,
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       adController.pickedDate =
//                           await DateTime.now().add(Duration(days: 1));
//                       adController.datePickColor = 2;
//                       adController.refresh();
//                     },
//                     child: Container(
//                       height: height(context) * 0.06,
//                       width: width(context) * 0.15,
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                               color: adController.datePickColor == 2
//                                   ? SpotmiesTheme.primary
//                                   : SpotmiesTheme.equal),
//                           borderRadius: BorderRadius.circular(5)),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           TextWid(
//                             text: DateFormat('dd MMM').format(
//                                 (DateTime.fromMillisecondsSinceEpoch(
//                                     (DateTime.now()
//                                         .add(Duration(days: 1))
//                                         .millisecondsSinceEpoch)))),
//                             weight: FontWeight.w600,
//                             size: width(context) * 0.025,
//                           ),
//                           TextWid(
//                             text: 'Tomorrow',
//                             weight: FontWeight.w500,
//                             size: width(context) * 0.025,
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             )),
//         Container(
//           width: width(context) * 0.8,
//           padding: EdgeInsets.only(left: width(context) * 0.02),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               TextWid(
//                 text: 'Service :',
//                 weight: FontWeight.w600,
//                 size: width(context) * 0.055,
//                 color: SpotmiesTheme.onBackground,
//               ),
//               SizedBox(
//                 width: width(context) * 0.05,
//               ),
//               TextWid(
//                 text: toBeginningOfSentenceCase(catData["name"].toString())
//                     .toString(),
//                 weight: FontWeight.w500,
//                 size: width(context) * 0.055,
//                 color: SpotmiesTheme.onBackground,
//               ),
//             ],
//           ),
//         ),
//         Container(
//           width: width(context) * 0.8,
//           padding: EdgeInsets.only(left: width(context) * 0.02),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               TextWid(
//                 text: 'Price     :',
//                 weight: FontWeight.w600,
//                 size: width(context) * 0.055,
//                 color: SpotmiesTheme.onBackground,
//               ),
//               SizedBox(
//                 width: width(context) * 0.05,
//               ),
//               TextWid(
//                 text: toBeginningOfSentenceCase(catData["price"].toString())
//                     .toString(),
//                 weight: FontWeight.w500,
//                 size: width(context) * 0.055,
//                 color: SpotmiesTheme.onBackground,
//               ),
//             ],
//           ),
//         ),
//         Container(
//           height: height(context) * 1,
//           width: width(context),
//           padding: EdgeInsets.only(
//               top: height(context) * 0.03, left: width(context) * 0.03),
//           child: Column(
//             children: [
//               Container(
//                 height: height(context) * 0.65,
//                 width: width(context) * 0.8,
//                 child: ListView(
//                   physics: NeverScrollableScrollPhysics(),
//                   children: [
//                     TextWidget(
//                       text: 'Choose Service Location',
//                       size: width(context) * 0.06,
//                       align: TextAlign.start,
//                       weight: FontWeight.w500,
//                       color: SpotmiesTheme.secondaryVariant,
//                     ),
//                     SizedBox(
//                       height: height(context) * 0.022,
//                     ),
//                     Container(
//                       height: height(context) * 0.3,
//                       child: Stack(
//                         children: [
//                           Maps(
//                             isSearch: false,
//                             isNavigate: false,
//                             onSave: () {
//                               // Navigator.of(context).push(MaterialPageRoute(
//                               //   builder: (context) => Maps(),
//                               // ));
//                             },
//                           ),
//                           Positioned(
//                               bottom: 0,
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 color: SpotmiesTheme.background,
//                                 height: height(context) * 0.07,
//                                 width: width(context) * 0.8,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     ElevatedButtonWidget(
//                                       buttonName: 'My Location',
//                                       bgColor: SpotmiesTheme.background,
//                                       borderSideColor: SpotmiesTheme.shadow,
//                                       textSize: width(context) * 0.035,
//                                       textColor: SpotmiesTheme.primary,
//                                       borderRadius: 5.0,
//                                       onClick: () {
//                                         adController.getCurrentLocation();
//                                         adController.getAddressofLocation();
//                                       },
//                                       height: height(context) * 0.05,
//                                       minWidth: width(context) * 0.35,
//                                     ),
//                                     ElevatedButtonWidget(
//                                       buttonName: 'Change',
//                                       bgColor: SpotmiesTheme.background,
//                                       textColor: SpotmiesTheme.primary,
//                                       borderSideColor: SpotmiesTheme.shadow,
//                                       borderRadius: 5.0,
//                                       textSize: width(context) * 0.035,
//                                       height: height(context) * 0.05,
//                                       minWidth: width(context) * 0.35,
//                                       onClick: () {
//                                         // var add =
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     OnlinePlaceSearch(
//                                                       onSave:
//                                                           (cords, fullAddress) {
//                                                         log("cor $cords $fullAddress");
//                                                         adController
//                                                             .updateLocations(
//                                                                 cords['lat'],
//                                                                 cords['log'],
//                                                                 fullAddress);
//                                                       },
//                                                     )));
//                                         // log(add.toString());
//                                       },
//                                     )
//                                   ],
//                                 ),
//                               ))
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: height(context) * 0.022,
//                     ),
//                     Container(
//                       height: height(context) * 0.3,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   TextWidget(
//                                       text: adController.fullAddress['latitude']
//                                               .toString() +
//                                           ","),
//                                   TextWidget(
//                                       text: adController.fullAddress['logitude']
//                                           .toString()),
//                                 ],
//                               ),
//                               TextWidget(
//                                 text: adController.fullAddress.isNotEmpty
//                                     ? '${adController.fullAddress['name']},${adController.fullAddress['street']}, ${adController.fullAddress['subLocality']}, ${adController.fullAddress['locality']}, ${adController.fullAddress['subAdminArea']}, ${adController.fullAddress['adminArea']}, ${adController.fullAddress['postalCode']}, ${adController.fullAddress['isoCountryCode']}'
//                                         .toString()
//                                     : "Unable to Get your Location",
//                                 size: width(context) * 0.04,
//                                 flow: TextOverflow.visible,
//                                 weight: FontWeight.w500,
//                                 color: SpotmiesTheme.secondaryVariant,
//                               ),
//                               SizedBox(
//                                 height: height(context) * 0.03,
//                               ),
//                               // Container(
//                               //   width: width(context) * 0.8,
//                               //   child: Column(
//                               //     crossAxisAlignment: CrossAxisAlignment.start,
//                               //     children: [
//                               //       TextWidget(
//                               //         text: 'More about service',
//                               //         size: width(context) * 0.06,
//                               //         align: TextAlign.start,
//                               //         weight: FontWeight.w500,
//                               //         color: SpotmiesTheme.secondaryVariant,
//                               //       ),
//                               //       SizedBox(
//                               //         height: height(context) * 0.022,
//                               //       ),
//                               //       TextWidget(
//                               //         text: 'More about service',
//                               //         size: width(context) * 0.045,
//                               //         align: TextAlign.start,
//                               //         weight: FontWeight.w500,
//                               //         color: SpotmiesTheme.secondaryVariant,
//                               //       ),
//                               //     ],
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: height(context) * 0.1,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ElevatedButtonWidget(
//                       onClick: () {
//                         adController.sliderKey.currentState?.previous();
//                       },
//                       buttonName: 'Back',
//                       bgColor: Colors.indigo[50],
//                       borderSideColor: Colors.indigo[50],
//                       textColor: Colors.indigo[900],
//                       height: height(context) * 0.05,
//                       minWidth: width(context) * 0.30,
//                       textSize: height(context) * 0.02,
//                       leadingIcon: Icon(
//                         Icons.arrow_back_ios,
//                         size: height(context) * 0.015,
//                         color: Colors.indigo[900],
//                       ),
//                       borderRadius: 10.0,
//                     ),
//                     ElevatedButtonWidget(
//                       onClick: () async {
//                         await adController.catFinish(
//                             user, context, ordersProvider!,
//                             catData: catData);
//                       },
//                       buttonName: 'Finish',
//                       bgColor: SpotmiesTheme.primary,
//                       borderSideColor: SpotmiesTheme.primary,
//                       textColor: Colors.white,
//                       height: height(context) * 0.05,
//                       minWidth: width(context) * 0.60,
//                       textSize: height(context) * 0.02,
//                       trailingIcon: Icon(
//                         Icons.arrow_forward_ios,
//                         size: height(context) * 0.015,
//                       ),
//                       borderRadius: 10.0,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ]));
// }

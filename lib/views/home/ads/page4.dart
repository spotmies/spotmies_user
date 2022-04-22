import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spotmies/controllers/home_controllers/ad_controll.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/media_player.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/home/ads/page2.dart';
import 'package:spotmies/views/maps/offLine_placesModel.dart';
import 'package:spotmies/views/maps/onLine_placesSearch.dart';
import 'package:spotmies/views/reusable_widgets/steps.dart';

Widget page4(
    double hight,
    double width,
    user,
    AdController adController,
    BuildContext context,
    GetOrdersProvider? ordersProvider,
    UniversalProvider? up) {
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
          height: height(context),
          width: width,
          padding: EdgeInsets.only(top: hight * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/icons/review.png",
                height: height(context) * 0.3,
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: width * 0.05,
                ),
                height: hight * 0.06,
                width: width * 0.8,
                child: Center(
                  child: steps(4, width),
                ),
              ),
              Container(
                height: hight * 0.45,
                width: width * 0.87,
                child: ListView(
                  children: [
                    TextWidget(
                      text: 'Review',
                      size: width * 0.06,
                      align: TextAlign.center,
                      weight: FontWeight.w800,
                      color: SpotmiesTheme.secondaryVariant,
                    ),
                    SizedBox(
                      height: hight * 0.022,
                    ),
                    Container(
                      width: double.infinity,
                      height: hight * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TitleAndText(
                            "Category",
                            text: up
                                ?.getCategoryMainList()
                                .map((services) =>
                                    (services["nameOfService"] as String?))
                                .elementAt(adController.dropDownValue ?? 0),
                          ),
                          TitleAndText(
                            "Problem",
                            text: adController.title.toString(),
                          ),
                          TitleAndText(
                            "Scheduled",
                            text: DateFormat('EEE, dd MMM yyyy')
                                .format(adController.pickedDate),
                          ),
                          Divider(),
                          TextWidget(
                            text: "Media",
                            weight: FontWeight.bold,
                            size: height(context) * 0.025,
                          ),
                          Column(
                            children: [
                              Container(
                                height: hight * 0.15,
                                width: width * 1,
                                child: GridView.builder(
                                    itemCount:
                                        adController.serviceImages.length + 1,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 3.5,
                                            crossAxisSpacing: 3.5,
                                            crossAxisCount: 4),
                                    itemBuilder: (context, index) {
                                      // String type =  _adController.serviceImages[index].toString();

                                      return index == 0
                                          ? Center(
                                              child: IconButton(
                                                  icon: Icon(Icons.add),
                                                  onPressed: () {
                                                    return !adController
                                                            .uploading
                                                        ? adController
                                                            .chooseImage()
                                                        : null;
                                                  }),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MediaPlayer(
                                                              mediaList: [
                                                                adController
                                                                        .serviceImagesStrings[
                                                                    index - 1]
                                                              ],
                                                              isOnlinePlayer:
                                                                  false,
                                                            )));
                                              },
                                              child: Stack(children: [
                                                mediaContent(adController
                                                    .serviceImages[index - 1]),
                                                Positioned(
                                                    right: 0,
                                                    top: 0,
                                                    child: InkWell(
                                                        onTap: () {
                                                          adController
                                                              .serviceImages
                                                              .removeAt(
                                                                  index - 1);
                                                          adController
                                                              .serviceImagesStrings
                                                              .removeAt(
                                                                  index - 1);
                                                          adController
                                                              .refresh();
                                                        },
                                                        child: Icon(
                                                          Icons.close,
                                                          size: width * 0.05,
                                                          color: Colors.white,
                                                        )))
                                              ]),
                                            );
                                    }),
                              ),
                            ],
                          ),
                          Divider(),
                          TitleAndText(
                            "Address",
                            text: adController.fullAddress.isNotEmpty
                                ? '${adController.fullAddress['name']},${adController.fullAddress['street']}, ${adController.fullAddress['subLocality']}, ${adController.fullAddress['locality']}, ${adController.fullAddress['subAdminArea']}, ${adController.fullAddress['adminArea']}, ${adController.fullAddress['postalCode']}, ${adController.fullAddress['isoCountryCode']}'
                                    .toString()
                                : "Unable to Get your Location",
                          ),
                          SizedBox(
                            height: hight * 0.03,
                          ),
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
                        await adController.step4(
                            user, context, ordersProvider!);
                      },
                      buttonName: 'Finish',
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

class TitleAndText extends StatelessWidget {
  final String title;
  final String? text;
  const TitleAndText(this.title, {Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = height(context) * 0.025;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: "$title:",
          weight: FontWeight.bold,
          size: size,
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          child: TextWidget(
            text: text ?? "N/A",
            color: SpotmiesTheme.secondaryVariant,
            flow: TextOverflow.visible,
            size: size,
          ),
        ),
      ],
    );
  }
}

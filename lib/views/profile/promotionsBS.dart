import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/fonts.dart';

Future promotions(BuildContext context, double hight, double width) {
  return showModalBottomSheet(
      context: context,
      elevation: 22,
      isScrollControlled: true,
      backgroundColor: SpotmiesTheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: hight * 0.8,
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 30),
                  height: hight * 0.22,
                  child: SvgPicture.asset('assets/promo.svg')),
              Container(
                height: hight * 0.4,
                margin: EdgeInsets.only(
                  top: 20,
                ),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Container(
                          width: width * 0.7,
                          margin: EdgeInsets.only(
                              top: 20, bottom: 10, left: 20, right: 10),
                          decoration: BoxDecoration(),
                          child: Stack(children: [
                            DottedBorder(
                              dashPattern: [6, 3, 2, 3],
                              color: SpotmiesTheme.onBackground,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(30),
                              padding: EdgeInsets.all(0),
                              strokeWidth: 1,
                              child: Container(
                                  height: hight * 0.4,
                                  width: width * 0.7,
                                  padding: EdgeInsets.only(
                                      top: 20, left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'SUPERSUNDAYS',
                                        style: fonts(
                                            width * 0.06,
                                            FontWeight.w600,
                                            SpotmiesTheme.secondaryVariant),
                                      ),
                                      Container(
                                        // height: hight * 0.2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Icon(Icons.anchor),
                                            ),
                                            Text(
                                              'Offer Valid Only on Sundays of The Month of July \n Offer Valid Twice per User in a Month \n After Apply and Cancel Service Offer May Not be Work',
                                              textAlign: TextAlign.center,
                                              style: fonts(
                                                  width * 0.04,
                                                  FontWeight.w500,
                                                  SpotmiesTheme
                                                      .secondaryVariant),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            size: width * 0.04,
                                          ),
                                          Text(
                                            'Terms and Conditions Applied',
                                            textAlign: TextAlign.center,
                                            style: fonts(
                                                width * 0.03,
                                                FontWeight.w500,
                                                SpotmiesTheme.secondaryVariant),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                            Positioned(
                                bottom: 0, right: 0, child: Icon(Icons.cut)),
                            Positioned(
                                top: 5,
                                left: 5,
                                child: Icon(
                                  Icons.local_offer,
                                  color:
                                      ([...Colors.primaries]..shuffle()).first,
                                ))
                          ]));
                    }),
              ),
              SizedBox(
                height: hight * 0.03,
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: ElevatedButtonWidget(
                  bgColor: Colors.indigo[50],
                  minWidth: width * 0.9,
                  height: hight * 0.06,
                  textColor: Colors.grey[900],
                  buttonName: 'Close',
                  textSize: width * 0.05,
                  textStyle: FontWeight.w600,
                  borderRadius: height(context) * 0.015,
                  borderSideColor: Colors.indigo[50],
                  onClick: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      });
}

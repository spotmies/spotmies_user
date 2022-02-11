import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/providers/localization_provider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/fonts.dart';

void settings(BuildContext context, double hight, double width) async {
  var activeLanguageButtonColor = Colors.grey[900];
  var activeLanguageTextColor = Colors.white;
  var inactiveLanguageButtonColor = Colors.indigo[50];
  var inactiveLanguageTextColor = Colors.grey[900];
  var language = -1;
  return showModalBottomSheet(
      context: context,
      elevation: 22,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        language = context.locale == Locale("en", "US")
            ? 0
            : context.locale == Locale("te", "IN")
                ? 1
                : 2;
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Container(
            decoration: BoxDecoration(
              color: SpotmiesTheme.background,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            height: hight * 0.7,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 30),
                    height: hight * 0.22,
                    child: SvgPicture.asset('assets/settings.svg')),
                SizedBox(
                  height: hight * 0.02,
                ),
                Container(
                  // padding: EdgeInsets.all(15),
                  height: hight * 0.17,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Select Light Modes',
                          style: fonts(width * 0.05, FontWeight.w700,
                              SpotmiesTheme.secondaryVariant),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .setThemeMode(ThemeMode.light);
                              });
                            },
                            child: Container(
                              width: width * 0.4,
                              height: hight * 0.06,
                              decoration: BoxDecoration(
                                  color: Colors.indigo[50],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.light_mode),
                                  Text(
                                    'Light Mode',
                                    style: fonts(width * 0.04, FontWeight.w700,
                                        Colors.grey[900]),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .setThemeMode(ThemeMode.dark);
                              });
                            },
                            child: Container(
                              width: width * 0.4,
                              height: hight * 0.06,
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Dark Mode',
                                    style: fonts(width * 0.04, FontWeight.w700,
                                        Colors.white),
                                  ),
                                  Icon(
                                    Icons.dark_mode,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(15),
                  height: hight * 0.17,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Choose Your Language',
                          style: fonts(width * 0.05, FontWeight.w700,
                              SpotmiesTheme.secondaryVariant),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                print("Button Pressed: English");
                                Provider.of<LocalizationProvider>(context,
                                        listen: false)
                                    .setLocalizationMode(0);
                                language = 0;
                              });
                            },
                            child: Container(
                              width: width * 0.3,
                              height: hight * 0.045,
                              decoration: BoxDecoration(
                                  color: language == 0
                                      ? activeLanguageButtonColor
                                      : inactiveLanguageButtonColor,
                                  borderRadius: BorderRadius.circular(
                                      height(context) * 0.014)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'English',
                                    style: fonts(
                                        width * 0.04,
                                        FontWeight.w700,
                                        language == 0
                                            ? activeLanguageTextColor
                                            : inactiveLanguageTextColor),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print("Button Pressed: Telugu");
                              setState(() {
                                Provider.of<LocalizationProvider>(context,
                                        listen: false)
                                    .setLocalizationMode(1);
                                language = 1;
                              });
                            },
                            child: Container(
                              width: width * 0.3,
                              height: hight * 0.045,
                              decoration: BoxDecoration(
                                  color: language == 1
                                      ? activeLanguageButtonColor
                                      : inactiveLanguageButtonColor,
                                  borderRadius: BorderRadius.circular(
                                      height(context) * 0.014)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'తెలుగు',
                                    style: fonts(
                                        width * 0.04,
                                        FontWeight.w700,
                                        language == 1
                                            ? activeLanguageTextColor
                                            : inactiveLanguageTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print("Button Pressed: Hindi");
                              setState(() {
                                Provider.of<LocalizationProvider>(context,
                                        listen: false)
                                    .setLocalizationMode(2);
                                language == 2;
                              });
                            },
                            child: Container(
                              width: width * 0.3,
                              height: hight * 0.045,
                              decoration: BoxDecoration(
                                  color: language == 2
                                      ? activeLanguageButtonColor
                                      : inactiveLanguageButtonColor,
                                  borderRadius: BorderRadius.circular(
                                      height(context) * 0.014)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'हिंदी',
                                    style: fonts(
                                        width * 0.04,
                                        FontWeight.w700,
                                        language == 2
                                            ? activeLanguageTextColor
                                            : inactiveLanguageTextColor),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
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
      });
}

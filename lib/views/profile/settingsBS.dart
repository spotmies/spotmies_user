import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/fonts.dart';

void settings(BuildContext context, double hight, double width) async {
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
        return Container(
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
                        style: fonts(
                            width * 0.05, FontWeight.w700, Colors.grey[900]),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .setThemeMode(ThemeMode.light);
                          },
                          child: Container(
                            width: width * 0.4,
                            height: hight * 0.06,
                            decoration: BoxDecoration(
                                color: Colors.indigo[50],
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            Provider.of<ThemeProvider>(context, listen: false)
                                .setThemeMode(ThemeMode.dark);
                          },
                          child: Container(
                            width: width * 0.4,
                            height: hight * 0.06,
                            decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        'Choose Your Languege',
                        style: fonts(
                            width * 0.05, FontWeight.w700, Colors.grey[900]),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: width * 0.3,
                          height: hight * 0.045,
                          decoration: BoxDecoration(
                              color: Colors.indigo[50],
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'English',
                                style: fonts(width * 0.04, FontWeight.w700,
                                    Colors.grey[900]),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: width * 0.3,
                          height: hight * 0.045,
                          decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'తెలుగు',
                                style: fonts(width * 0.04, FontWeight.w700,
                                    Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: width * 0.3,
                          height: hight * 0.045,
                          decoration: BoxDecoration(
                              color: Colors.indigo[50],
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'हिंदी',
                                style: fonts(width * 0.04, FontWeight.w700,
                                    Colors.grey[900]),
                              )
                            ],
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
                  minWidth: width,
                  height: hight * 0.06,
                  textColor: Colors.grey[900],
                  buttonName: 'Close',
                  textSize: width * 0.05,
                  textStyle: FontWeight.w600,
                  borderRadius: 5.0,
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

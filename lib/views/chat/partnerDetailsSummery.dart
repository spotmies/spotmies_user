import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spotmies/controllers/chat_controllers/responsive_controller.dart';
import 'package:spotmies/utilities/constants.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/internet_calling/calling.dart';
import 'package:spotmies/views/reusable_widgets/bottom_options_menu.dart';
import 'package:url_launcher/url_launcher.dart';

Future partnerDetailsSummury(
    BuildContext context,
    double hight,
    double width,
    pDetails,
    ResponsiveController _responsiveController,
    responseData,
    chatWithPatner,
    {onClick}) {
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
        log(pDetails.toString());
        return Container(
          height: hight * 0.33,
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: hight * 0.06,
                        child: ClipOval(
                          child: Image.network(pDetails['partnerPic'],
                              width: width * 0.4,
                              height: width * 0.4,
                              fit: BoxFit.fitHeight),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.07,
                      ),
                      Container(
                        height: hight * 0.11,
                        width: width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    TextWidget(
                                      text: toBeginningOfSentenceCase(
                                        pDetails['name'],
                                      ),
                                      size: width * 0.04,
                                      weight: FontWeight.w600,
                                      color: Colors.grey[900],
                                    )
                                  ],
                                ),
                                Container(
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text: _responsiveController.jobs
                                                .elementAt(pDetails['job']) +
                                            ' | ',
                                        size: width * 0.025,
                                        weight: FontWeight.w600,
                                        color: Colors.grey[700],
                                      ),
                                      TextWidget(
                                        // text: pDetails['rate'][0].toString(),
                                        text: '4.5',
                                        size: width * 0.025,
                                        weight: FontWeight.w600,
                                        color: Colors.grey[700],
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: width * 0.025,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    'Telugu | ',
                                    style: fonts(width * 0.03, FontWeight.w600,
                                        Colors.grey[900]),
                                  ),
                                  Text(
                                    'English | ',
                                    style: fonts(width * 0.03, FontWeight.w600,
                                        Colors.grey[900]),
                                  ),
                                  Text(
                                    'Hindi',
                                    style: fonts(width * 0.03, FontWeight.w600,
                                        Colors.grey[900]),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: width * 0.45,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_pin,
                                    size: width * 0.03,
                                  ),
                                  Text(
                                    'Vizag',
                                    style: fonts(width * 0.03, FontWeight.w600,
                                        Colors.grey[900]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      bottomOptionsMenu(context,
                          options: Constants.bottomSheetOptionsForCalling,
                          option1Click: () {
                        launch("tel://${pDetails['phNum']}");
                      }, option2Click: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyCalling(
                                  ordId: responseData['ordId'].toString(),
                                  uId: FirebaseAuth.instance.currentUser.uid
                                      .toString(),
                                  pId: responseData['pId'].toString(),
                                  isIncoming: false,
                                  name: pDetails['name'].toString(),
                                  profile: pDetails['partnerPic'].toString(),
                                  partnerDeviceToken:
                                      pDetails['partnerDeviceToken'].toString(),
                                )));
                      });
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: width * 0.06,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.call,
                            color: Colors.grey[900],
                            size: width * 0.05,
                          ),
                        ),
                        SizedBox(
                          height: hight * 0.01,
                        ),
                        TextWidget(
                          text: 'Call',
                          size: width * 0.04,
                          weight: FontWeight.w600,
                          color: Colors.grey[900],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      chatWithPatner(responseData);
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: width * 0.06,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.chat_bubble,
                            color: Colors.grey[900],
                            size: width * 0.05,
                          ),
                        ),
                        SizedBox(
                          height: hight * 0.01,
                        ),
                        TextWidget(
                          text: 'Message',
                          size: width * 0.04,
                          weight: FontWeight.w600,
                          color: Colors.grey[900],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: hight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButtonWidget(
                    minWidth: width * 0.3,
                    height: hight * 0.05,
                    bgColor: Colors.indigo[50],
                    buttonName: 'Close',
                    textColor: Colors.grey[900],
                    borderRadius: 15.0,
                    textSize: width * 0.04,
                    leadingIcon: Icon(
                      Icons.clear,
                      size: width * 0.04,
                      color: Colors.grey[900],
                    ),
                    borderSideColor: Colors.indigo[50],
                    onClick: () {
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButtonWidget(
                    minWidth: width * 0.5,
                    height: hight * 0.05,
                    bgColor: Colors.indigo[900],
                    onClick: onClick,
                    buttonName: 'orderDetails',
                    textColor: Colors.white,
                    borderRadius: 15.0,
                    textSize: width * 0.04,
                    trailingIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: width * 0.03,
                      color: Colors.white,
                    ),
                    borderSideColor: Colors.indigo[900],
                  )
                ],
              )
            ],
          ),
        );
      });
}

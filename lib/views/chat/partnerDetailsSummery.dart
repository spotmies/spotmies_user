import 'package:flutter/material.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/fonts.dart';

Future partnerDetailsSummury(BuildContext context, double hight, double width) {
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
                          child: Image.network(
                              "https://pbs.twimg.com/media/Ey0G0DYU8AEr1D5.jpg",
                              width: width * 0.4,
                              fit: BoxFit.fill),
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
                                    Text(
                                      'Satish Kumar Saride',
                                      style: fonts(width * 0.04,
                                          FontWeight.w600, Colors.grey[900]),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Interial Designer | ',
                                        style: fonts(width * 0.025,
                                            FontWeight.w600, Colors.grey[700]),
                                      ),
                                      Text(
                                        'Rating:4.5',
                                        style: fonts(width * 0.025,
                                            FontWeight.w600, Colors.grey[700]),
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
                  Row(
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
                      Text(
                        'Call',
                        style: fonts(
                            width * 0.04, FontWeight.w600, Colors.grey[900]),
                      ),
                    ],
                  ),
                  Row(
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
                      Text(
                        'Message',
                        style: fonts(
                            width * 0.04, FontWeight.w600, Colors.grey[900]),
                      ),
                    ],
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
                    buttonName: 'See More',
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
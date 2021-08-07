import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/fonts.dart';

Future helpAndSupport(BuildContext context, double hight, double width) {
  List names = ['FAQ', 'Chat', 'Contact'];
  List icons = [Icons.question_answer, Icons.chat, Icons.support_agent];
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
            height: hight * 0.65,
            child: Column(children: [
              Container(
                  padding: EdgeInsets.only(top: 30),
                  height: hight * 0.22,
                  child: SvgPicture.asset('assets/help.svg')),
              Container(
                padding:
                    EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
                child: Text(
                  'Need Some Help?',
                  style: fonts(width * 0.06, FontWeight.w600, Colors.grey[900]),
                ),
              ),
              Container(
                height: hight * 0.15,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              icons[0],
                              size: width * 0.15,
                              color: Colors.grey[400],
                            ),
                          ),
                          Text(
                            names[0],
                            style: fonts(width * 0.04, FontWeight.w600,
                                Colors.grey[900]),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              icons[1],
                              size: width * 0.15,
                              color: Colors.grey[400],
                            ),
                          ),
                          Text(
                            names[1],
                            style: fonts(width * 0.04, FontWeight.w600,
                                Colors.grey[900]),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              icons[2],
                              size: width * 0.15,
                              color: Colors.grey[400],
                            ),
                          ),
                          Text(
                            names[2],
                            style: fonts(width * 0.04, FontWeight.w600,
                                Colors.grey[900]),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: hight * 0.07,
                child: Center(
                  child: Text(
                    'Tap to Select Any Option',
                    style:
                        fonts(width * 0.05, FontWeight.w400, Colors.grey[500]),
                  ),
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
            ]));
      });
}

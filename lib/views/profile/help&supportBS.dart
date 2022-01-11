import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmies/controllers/profile_controllers/profile_controller.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/views/profile/help/faq.dart';
import 'package:spotmies/views/reusable_widgets/queryBS.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';
import 'package:url_launcher/url_launcher.dart';

Future helpAndSupport(BuildContext context, double hight, double width,
    ProfileController profileController, uDetailsId) {
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
            height: hight * 0.68,
            padding: EdgeInsets.only(top: height(context) * 0.03),
            child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: width * 0.25,
                      child: TextWid(
                        text: 'How do you want to reach us?',
                        size: width * 0.075,
                        lSpace: height(context) * 0.0017,
                        weight: FontWeight.w600,
                        flow: TextOverflow.visible,
                        align: TextAlign.start,
                      ),
                    ),
                    Container(
                        height: hight * 0.2,
                        width: width * 0.55,
                        child: SvgPicture.asset('assets/help.svg')),
                  ],
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
                  child: TextWid(
                    text:
                        'If you need any help,you can reach us through below options',
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
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              FAQ(profileController)));
                                },
                                icon: Icon(
                                  icons[0],
                                  size: width * 0.06,
                                  color: Colors.grey[900],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height(context) * 0.01,
                            ),
                            TextWid(
                              text: names[0],
                              // style: fonts(width * 0.04, FontWeight.w600,
                              //     Colors.grey[900]),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  // Navigator.pop(context);
                                  newQueryBS(context,
                                      onSubmit: (String output) {
                                    profileController.submitQuery(
                                        output, uDetailsId, context,
                                        suggestionFor: "feedback");
                                  });
                                },
                                icon: Icon(
                                  icons[1],
                                  size: width * 0.06,
                                  color: Colors.grey[900],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height(context) * 0.01,
                            ),
                            TextWid(
                              text: names[1],
                              // style: fonts(width * 0.04, FontWeight.w600,
                              //     Colors.grey[900]),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  launch('tel:+918341980196');
                                },
                                icon: Icon(
                                  icons[2],
                                  size: width * 0.06,
                                  color: Colors.grey[900],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height(context) * 0.01,
                            ),
                            TextWid(
                              text: names[2],
                              // style: fonts(width * 0.04, FontWeight.w600,
                              //     Colors.grey[900]),
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
                    child: TextWid(
                      text: 'Tap to Select Any Option',
                      // style: fonts(
                      //     width * 0.05, FontWeight.w400, Colors.grey[500]),
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
              ]),
            ));
      });
}

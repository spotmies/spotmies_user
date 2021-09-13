import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/views/login/loginpage.dart';

Future signOut(BuildContext context, double hight, double width) {
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
          height: hight * 0.45,
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 30),
                  height: hight * 0.22,
                  child: SvgPicture.asset('assets/exit.svg')),
              Container(
                height: hight * 0.06,
                child: Center(
                  child: Text(
                    'Are Sure, You Want to Leave the App?',
                    style:
                        fonts(width * 0.04, FontWeight.w600, Colors.grey[900]),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: ElevatedButtonWidget(
                    bgColor: Colors.indigo[900],
                    minWidth: width,
                    height: hight * 0.06,
                    textColor: Colors.white,
                    buttonName: 'Yes ,I Want to Leave',
                    textSize: width * 0.05,
                    textStyle: FontWeight.w600,
                    borderRadius: 5.0,
                    borderSideColor: Colors.indigo[900],
                    // trailingIcon: Icon(Icons.share),
                    onClick: () async {
                      await FirebaseAuth.instance.signOut().then((action) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => LoginPageScreen()),
                            (route) => false);
                      }).catchError((e) {
                        print(e);
                      });
                    }),
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

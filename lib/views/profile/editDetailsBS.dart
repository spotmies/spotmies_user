import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/utilities/textFormFieldWidget.dart';

List<Map<String, Object>> data = [
  {
    "name": "prabhas uppalapati",
    "email": "prabhasuppalapati@gmail.com",
    "mobile": "8019933883",
    "orders": 24,
    "savings": 1284,
  },
];

Future editDetails(BuildContext context, double hight, double width) {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  var nameformkey = GlobalKey<FormState>();
  var emailformkey = GlobalKey<FormState>();
  var mobileformkey = GlobalKey<FormState>();
  return showModalBottomSheet(
      context: context,
      elevation: 22,
      isScrollControlled: true,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: MediaQuery.of(context).viewInsets,
          height: hight * 0.9,
          child: ListView(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 30),
                  height: hight * 0.22,
                  child: SvgPicture.asset('assets/edit.svg')),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Edit Profile',
                  style: fonts(width * 0.05, FontWeight.w600, Colors.grey[900]),
                ),
              ),
              Container(
                  height: hight * 0.55,
                  padding: EdgeInsets.only(top: 20),
                  child: ListView(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          topLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: ExpansionTile(
                          backgroundColor: Colors.white,
                          collapsedBackgroundColor: Colors.grey[100],
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.text_format),
                            ],
                          ),
                          textColor: Colors.indigo[900],
                          iconColor: Colors.indigo[900],
                          collapsedIconColor: Colors.grey[900],
                          collapsedTextColor: Colors.grey[900],
                          title: Text(
                            data[0]['name'].toString(),
                            style: GoogleFonts.josefinSans(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            'Tap on Change Button to Edit',
                            style: GoogleFonts.josefinSans(
                              // color: Colors.white,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          children: [
                            Form(
                                key: nameformkey,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      child: TextFieldWidget(
                                        controller: nameController,
                                        hint: 'Name',
                                        enableBorderColor: Colors.grey,
                                        focusBorderColor: Colors.indigo[900],
                                        enableBorderRadius: 15,
                                        focusBorderRadius: 15,
                                        errorBorderRadius: 15,
                                        focusErrorRadius: 15,
                                        validateMsg: 'Enter Valid Name',
                                        maxLines: 1,
                                        postIcon: Icon(Icons.change_circle),
                                        postIconColor: Colors.indigo[900],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: ElevatedButtonWidget(
                                        bgColor: Colors.indigo[900],
                                        minWidth: width,
                                        height: hight * 0.07,
                                        textColor: Colors.white,
                                        buttonName: 'Change',
                                        trailingIcon: Icon(Icons.update),
                                        onClick: () {
                                          if (nameformkey.currentState
                                              .validate()) {
                                            log(nameController.text);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )),
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          topLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: ExpansionTile(
                          backgroundColor: Colors.white,
                          collapsedBackgroundColor: Colors.grey[100],
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.email)],
                          ),
                          trailing: Icon(Icons.edit),
                          textColor: Colors.indigo[900],
                          iconColor: Colors.indigo[900],
                          collapsedIconColor: Colors.grey[900],
                          collapsedTextColor: Colors.grey[900],
                          title: Text(
                            data[0]['email'].toString(),
                            style: GoogleFonts.josefinSans(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            'Tap on Change Button to Edit',
                            style: GoogleFonts.josefinSans(
                              // color: Colors.white,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          children: [
                            Form(
                                key: emailformkey,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      child: TextFieldWidget(
                                        controller: emailController,
                                        hint: 'Email',
                                        enableBorderColor: Colors.grey,
                                        focusBorderColor: Colors.indigo[900],
                                        enableBorderRadius: 15,
                                        focusBorderRadius: 15,
                                        errorBorderRadius: 15,
                                        focusErrorRadius: 15,
                                        validateMsg: 'Enter Valid Name',
                                        maxLines: 1,
                                        postIcon: Icon(Icons.change_circle),
                                        postIconColor: Colors.indigo[900],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: ElevatedButtonWidget(
                                        bgColor: Colors.indigo[900],
                                        minWidth: width,
                                        height: hight * 0.07,
                                        textColor: Colors.white,
                                        buttonName: 'Change',
                                        trailingIcon: Icon(Icons.update),
                                        onClick: () {
                                          if (emailformkey.currentState
                                              .validate()) {
                                            log(emailController.text);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )),
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          topLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: ExpansionTile(
                          backgroundColor: Colors.white,
                          collapsedBackgroundColor: Colors.grey[100],
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.phone_android),
                            ],
                          ),
                          textColor: Colors.indigo[900],
                          iconColor: Colors.indigo[900],
                          collapsedIconColor: Colors.grey[900],
                          collapsedTextColor: Colors.grey[900],
                          title: Text(
                            data[0]['mobile'].toString(),
                            style: GoogleFonts.josefinSans(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            'Tap on Change Button to Edit',
                            style: GoogleFonts.josefinSans(
                              // color: Colors.white,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          children: [
                            Form(
                                key: mobileformkey,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      child: TextFieldWidget(
                                        controller: mobileNoController,
                                        hint: 'Mobile',
                                        enableBorderColor: Colors.grey,
                                        focusBorderColor: Colors.indigo[900],
                                        enableBorderRadius: 15,
                                        focusBorderRadius: 15,
                                        errorBorderRadius: 15,
                                        focusErrorRadius: 15,
                                        validateMsg: 'Enter Valid Name',
                                        maxLines: 1,
                                        postIcon: Icon(Icons.change_circle),
                                        postIconColor: Colors.indigo[900],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: ElevatedButtonWidget(
                                        bgColor: Colors.indigo[900],
                                        minWidth: width,
                                        height: hight * 0.07,
                                        textColor: Colors.white,
                                        buttonName: 'Change',
                                        trailingIcon: Icon(Icons.update),
                                        onClick: () {
                                          if (mobileformkey.currentState
                                              .validate()) {
                                            log(mobileNoController.text);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )),
                  ])),
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

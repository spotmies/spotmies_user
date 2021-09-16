import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/utilities/textFormFieldWidget.dart';
import 'package:spotmies/views/profile/profile.dart';
import 'package:spotmies/views/profile/profilePic.dart';

Future editDetails(BuildContext context, {details}) {
  final _width = MediaQuery.of(context).size.width;
  final _hight = MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      kToolbarHeight;
  log(details.toString());
  TextEditingController nameController =
      TextEditingController(text: details['name'].toString());
  TextEditingController emailController =
      TextEditingController(text: details['eMail'].toString());
  TextEditingController mobileNoController =
      TextEditingController(text: details['altNum'].toString());
  var nameformkey = GlobalKey<FormState>();
  var emailformkey = GlobalKey<FormState>();
  var mobileformkey = GlobalKey<FormState>();
  void submitChange() {
    var body = {
      "name": nameController.text,
      "eMail": emailController.text,
      "altNum": mobileNoController.text,
      "pic": ""
    };
    print(body);
  }

  pickImage() async {
    final pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 10,
        preferredCameraDevice: CameraDevice.rear);
    // setState(() {
    //   serviceImages.add(File(pickedFile?.path));
    // });
    // if (pickedFile.path == null) retrieveLostData();
  }

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
          height: _hight * 0.9,
          child: ListView(
            children: [
              // profilePic(context, details['pic'], onClick: pickImage),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Edit Profile',
                  style:
                      fonts(_width * 0.05, FontWeight.w600, Colors.grey[900]),
                ),
              ),
              Container(
                  height: _hight * 0.55,
                  padding: EdgeInsets.only(top: 20),
                  child: ListView(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          topLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Form(
                            key: nameformkey,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  child: TextFieldWidget(
                                    controller: nameController,
                                    hint: 'Enter your name Here',
                                    label: "Name",
                                    enableBorderColor: Colors.grey,
                                    focusBorderColor: Colors.indigo[900],
                                    enableBorderRadius: 15,
                                    focusBorderRadius: 15,
                                    errorBorderRadius: 15,
                                    focusErrorRadius: 15,
                                    validateMsg: 'Enter Valid Name',
                                    maxLines: 1,
                                    postIcon: Icon(Icons.edit),
                                    postIconColor: Colors.indigo[900],
                                  ),
                                ),
                              ],
                            ))),
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          topLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Form(
                            key: emailformkey,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  child: TextFieldWidget(
                                    controller: emailController,
                                    hint: 'Enter your Email Here',
                                    label: "Email",
                                    enableBorderColor: Colors.grey,
                                    focusBorderColor: Colors.indigo[900],
                                    enableBorderRadius: 15,
                                    focusBorderRadius: 15,
                                    errorBorderRadius: 15,
                                    focusErrorRadius: 15,
                                    validateMsg: 'Enter Valid Name',
                                    maxLines: 1,
                                    postIcon: Icon(Icons.email_rounded),
                                    postIconColor: Colors.indigo[900],
                                  ),
                                ),
                              ],
                            ))),
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          topLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Form(
                            key: mobileformkey,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  child: TextFieldWidget(
                                    maxLength: 10,
                                    formatter: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    controller: mobileNoController,
                                    hint: 'Alternative',
                                    enableBorderColor: Colors.grey,
                                    focusBorderColor: Colors.indigo[900],
                                    enableBorderRadius: 15,
                                    focusBorderRadius: 15,
                                    errorBorderRadius: 15,
                                    focusErrorRadius: 15,
                                    validateMsg: 'Enter Valid Name',
                                    maxLines: 1,
                                    label: "Alternative Number",
                                    postIcon: Icon(Icons.phone),
                                    postIconColor: Colors.indigo[900],
                                  ),
                                ),
                              ],
                            ))),
                  ])),
              Container(
                padding: EdgeInsets.all(5),
                child: ElevatedButtonWidget(
                  bgColor: Colors.indigo[900],
                  minWidth: _width,
                  height: _hight * 0.06,
                  textColor: Colors.grey[50],
                  buttonName: 'Save',
                  textSize: _width * 0.05,
                  textStyle: FontWeight.w600,
                  borderRadius: 5.0,
                  borderSideColor: Colors.indigo[900],
                  onClick: submitChange,
                ),
              ),
            ],
          ),
        );
      });
}

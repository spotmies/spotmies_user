import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotmies/controllers/profile_controllers/profile_controller.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/utilities/textFormFieldWidget.dart';
import 'package:spotmies/utilities/uploadFilesToCloud.dart';
import 'package:spotmies/views/reusable_widgets/profile_pic.dart';

Future editDetails(
    BuildContext context,
    _width,
    _hight,
    UserDetailsProvider profileProvider,
    editpic,
    ProfileController _profileController,
    {details}) {
  log(details.toString());
  TextEditingController nameController =
      TextEditingController(text: details['name'].toString());
  TextEditingController emailController =
      TextEditingController(text: details['eMail']?.toString() ?? "");
  TextEditingController mobileNoController =
      TextEditingController(text: details['altNum']?.toString() ?? "");
  var nameformkey = GlobalKey<FormState>();
  var emailformkey = GlobalKey<FormState>();
  var mobileformkey = GlobalKey<FormState>();
  Future<void> submitChange() async {
    profileProvider.setLoader(true);
    Navigator.pop(context);
    String profilePicLink =
        await uploadFilesToCloud(editpic, cloudLocation: "userDocs");
    profileProvider.setLoader(false);

    var body = {
      "name": nameController.text,
      "eMail": emailController.text,
      "altNum": mobileNoController.text,
      "pic": profilePicLink
    };
    print(body);
    profileProvider.setLoader(true);
    var resp = await _profileController.updateProfileDetails(body);
    profileProvider.setLoader(false);
    if (resp != null) {
      log(resp.toString());
      profileProvider.setUser(resp);
    }
  }

  pickImage(setStatee) async {
    print(" profile $editpic");
    final pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 60,
        preferredCameraDevice: CameraDevice.rear);
    editpic = File(pickedFile?.path);
    setStatee(() {});
    // refresh();

    // if (pickedFile.path == null) retrieveLostData();
  }

  return showModalBottomSheet(
      context: context,
      elevation: 0,
      isScrollControlled: true,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          // padding: EdgeInsets.only(top: _width * 0.04),
          height: _hight * 0.9,
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setStatee) {
            return ListView(
              children: [
                Center(
                  child: ProfilePic(
                    profile: editpic,
                    name: details['name'],
                    size: _width * 0.22,
                    onClick: () {
                      pickImage(setStatee);
                    },
                    onClickLabel: "change profile",
                  ),
                ),
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
                                      validateMsg: 'Enter Valid Number',
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
            );
          }),
        );
      });
}

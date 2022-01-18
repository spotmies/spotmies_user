import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotmies/controllers/profile_controllers/profile_controller.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/textFormFieldWidget.dart';
import 'package:spotmies/utilities/uploadFilesToCloud.dart';
import 'package:spotmies/views/reusable_widgets/profile_pic.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

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
  Future<void> submitChange(BuildContext context) async {
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
          padding: EdgeInsets.only(top: _hight * 0.04),
          height: _hight * 0.76,
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setStatee) {
            return Column(
              children: [
                Center(
                  child: ProfilePic(
                    profile: editpic,
                    name: details['name'],
                    size: _width * 0.18,
                    onClick: () {
                      pickImage(setStatee);
                    },
                    onClickLabel: "change profile",
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 20, left: 20),
                    alignment: Alignment.centerLeft,
                    child: TextWid(
                        text: 'Edit Profile',
                        size: _width * 0.05,
                        weight: FontWeight.w600,
                        color: AppColors.dark)),
                Container(
                    height: _hight * 0.4,
                    padding: EdgeInsets.only(top: 20),
                    child: ListView(children: [
                      Form(
                          key: nameformkey,
                          child: Column(
                            children: [
                              Container(
                                height: _hight * 0.085,
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 5, bottom: 10),
                                child: TextFieldWidget(
                                  controller: nameController,
                                  hint: 'Enter your name Here',
                                  label: "Name",
                                  enableBorderColor: AppColors.grey,
                                  focusBorderColor: AppColors.primaryColorLite,
                                  enableBorderRadius: 15,
                                  focusBorderRadius: 15,
                                  errorBorderRadius: 15,
                                  focusErrorRadius: 15,
                                  validateMsg: 'Enter Valid Name',
                                  maxLines: 1,
                                  postIcon: Icon(
                                    Icons.edit,
                                    size: _width * 0.045,
                                    color: AppColors.dark,
                                  ),
                                  postIconColor: AppColors.primaryColorLite,
                                ),
                              ),
                            ],
                          )),
                      Form(
                          key: emailformkey,
                          child: Column(
                            children: [
                              Container(
                                height: _hight * 0.085,
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 5, bottom: 10),
                                child: TextFieldWidget(
                                  controller: emailController,
                                  hint: 'Enter your Email Here',
                                  label: "Email",
                                  enableBorderColor: AppColors.grey,
                                  focusBorderColor: AppColors.primaryColorLite,
                                  enableBorderRadius: 15,
                                  focusBorderRadius: 15,
                                  errorBorderRadius: 15,
                                  focusErrorRadius: 15,
                                  validateMsg: 'Enter Valid Name',
                                  maxLines: 1,
                                  postIcon: Icon(
                                    Icons.email_rounded,
                                    size: _width * 0.045,
                                    color: AppColors.dark,
                                  ),
                                  postIconColor: AppColors.primaryColorLite,
                                ),
                              ),
                            ],
                          )),
                      Form(
                          key: mobileformkey,
                          child: Column(
                            children: [
                              Container(
                                height: _hight * 0.085,
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 5, bottom: 10),
                                child: TextFieldWidget(
                                  maxLength: 10,
                                  formatter: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  controller: mobileNoController,
                                  hint: 'Alternative',
                                  enableBorderColor: AppColors.grey,
                                  focusBorderColor: AppColors.primaryColorLite,
                                  enableBorderRadius: 15,
                                  focusBorderRadius: 15,
                                  errorBorderRadius: 15,
                                  focusErrorRadius: 15,
                                  validateMsg: 'Enter Valid Number',
                                  maxLines: 1,
                                  label: "Alternative Number",
                                  postIcon: Icon(
                                    Icons.phone,
                                    size: _width * 0.045,
                                    color: AppColors.dark,
                                  ),
                                  postIconColor: AppColors.primaryColorLite,
                                ),
                              ),
                            ],
                          )),
                    ])),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButtonWidget(
                        bgColor: AppColors.secondaryColorLite,
                        minWidth: _width * 0.35,
                        height: _hight * 0.06,
                        textColor: AppColors.primaryColorLite,
                        buttonName: 'Discard',
                        textSize: _width * 0.035,
                        textStyle: FontWeight.w600,
                        borderRadius: 15.0,
                        borderSideColor: AppColors.secondaryColorLite,
                        leadingIcon: Icon(
                          Icons.close,
                          color: AppColors.primaryColorLite,
                          size: _width * 0.04,
                        ),
                        onClick: () {
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButtonWidget(
                        bgColor: AppColors.primaryColorLite,
                        minWidth: _width * 0.55,
                        height: _hight * 0.06,
                        textColor: AppColors.white,
                        buttonName: 'Change & Save',
                        textSize: _width * 0.035,
                        textStyle: FontWeight.w600,
                        borderRadius: 15.0,
                        borderSideColor: AppColors.primaryColorLite,
                        trailingIcon: Icon(
                          Icons.published_with_changes,
                          color: AppColors.white,
                          size: _width * 0.04,
                        ),
                        onClick: () {
                          submitChange(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        );
      });
}

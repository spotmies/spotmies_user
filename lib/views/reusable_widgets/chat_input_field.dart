import 'dart:developer';
import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotmies/providers/chat_provider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/utilities/appConfig.dart';
// import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/views/reusable_widgets/audio.dart';
import 'package:spotmies/views/reusable_widgets/bottom_options_menu.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

import '../../controllers/chat_controllers/chat_controller.dart';

TextEditingController inputController = TextEditingController();

class ChatInputField extends StatefulWidget {
  final dynamic sendCallBack;
  final BuildContext context;
  ChatController? controller;
  ChatProvider? chatProvider;
  UserDetailsProvider? profileProvider;
  ChatInputField(
    this.sendCallBack,
    this.context, {
    Key? key,
    this.controller,
    this.chatProvider,
    this.profileProvider,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  List mediaOptions = [
    {
      "name": "Camera",
      "icon": Icons.camera,
    },
    {"name": "Gallery", "icon": Icons.collections},
    {
      "name": "Video",
      "icon": Icons.video_camera_back,
    },
    // {
    //   "name": "Audio",
    //   "icon": Icons.mic,
    // },
  ];
  double? minheight = 70;
  @override
  Widget build(BuildContext context) {
    inputController.addListener(() {
      if (inputController.text.isEmpty) {
        setState(() {});
      }
    });
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          color: SpotmiesTheme.onBackground.withOpacity(0.1),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 14),

                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: fonts(width(context) * 0.05, FontWeight.w500,
                              SpotmiesTheme.secondaryVariant),
                          controller: inputController,
                          maxLines: 10,
                          minLines: 1,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              onPressed: () {
                                widget.controller?.chooseImage(
                                    widget.sendCallBack,
                                    widget.controller?.currentMsgId ?? "",
                                    widget.chatProvider,
                                    context,
                                    widget.profileProvider);
                              },
                              icon: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.grey[500],
                                size: width(context) * 0.07,
                              ),
                            ),
                            border: InputBorder.none,
                            hintStyle: fonts(width(context) * 0.05,
                                FontWeight.w400, Colors.grey[400]),
                            hintText: 'Type Message......',
                          ),
                        ),
                      ),
                      inputController.text.isEmpty
                          ? IconButton(
                              onPressed: () async {
                                bottomOptionsMenu(context,
                                    options: mediaOptions, option1Click: () {
                                  widget.controller?.chooseImage(
                                      widget.sendCallBack,
                                      widget.controller!.currentMsgId,
                                      widget.chatProvider,
                                      context,
                                      widget.profileProvider);
                                }, option2Click: () {
                                  log("option2");
                                  widget.controller?.chooseImage(
                                      widget.sendCallBack,
                                      widget.controller!.currentMsgId,
                                      widget.chatProvider,
                                      context,
                                      widget.profileProvider,
                                      source: ImageSource.gallery);
                                }, option3Click: () {
                                  widget.controller?.pickVideo(
                                      widget.sendCallBack,
                                      widget.controller!.currentMsgId,
                                      widget.chatProvider,
                                      context,
                                      widget.profileProvider);
                                }, option4Click: () {
                                  audioRecoder(context, height(context),
                                      width(context), widget.controller,
                                      from: "personalChat");
                                });
                              },
                              icon: Icon(
                                Icons.attach_file,
                                color: Colors.grey[500],
                                size: width(context) * 0.05,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                inputController.clear();
                                inputController.text = "";
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Colors.grey[500],
                                size: width(context) * 0.05,
                              ),
                            )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: width(context) * 0.03,
              ),
              InkWell(
                onTap: () {
                  if (inputController.text == "") {
                    snackbar(context, 'Enter Message');
                    return;
                  }
                  widget.sendCallBack(inputController.text);
                  inputController.clear();

                  // log(inputController.text);
                },
                child: CircleAvatar(
                  backgroundColor: SpotmiesTheme.primary,
                  radius: width(context) * 0.065,
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

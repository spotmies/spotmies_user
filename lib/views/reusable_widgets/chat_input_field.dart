import 'package:flutter/material.dart';
import 'package:spotmies/providers/chat_provider.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/utilities/appConfig.dart';
// import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/views/reusable_widgets/audio.dart';
import 'package:spotmies/views/reusable_widgets/bottom_options_menu.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

import '../../controllers/chat_controllers/chat_controller.dart';

TextEditingController inputController = TextEditingController();
Container chatInputField(
  sendCallBack,
  BuildContext context, {
  ChatController? controller,
  ChatProvider? chatProvider,
  UserDetailsProvider? profileProvider,
}) {
  // bool isInput = false;
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
    {
      "name": "Audio",
      "icon": Icons.mic,
    },
  ];
  return Container(
    padding: EdgeInsets.all(10),
    color: Colors.transparent,
    height: 70,
    child: Row(
      children: [
        Expanded(
          child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 14),
            height: height(context) * 0.08,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200, blurRadius: 2, spreadRadius: 2)
              ],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Stack(children: [
                    TextField(
                      style: fonts(width(context) * 0.05, FontWeight.w500,
                          Colors.grey[900]),
                      controller: inputController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.mic,
                            color: Colors.grey[500],
                            size: width(context) * 0.07,
                          ),
                        ),
                        border: InputBorder.none,
                        hintStyle: fonts(width(context) * 0.05, FontWeight.w400,
                            Colors.grey[400]),
                        hintText: 'Type Message......',
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: inputController.text.isEmpty
                          ? IconButton(
                              onPressed: () async {
                                bottomOptionsMenu(context,
                                    options: mediaOptions, option1Click: () {
                                  controller?.chooseImage(
                                      sendCallBack,
                                      controller.currentMsgId,
                                      chatProvider,
                                      context,
                                      profileProvider);
                                }, option3Click: () {
                                  controller?.pickVideo(
                                      sendCallBack,
                                      controller.currentMsgId,
                                      chatProvider,
                                      context,
                                      profileProvider);
                                }, option4Click: () {
                                  audioRecoder(context, height(context),
                                      width(context), controller,
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
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Colors.grey[500],
                                size: width(context) * 0.05,
                              ),
                            ),
                    )
                  ]),
                ),
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
            sendCallBack(inputController.text);
            inputController.clear();

            // log(inputController.text);
          },
          child: CircleAvatar(
            backgroundColor: Colors.blueGrey[500],
            radius: width(context) * 0.065,
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        )
      ],
    ),
  );
}

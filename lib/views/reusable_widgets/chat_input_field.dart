import 'package:flutter/material.dart';
import 'package:spotmies/controllers/chat_controllers/chat_controller.dart';
// import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/views/reusable_widgets/audio.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

TextEditingController inputController = TextEditingController();
Container chatInputField(sendCallBack, BuildContext context, {controller}) {
  // bool isInput = false;

  // var formkey = GlobalKey<FormState>();
  final hight = MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      kToolbarHeight;
  final width = MediaQuery.of(context).size.width;
  return Container(
    padding: EdgeInsets.all(10),
    color: Colors.transparent,
    height: 70,
    child: Row(
      children: [
        Expanded(
          child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 14),
            height: hight * 0.08,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200], blurRadius: 2, spreadRadius: 2)
              ],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Stack(children: [
                    TextField(
                      style: fonts(
                          width * 0.05, FontWeight.w500, Colors.grey[900]),
                      controller: inputController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.mic,
                            color: Colors.grey[500],
                            size: width * 0.07,
                          ),
                        ),
                        border: InputBorder.none,
                        hintStyle: fonts(
                            width * 0.05, FontWeight.w400, Colors.grey[400]),
                        hintText: 'Type Message......',
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: inputController.text.isEmpty
                          ? IconButton(
                              onPressed: () async {
                                await attachments(
                                    context,
                                    hight,
                                    width,
                                    controller,
                                    sendCallBack,
                                    controller.currentMsgId);
                              },
                              icon: Icon(
                                Icons.attach_file,
                                color: Colors.grey[500],
                                size: width * 0.05,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                inputController.clear();
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Colors.grey[500],
                                size: width * 0.05,
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
          width: width * 0.03,
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
            radius: width * 0.065,
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

Future attachments(BuildContext context, double hight, double width,
    ChatController chatController, sendCallBack, String msgId) {
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
          height: hight * 0.1,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () async {
                        chatController.chooseImage(sendCallBack, msgId);
                        Navigator.pop(context);

                        // imageGallery(context, chatController);
                      },
                      icon: Icon(Icons.camera),
                    ),
                    TextWid(
                      text: 'Camera',
                      size: width * 0.03,
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.collections),
                    ),
                    TextWid(
                      text: 'Gallery',
                      size: width * 0.03,
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        chatController.pickVideo(sendCallBack, msgId);
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.video_camera_back),
                    ),
                    TextWid(
                      text: 'Video',
                      size: width * 0.03,
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        audioRecoder(context, hight, width, chatController,
                            from: "personalChat");
                      },
                      icon: Icon(Icons.mic),
                    ),
                    TextWid(
                      text: 'Audio',
                      size: width * 0.03,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

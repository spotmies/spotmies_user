import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmies/controllers/home_controllers/ad_controll.dart';
import 'package:spotmies/utilities/constants.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/media_player.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/reusable_widgets/audio.dart';
import 'package:spotmies/views/reusable_widgets/image_viewer.dart';
import 'package:spotmies/views/reusable_widgets/steps.dart';

Widget page2(double hight, double width, BuildContext context,
    AdController adController) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: hight * 0.05,
        ),
        width: width * 1,
        child: Container(
          height: hight * 1,
          width: width,
          padding: EdgeInsets.only(top: hight * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom: width * 0.05,
                ),
                height: hight * 0.1,
                width: width * 0.8,
                child: Center(
                  child: steps(2, width),
                ),
              ),
              Container(
                height: hight * 0.7,
                width: width * 0.87,
                child: ListView(
                  children: [
                    Container(
                        height: hight * 0.15,
                        child: SvgPicture.asset('assets/like.svg')),
                    SizedBox(
                      height: hight * 0.022,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                        ),
                        height: hight * 0.47,
                        width: width * 0.8,
                        child: Column(
                          children: [
                            Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      return !adController.uploading
                                          ? adController.chooseImage()
                                          : null;
                                    },
                                    icon: Icon(Icons.camera)),
                                IconButton(
                                    onPressed: () {
                                      adController.pickVideo();
                                    },
                                    icon: Icon(Icons.video_camera_back)),
                                IconButton(
                                    onPressed: () {
                                      log(adController.serviceImages
                                          .toString());
                                      audioRecoder(
                                          context, hight, width, adController);
                                    },
                                    icon: Icon(Icons.mic))
                              ],
                            )),
                            SizedBox(
                              height: hight * 0.022,
                            ),
                            adController.serviceImages.length == 0
                                ? Container(
                                    height: hight * 0.35,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.perm_camera_mic,
                                              size: 45,
                                              // color: Colors.grey,
                                            ),
                                            onPressed: () {}),
                                        SizedBox(
                                          height: hight * 0.05,
                                        ),
                                        TextWidget(
                                          text:
                                              'Let us know your problem by uploading \n Image/Video/Audio',
                                          size: width * 0.05,
                                          align: TextAlign.center,
                                          weight: FontWeight.w600,
                                          // lSpace: 1,
                                        ),
                                      ],
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        height: hight * 0.22,
                                        width: width * 1,
                                        child: GridView.builder(
                                            itemCount: adController
                                                    .serviceImages.length +
                                                1,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisSpacing: 3.5,
                                                    crossAxisSpacing: 3.5,
                                                    crossAxisCount: 4),
                                            itemBuilder: (context, index) {
                                              // String type =  _adController.serviceImages[index].toString();

                                              return index == 0
                                                  ? Center(
                                                      child: IconButton(
                                                          icon: Icon(Icons.add),
                                                          onPressed: () {
                                                            return !adController
                                                                    .uploading
                                                                ? adController
                                                                    .chooseImage()
                                                                : null;
                                                          }),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MediaPlayer(
                                                                          mediaList: [
                                                                            adController.serviceImagesStrings[index -
                                                                                1]
                                                                          ],
                                                                          isOnlinePlayer:
                                                                              false,
                                                                        )));
                                                      },
                                                      child: Stack(children: [
                                                        mediaContent(adController
                                                                .serviceImages[
                                                            index - 1]),
                                                        Positioned(
                                                            right: 0,
                                                            top: 0,
                                                            child: InkWell(
                                                                onTap: () {
                                                                  adController
                                                                      .serviceImages
                                                                      .removeAt(
                                                                          index -
                                                                              1);
                                                                  adController
                                                                      .serviceImagesStrings
                                                                      .removeAt(
                                                                          index -
                                                                              1);
                                                                  adController
                                                                      .refresh();
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  size: width *
                                                                      0.05,
                                                                  color: Colors
                                                                      .white,
                                                                )))
                                                      ]),
                                                    );
                                            }),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: hight * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButtonWidget(
                      onClick: () {
                        adController.sliderKey.currentState?.previous();
                      },
                      buttonName: 'Back',
                      bgColor: Colors.indigo[50],
                      textColor: Colors.indigo[900],
                      height: hight * 0.05,
                      minWidth: width * 0.30,
                      textSize: hight * 0.02,
                      leadingIcon: Icon(
                        Icons.arrow_back_ios,
                        size: hight * 0.015,
                        color: Colors.indigo[900],
                      ),
                      borderRadius: 10.0,
                    ),
                    ElevatedButtonWidget(
                      onClick: () async {
                        await adController.step1();
                      },
                      buttonName: 'Next',
                      bgColor: Colors.indigo[900],
                      textColor: Colors.white,
                      height: hight * 0.05,
                      minWidth: width * 0.60,
                      textSize: hight * 0.02,
                      trailingIcon: Icon(
                        Icons.arrow_forward_ios,
                        size: hight * 0.015,
                      ),
                      borderRadius: 10.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Container mediaContent(file, {bool isOnline = false}) {
  String target = file.toString();

  switch (checkFileType(target)) {
    case "image":
      return Container(
        decoration: BoxDecoration(
            color: Colors.amber,
            image: DecorationImage(
                image: !isOnline
                    ? FileImage(file)
                    : NetworkImage(file) as ImageProvider,
                fit: BoxFit.cover)),
      );

    case "audio":
      return Container(
        color: Colors.grey[800],
        alignment: Alignment.center,
        child: Icon(
          Icons.mic,
          size: 30,
          color: Colors.grey[100],
        ),
      );

    case "video":
      return Container(
        color: Colors.grey[800],
        alignment: Alignment.center,
        child: Icon(
          Icons.slow_motion_video_rounded,
          size: 30,
          color: Colors.grey[100],
        ),
      );

    default:
      return Container(
        color: Colors.grey[400],
        alignment: Alignment.center,
        child: TextWidget(text: "undefined"),
      );
  }
}

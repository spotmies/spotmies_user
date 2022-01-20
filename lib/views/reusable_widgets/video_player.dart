import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/progressIndicator.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

import 'package:video_player/video_player.dart';

class VideoPlayerWid extends StatefulWidget {
  final String videoLink;
  final bool isOnlinePlayer;
  const VideoPlayerWid(
      {required this.videoLink, Key? key, this.isOnlinePlayer = true})
      : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<VideoPlayerWid> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = widget.isOnlinePlayer
        ? VideoPlayerController.network(widget.videoLink)
        : VideoPlayerController.file(File(widget.videoLink))
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => videoPlayerController.pause());
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: TextWid(
              text: 'Media',
              size: width * 0.05,
              weight: FontWeight.w600,
              color: Colors.grey.shade900,
            ),
            backgroundColor: Colors.indigo[50],
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.grey[900],
                ))),
        // backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: VideoPlayerWidget(controller: videoPlayerController)),
            SizedBox(
              height: 10,
            ),
            Container(
              // height: MediaQuery.of(context).size.height * 0.05,
              child: TextWid(
                flow: TextOverflow.visible,
                weight: FontWeight.w500,
                align: TextAlign.center,
                text:
                    '*This video/image describes the issues facing the user. \nyou cannot use or publish this video on other social media platforms it causes sevier actions',
              ),
            ),
            SizedBox(
              height: width * 0.05,
            ),
            Container(
                //  height: MediaQuery.of(context).size.height*0.2,
                child: ElevatedButtonWidget(
              buttonName: 'Back',
              textSize: 18,
              height: width * 0.21,
              minWidth: width * 0.9,
              bgColor: Colors.indigo[50],
              textColor: Colors.grey[900],
              textStyle: FontWeight.w600,
              borderRadius: 0.0,
              onClick: () {
                Navigator.pop(context);
              },
            )),
          ],
        ));
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController? controller;

  const VideoPlayerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      controller != null && controller!.value.isInitialized
          ? Container(alignment: Alignment.topCenter, child: buildVideo())
          : Container(child: circleProgress());

  Widget buildVideo() => Stack(
        children: <Widget>[
          buildVideoPlayer(),
          Positioned.fill(child: BasicOverlayWidget(controller: controller!)),
        ],
      );

  Widget buildVideoPlayer() => AspectRatio(
        aspectRatio: controller!.value.aspectRatio,
        child: VideoPlayer(controller!),
      );
}

class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const BasicOverlayWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () =>
            controller.value.isPlaying ? controller.pause() : controller.play(),
        child: Stack(
          children: <Widget>[
            buildPlay(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: buildIndicator(),
            ),
          ],
        ),
      );

  Widget buildIndicator() => VideoProgressIndicator(
        controller,
        allowScrubbing: true,
      );

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: Icon(Icons.play_circle_fill, color: Colors.white, size: 80),
        );
}

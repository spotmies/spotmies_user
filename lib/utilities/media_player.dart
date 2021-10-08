import 'package:flutter/material.dart';
import 'package:spotmies/utilities/constants.dart';
import 'package:spotmies/views/reusable_widgets/audio.dart';
import 'package:spotmies/views/reusable_widgets/image_viewer.dart';
import 'package:spotmies/views/reusable_widgets/video_player.dart';

class MediaPlayer extends StatefulWidget {
  final List mediaList;
  const MediaPlayer({@required this.mediaList});
  // const MediaPlayer({ Key? key }) : super(key: key);

  @override
  _MediaPlayerState createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
  @override
  void initState() {
    super.initState();
  }

  renderPlayer() {
    final hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    // final width = MediaQuery.of(context).size.width;
    switch (checkFileType(widget.mediaList[0])) {
      case "image":
        return ImageViewer(imageLink: widget.mediaList[0]);
        break;
      case "video":
        return VideoPlayerWid(videoLink: widget.mediaList[0]);
        break;
      case "audio":
        // playAudio(context, hight, width, widget.mediaList[0]);
        return Scaffold(
          body: Center(
            child: Container(
                height: hight * 0.2,
                child: FeatureButtonsView(message: widget.mediaList[0])),
          ),
        );
        break;

      default:
        return Scaffold(body: Center(child: Text("something went wrong")));
        break;
    }
  }

  // Future playAudio(BuildContext context, double hight, double width, message) {
  //   return showModalBottomSheet(
  //       context: context,
  //       elevation: 22,
  //       isScrollControlled: true,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(
  //           top: Radius.circular(20),
  //         ),
  //       ),
  //       builder: (BuildContext context) {
  //         return Container(
  //             height: hight * 0.2, child: FeatureButtonsView(message: message));
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return renderPlayer();
  }
}

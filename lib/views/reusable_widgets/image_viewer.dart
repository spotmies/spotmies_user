import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatefulWidget {
  final dynamic imageLink;
  final isOnlinePlayer;
  const ImageViewer(
      {Key? key, required this.imageLink, this.isOnlinePlayer = true})
      : super(key: key);

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  void initState() {
    log(widget.imageLink.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object>? imageProvider = widget.isOnlinePlayer
        ? NetworkImage(widget.imageLink)
        : FileImage(File(widget.imageLink)) as ImageProvider;
    return Scaffold(
      body: Center(
        child: PhotoView(
          imageProvider: imageProvider,
        ),
      ),
    );
  }
}

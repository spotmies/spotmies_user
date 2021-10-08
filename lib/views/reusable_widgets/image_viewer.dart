import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatefulWidget {
  final String imageLink;
    const ImageViewer({ Key key, this.imageLink }) : super(key: key);

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
      body: Center(child: PhotoView(imageProvider: NetworkImage(widget.imageLink),),),
    );
    }
}
  
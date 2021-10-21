import 'package:flutter/material.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

Widget profilePic(BuildContext context, upic, name, {onClick}) {
  // final width(context) = MediaQuery.of(context).size.width;
  // final _hight = MediaQuery.of(context).size.height -
      // MediaQuery.of(context).padding.top -
      // kToolbarHeight;
  return CircleAvatar(
    child: Stack(children: [
      ClipOval(
        child: Uri.parse(upic).isAbsolute
            ? Image.network(upic,
                height: width(context) * 0.4, width: width(context) * 0.4, fit: BoxFit.fill)
            : Container(
                height: width(context) * 0.4,
                width: width(context) * 0.4,
                alignment: Alignment.center,
                child: TextWid(
                  text: "${name[0] ?? "J"}",
                  size: 30,
                  weight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
      Positioned(
          bottom: 0,
          right: 0,
          child: Card(
            elevation: 7,
            shape: CircleBorder(),
            child: InkWell(
              onTap: () {
                onClick();
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.edit,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ))
    ]),
    radius: width(context) * 0.2,
  );
}

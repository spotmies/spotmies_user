import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic(
      {Key key,
      @required this.profile,
      @required this.name,
      this.onClick,
      this.bgColor,
      this.size,
      this.textSize,
      this.textColor,
      this.badge,
      this.onClickLabel,
      this.status = true,
      this.isProfile = true})
      : super(key: key);

  final dynamic profile;
  final String name;
  final bool status;
  final Color bgColor;
  final double textSize;
  final Color textColor;
  final bool badge;
  final Function onClick;
  final double size;
  final String onClickLabel;
  final bool isProfile;
  Widget _activeIcon(double hight, double width) {
    if (status) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(3),
          width: width * 0.04,
          height: width * 0.04,
          color: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: Colors.greenAccent, // flat green
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void initState() {
    log("type ${profile.runtimeType}");
  }

  @override
  Widget build(BuildContext context) {
    log("type ${profile.runtimeType} ");
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        if (onClick != null) onClick();
      },
      child: Container(
        child: Uri.parse(profile.runtimeType == String ? profile : "s")
                .isAbsolute
            ? Stack(
                // this is image from online
                children: [
                  isProfile
                      ? CircleAvatar(
                          backgroundColor: bgColor ??
                              ([...Colors.primaries]..shuffle()).first,
                          radius: size ?? _width * 0.07,
                          backgroundImage: NetworkImage(profile ?? ""),
                        )
                      : Container(
                          child: Image.network(profile),
                        ),
                  Visibility(
                    visible: onClick != null,
                    child: changeLable(_width),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: badge == true
                        ? _activeIcon(_hight, _width)
                        : Container(),
                  ),
                ],
              )
            : Stack(
                // this is image from File or it shows circular avatar with name
                children: [
                  profile.runtimeType == String
                      ? Container(
                          child: isProfile
                              ? CircleAvatar(
                                  //  this is circular avatar with name
                                  backgroundColor: bgColor ??
                                      avatarColor(name[0].toLowerCase()),
                                  radius: size ?? _width * 0.07,
                                  child: Center(
                                    child: TextWid(
                                      text: toBeginningOfSentenceCase(name[0]),
                                      color: textColor ?? Colors.white,
                                      size: textSize ?? _width * 0.06,
                                    ),
                                  ),
                                )
                              : Container(
                                  color: bgColor ?? Colors.grey[300],
                                  child: Center(
                                    child: TextWid(
                                      text: toBeginningOfSentenceCase(name[0]),
                                      color: textColor ?? Colors.white,
                                      size: textSize ?? _width * 0.06,
                                    ),
                                  ),
                                ),
                        )
                      : Container(
                          child: isProfile
                              ? CircleAvatar(
                                  // this is file image
                                  backgroundImage: FileImage(profile),
                                  radius: size ?? _width * 0.07,
                                )
                              : Container(
                                  child: Image.file(profile),
                                ),
                        ),
                  Visibility(
                    visible: onClick != null,
                    child: changeLable(_width),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: badge == true
                        ? _activeIcon(_hight, _width)
                        : Container(),
                  ),
                ],
              ),
      ),
    );
  }

  Positioned changeLable(double _width) {
    return Positioned(
        left: _width * 0.065,
        bottom: _width * 0.04,
        child: Container(
          child: TextWid(
            text: onClickLabel ?? "change",
            color: Colors.grey[400],
            size: _width * 0.04,
            weight: FontWeight.bold,
          ),
        ));
  }
}

List colors = [
  Colors.red,
  Colors.green,
  Colors.orange,
  Colors.amber,
  Colors.blue,
  Colors.indigo,
  Colors.pink,
  Colors.blueGrey,
  Colors.lightBlue,
  Colors.redAccent,
  Colors.greenAccent,
  Colors.black,
  Colors.brown,
  Colors.grey,
  Colors.cyanAccent,
  Colors.teal,
  Colors.deepPurple,
  Colors.indigoAccent,
  Colors.purple,
];

avatarColor(String name) {
  if (name == 'a') return colors[1];
  if (name == 'b') return colors[2];
  if (name == 'c') return colors[3];
  if (name == 'd') return colors[4];
  if (name == 'e') return colors[5];
  if (name == 'f') return colors[6];
  if (name == 'g') return colors[7];
  if (name == 'h') return colors[8];
  if (name == 'i') return colors[9];
  if (name == 'j') return colors[10];
  if (name == 'k') return colors[11];
  if (name == 'l') return colors[12];
  if (name == 'm') return colors[13];
  if (name == 'n') return colors[14];
  if (name == 'o') return colors[15];
  if (name == 'p') return colors[16];
  if (name == 'q') return colors[17];
  if (name == 'r') return colors[18];
  if (name == 's') return colors[0];
  if (name == 't') return colors[1];
  if (name == 'u') return colors[2];
  if (name == 'v') return colors[3];
  if (name == 'w') return colors[4];
  if (name == 'x') return colors[5];
  if (name == 'y') return colors[6];
  if (name == 'z') return colors[7];
}

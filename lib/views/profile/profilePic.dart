import 'package:flutter/material.dart';
import 'package:spotmies/views/profile/editDetailsBS.dart';

Widget profilePic(BuildContext context, upic) {
  final _width = MediaQuery.of(context).size.width;
  final _hight = MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      kToolbarHeight;
  return CircleAvatar(
    child: Stack(children: [
      ClipOval(
        child: Image.network(upic,
            height: _width * 0.3, width: _width * 0.3, fit: BoxFit.fill),
      ),
      Positioned(
          bottom: 0,
          right: 0,
          child: Card(
            elevation: 7,
            shape: CircleBorder(),
            child: InkWell(
              onTap: () {
                editDetails(context, _hight, _width);
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
    radius: _width * 0.15,
  );
}

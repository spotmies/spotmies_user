import 'package:flutter/material.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

Widget profilePic(BuildContext context, upic, name, size,
    {onClick, edit = true}) {
  // final width(context) = MediaQuery.of(context).size.width;
  // final _hight = MediaQuery.of(context).size.height -
  // MediaQuery.of(context).padding.top -
  // kToolbarHeight;
  return CircleAvatar(
    child: Stack(children: [
      ClipOval(
        child: (upic == null || upic == "null") == false
            ? Image.network(upic, height: size, width: size, fit: BoxFit.fill)
            : Container(
                height: size,
                width: size,
                alignment: Alignment.center,
                child: TextWid(
                  text: "${name[0] ?? "J"}",
                  size: size * 0.5,
                  weight: FontWeight.w600,
                  color: SpotmiesTheme.background,
                ),
              ),
      ),
      if (edit)
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
    radius: size / 2.5,
    backgroundColor: SpotmiesTheme.primary,
  );
}

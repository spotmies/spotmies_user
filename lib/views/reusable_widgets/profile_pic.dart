import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic(
      {Key key,
      @required this.profile,
      @required this.name,
      @required this.bgColor,
      this.size,
      this.badgeIcon,
      this.onClick,
      this.status = true})
      : super(key: key);

  final String profile;
  final String name;
  final bool status;
  final Color bgColor;
  final double size;
  final Icon badgeIcon;
  final Callback onClick;
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

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Container(
      child: Uri.parse(profile).isAbsolute
          ? Stack(
              children: [
                CircleAvatar(
                  backgroundColor:
                      bgColor ?? ([...Colors.primaries]..shuffle()).first,
                  radius: size ?? _width * 0.07,
                  backgroundImage: NetworkImage(profile ?? ""),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: _activeIcon(_hight, _width),
                ),
              ],
            )
          : Stack(
              children: [
                CircleAvatar(
                  backgroundColor:
                      bgColor ?? ([...Colors.primaries]..shuffle()).first,
                  radius: size ?? _width * 0.07,
                  child: Center(
                    child: TextWid(
                      text: name[0],
                      color: Colors.white,
                      size: _width * 0.06,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    onClick != null ? onClick() : snackbar(context, "some went wrong");
                  },
                  child: Positioned(
                    right: 0,
                    bottom: 0,
                    child: badgeIcon ?? _activeIcon(_hight, _width),
                  ),
                ),
              ],
            ),
    );
  }
}

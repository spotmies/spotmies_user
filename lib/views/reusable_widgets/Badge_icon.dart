import 'package:flutter/material.dart';

class BadgeIcon extends StatelessWidget {
  final Icon iconData;
  final VoidCallback onTap;
  final Text badgeText;
  final Color badgeColor;

  const BadgeIcon({
    Key key,
    this.onTap,
    @required this.iconData,
    this.badgeColor,
    this.badgeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // width: 72,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            iconData,
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: badgeColor ?? Colors.red),
                alignment: Alignment.center,
                child: badgeText,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotmies/views/call_ui/audioCallWithImage/size.config.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    this.size = 90,
    required this.iconSrc,
    required this.color,
    required this.iconColor,
    required this.press,
  }) : super(key: key);

  final double size;
  final String iconSrc;
  final Color color, iconColor;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(size),
      width: getProportionateScreenWidth(size),
      child: TextButton(
          onPressed: press,
          child: Container(
            padding: EdgeInsets.all(15 / 64 * size),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: color,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade700,
                  offset: Offset(2, 3.0), //(x,y)
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: SvgPicture.asset(
              iconSrc,
              color: iconColor,
            ),
          )),
    );
  }
}

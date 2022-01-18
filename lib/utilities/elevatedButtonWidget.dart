import 'package:flutter/material.dart';
import 'package:spotmies/utilities/fonts.dart';

class ElevatedButtonWidget extends StatefulWidget {
  final Color? bgColor;
  final Color? textColor;
  final String? buttonName;
  final double? borderRadius;
  final double? minWidth;
  final double? height;
  final Color? borderSideColor;
  final TextStyle? style;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? textSize;
  final VoidCallback? onClick;
  final FontWeight? textStyle;
  final double? elevation;

  ElevatedButtonWidget({
    this.bgColor,
    this.textColor,
    this.buttonName,
    this.borderRadius,
    this.minWidth,
    this.height,
    this.borderSideColor,
    this.style,
    this.leadingIcon,
    this.trailingIcon,
    this.textSize,
    this.textStyle,
    this.onClick,
    this.elevation,
  });

  @override
  _ElevatedButtonWidgetState createState() => _ElevatedButtonWidgetState();
}

class _ElevatedButtonWidgetState extends State<ElevatedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.minWidth ?? double.infinity,
      height: widget.height ?? 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 0)),
      child: ElevatedButton(
          onPressed: () {
            if (widget.onClick != null) {
              return widget.onClick!();
            }
          },
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(widget.elevation ?? 0),
              backgroundColor: MaterialStateProperty.all(
                widget.bgColor ?? Colors.blue,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 0),
                      side: BorderSide(
                          color: widget.borderSideColor ?? Colors.white)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildLeadingIcon(widget.leadingIcon),
              Text(
                widget.buttonName ?? 'Button',
                style: fonts(widget.textSize ?? 10.0, widget.textStyle,
                    widget.textColor ?? Colors.black),
              ),
              buildTrailingIcon(widget.trailingIcon),
            ],
          )),
    );
  }
}

Widget buildLeadingIcon(Widget? leadingIcon) {
  if (leadingIcon != null) {
    return Row(
      children: <Widget>[leadingIcon, SizedBox(width: 10)],
    );
  }
  return Container();
}

Widget buildTrailingIcon(Widget? trailingIcon) {
  if (trailingIcon != null) {
    return Row(
      children: <Widget>[
        SizedBox(width: 10),
        trailingIcon,
      ],
    );
  }
  return Container();
}

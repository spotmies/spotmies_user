import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWid extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final String? family;
  final double? lSpace;
  final int? maxlines;
  final TextOverflow? flow;
  final TextAlign? align;
  final TextDecoration? decoration;

  TextWid(
      {required this.text,
      this.size,
      this.color,
      this.weight,
      this.align,
      this.decoration,
      this.family,
      this.flow,
      this.maxlines,
      this.lSpace});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: flow ?? TextOverflow.ellipsis,
        maxLines: maxlines,
        textAlign: align ?? TextAlign.start,
        style: GoogleFonts.josefinSans(
          letterSpacing: lSpace ?? 0,
          decoration: decoration ?? TextDecoration.none,
          fontSize: size ?? 14,
          color: color ?? Colors.black,
          fontWeight: weight ?? FontWeight.normal,
        ));
  }
}

// for text field stylish
fonts(size, bold, color) {
  return GoogleFonts.josefinSans(
    letterSpacing: 1,
    color: color,
    fontSize: size,
    fontWeight: bold,
  );
}

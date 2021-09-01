import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWid extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color color;
  final String family;
  final double lSpace;
  final int maxlines;

  TextWid(
      {this.text,
      this.size,
      this.color,
      this.weight,
      this.family,
      this.maxlines,
      this.lSpace});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: TextOverflow.ellipsis,
        maxLines: maxlines,
        style: GoogleFonts.josefinSans(
          letterSpacing: lSpace ?? 0,
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

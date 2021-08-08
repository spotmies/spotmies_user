import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWid extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color color;
  final String family;
  final double lSpace;

  TextWid(
      {this.text,
      this.size,
      this.color,
      this.weight,
      this.family,
      this.lSpace});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: TextOverflow.visible,
        style: GoogleFonts.josefinSans(
          letterSpacing: lSpace ?? 0,
          fontSize: size ?? 14,
          color: color ?? Colors.black,
          fontWeight: weight ?? FontWeight.normal,
        ));
  }
}

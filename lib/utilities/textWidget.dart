import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color color;
  final String family;
  final double lSpace;

  TextWidget(
      {this.text,
      this.size,
      this.color,
      this.weight,
      this.family,
      this.lSpace});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.josefinSans(
        letterSpacing: lSpace ?? 0,
        fontSize: size ?? 14,
        color: color ?? Colors.black,
        fontWeight: weight ?? FontWeight.normal,

      )
      
     
    );
  }
}
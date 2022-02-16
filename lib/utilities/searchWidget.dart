import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotmies/providers/theme_provider.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;
  final IconData? icon;

  const SearchWidget(
      {Key? key,
      required this.text,
      required this.onChanged,
      required this.hintText,
      this.icon})
      : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = GoogleFonts.josefinSans(
        color: SpotmiesTheme.equal,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0);
    final styleHint = GoogleFonts.josefinSans(
        color: SpotmiesTheme.onBackground,
        fontWeight: FontWeight.w600,
        fontSize: 17,
        letterSpacing: 1.0);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: SpotmiesTheme.background,
          boxShadow: [
            BoxShadow(
                color: SpotmiesTheme.shadow, blurRadius: 5, spreadRadius: 3)
          ]
          // border: Border.all(color: Colors.grey[700]),
          ),
      // padding: const EdgeInsets.symmetric(horizontal: 0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            icon: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: SpotmiesTheme.onBackground),
            ),
            suffixIcon: widget.text.isNotEmpty
                ? GestureDetector(
                    child: Icon(Icons.clear, color: SpotmiesTheme.onBackground),
                    onTap: () {
                      controller.clear();
                      widget.onChanged('');
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  )
                : Icon(widget.icon ?? Icons.home_repair_service,
                    color: SpotmiesTheme.onBackground),
            hintText: widget.hintText,
            hintStyle: style,
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 17)),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}

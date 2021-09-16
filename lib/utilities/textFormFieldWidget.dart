import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotmies/utilities/fonts.dart';

class TextFieldWidget extends StatefulWidget {
  final String text;
  final String hint;
  final String validateMsg;
  final TextInputType keyBoardType;
  final double borderRadius;
  final Color bordercolor;
  final double focusBorderRadius;
  final double enableBorderRadius;
  final Color focusBorderColor;
  final Color enableBorderColor;
  final double errorBorderRadius;
  final double focusErrorRadius;
  final Icon postIcon;
  final Color postIconColor;
  final Color hintColor;
  final double hintSize;
  final FontWeight hintWeight;
  final Icon prefix;
  final Color prefixColor;
  final TextEditingController controller;
  final Function onSubmitField;
  final Function functionValidate;
  final String parametersValidate;
  final int maxLength;
  final int maxLines;
  final String label;
  final List<TextInputFormatter> formatter;

  TextFieldWidget(
      {this.text,
      this.validateMsg,
      this.hint,
      this.keyBoardType,
      this.borderRadius,
      this.bordercolor,
      this.postIcon,
      this.postIconColor,
      this.focusBorderColor,
      this.focusBorderRadius,
      this.enableBorderColor,
      this.enableBorderRadius,
      this.hintColor,
      this.hintSize,
      this.hintWeight,
      this.controller,
      this.onSubmitField,
      this.functionValidate,
      this.parametersValidate,
      this.maxLength,
      this.maxLines,
      this.errorBorderRadius,
      this.focusErrorRadius,
      this.prefixColor,
      this.prefix,
      this.label,
      this.formatter});

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.formatter,
      controller: widget.controller,
      decoration: InputDecoration(
        counterText: '',
        border: new OutlineInputBorder(
            borderSide:
                new BorderSide(color: widget.bordercolor ?? Colors.white),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0)),
        suffixIcon: IconButton(
          onPressed: () {
            widget.controller.clear();
          },
          icon: widget.postIcon ?? Icons.android,
          color: widget.postIconColor ?? Colors.white,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(widget.focusBorderRadius ?? 0)),
            borderSide: BorderSide(
                width: 1, color: widget.focusBorderColor ?? Colors.white)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(widget.enableBorderRadius ?? 0)),
            borderSide: BorderSide(
                width: 1, color: widget.enableBorderColor ?? Colors.white)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(widget.errorBorderRadius ?? 0)),
            borderSide: BorderSide(width: 1, color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.focusErrorRadius ?? 0)),
            borderSide: BorderSide(width: 1, color: Colors.red)),
        hintStyle: fonts(
            widget.hintSize ?? 15.0,
            widget.hintWeight ?? FontWeight.w500,
            widget.hintColor ?? Colors.grey),
        hintText: widget.hint ?? '',
        labelText: widget.label,
      ),
      autofocus: true,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      validator: (value) {
        if (value.isEmpty) {
          return widget.validateMsg ?? '';
        }
        return null;
      },
      onFieldSubmitted: (value) {
        if (widget.onSubmitField != null) widget.onSubmitField();
      },
      keyboardType: widget.keyBoardType,
    );
  }
}

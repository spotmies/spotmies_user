import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/fonts.dart';

class TextFieldWidget extends StatefulWidget {
  final String? text;
  final String? hint;
  final String? validateMsg;
  final TextInputType? keyBoardType;
  final double? borderRadius;
  final Color? bordercolor;
  final double? focusBorderRadius;
  final double? enableBorderRadius;
  final Color? focusBorderColor;
  final Color? enableBorderColor;
  final double? errorBorderRadius;
  final double? focusErrorRadius;
  final Icon postIcon;
  final Color? postIconColor;
  final Color? hintColor;
  final double? hintSize;
  final FontWeight? hintWeight;
  final Icon? prefix;
  final Color? prefixColor;
  final TextEditingController? controller;
  final Function? onSubmitField;
  final Function? functionValidate;
  final String? parametersValidate;
  final int? maxLength;
  final int? maxLines;
  final String? label;
  final List<TextInputFormatter>? formatter;
  final bool isRequired;
  final String type;
  final bool? autofocus;

  TextFieldWidget({
    this.text,
    this.validateMsg,
    this.hint,
    this.keyBoardType,
    this.borderRadius,
    this.bordercolor,
    this.postIcon = const Icon(Icons.android),
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
    this.formatter,
    this.isRequired = true,
    this.type = "text",
    this.autofocus,
  });

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.formatter,
      controller: widget.controller,
      style: fonts(height(context) * 0.025, FontWeight.normal,
          SpotmiesTheme.onBackground),
      decoration: InputDecoration(
        counterText: '',
        border: new OutlineInputBorder(
            borderSide:
                new BorderSide(color: widget.bordercolor ?? Colors.white),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0)),
        suffixIcon: IconButton(
          onPressed: () {
            widget.controller?.clear();
          },
          icon: widget.postIcon,
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
        labelStyle: fonts(
            widget.hintSize ?? 15.0,
            widget.hintWeight ?? FontWeight.w500,
            widget.hintColor ?? Colors.grey),
      ),
      autofocus: widget.autofocus ?? false,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      validator: (value) {
        if (!widget.isRequired) return null;
        return textFieldValidator(widget.type, value, widget.validateMsg);

        // if (widget.label == "Alternative Number") {
        //   if (value.length == 10 && int.parse(value) < 5000000000) {
        //     return 'Please Enter Valid Mobile Number';
        //   } else if (value.length > 0 && value.length < 10) {
        //     return 'Please Enter Valid Mobile Number';
        //   }
        //   return null;
        // } else {
        //   if (value.isEmpty) {
        //     return widget.validateMsg ?? '';
        //   }
        //   return null;
        // }
      },
      onFieldSubmitted: (value) {
        if (widget.onSubmitField != null) widget.onSubmitField!();
      },
      keyboardType: widget.keyBoardType,
    );
  }
}

textFieldValidator(type, value, errorMessage) {
  if (value.isEmpty) {
    return errorMessage ?? 'should not be empty';
  }
  switch (type) {
    case "phone":
      if (value.length != 10 || int.parse(value) < 6000000000)
        return errorMessage ?? "Enter valid number";
      break;
    case "email":
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return errorMessage ?? "enter valid email";
      }
      break;
    case "address":
      if (!RegExp(r"^[A-Za-z0-9'\.\-\s\,]").hasMatch(value)) {
        return errorMessage ?? "enter valid house address";
      }
      break;
    case "number":
      if (!RegExp(r'[0-9]').hasMatch(value)) {
        return errorMessage ?? "Enter valid Number";
      }
      break;
    case "name":
      if (!RegExp(r'[a-z]').hasMatch(value)) {
        return errorMessage ?? "Enter valid Name";
      }
      break;
    default:
      return null;
  }
}

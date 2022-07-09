import 'package:flutter/material.dart';

snackbar(BuildContext context, description, {Function? ontap, String? label}) {
  final snackBar = SnackBar(
    content: Text(description),
    action: SnackBarAction(
      label: label ?? 'Close',
      onPressed: () {
        if (ontap != null) {
          ontap();
        }
      },
    ),
  );

  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

import 'package:flutter/material.dart';

snackbar(BuildContext context,description){
   final snackBar = SnackBar(
        content: Text(description),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      );

     
  return  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
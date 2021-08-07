import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rating_dialog/rating_dialog.dart';

rating(BuildContext context, double hight, double width) {
  showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) {
        return RatingDialog(
          icon: Container(
              height: hight * 0.15, child: SvgPicture.asset('assets/like.svg')),

          title: "Rate Your Technician!",
          description: "Express Your Experience By Tapping \nOn Stars",
          submitButton: "SUBMIT",
          alternativeButton: "Contact us instead?", // optional
          positiveComment: "We are so happy to hear :)", // optional
          negativeComment: "We're sad to hear :(", // optional
          accentColor: Colors.blue[800], // optional
          onSubmitPressed: (int rating) {
            print("onSubmitPressed: rating = $rating");
          },
          onAlternativePressed: () {
            print("onAlternativePressed: do something");
          },
        );
      });
}

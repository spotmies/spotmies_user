import 'package:flutter/material.dart';
import 'package:spotmies/views/reusable_widgets/rating/review_screen.dart';

rating(BuildContext context, double hight, double width) {
  showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) {
        return RatingCard(onFeedbackSubmitted: (int stars, String feedback) {
          print("$stars - $feedback");
        });
        // return RatingDialog(
        //   onSubmitted: (RatingDialogResponse) {}, submitButtonText: '',
        //   title: Text('data'),
        //   // icon: Container(
        //   //     height: hight * 0.15, child: SvgPicture.asset('assets/like.svg')),

        //   // title: "Rate Your Technician!",
        //   // description: "Express Your Experience By Tapping \nOn Stars",
        //   // submitButton: "SUBMIT",
        //   // alternativeButton: "Contact us instead?", // optional
        //   // positiveComment: "We are so happy to hear :)", // optional
        //   // negativeComment: "We're sad to hear :(", // optional
        //   // accentColor: Colors.blue[800], // optional
        //   // onSubmitPressed: (int rating) {
        //   //   print("onSubmitPressed: rating = $rating");
        //   // },
        //   // onAlternativePressed: () {
        //   //   print("onAlternativePressed: do something");
        //   // },
        // );
      });
}

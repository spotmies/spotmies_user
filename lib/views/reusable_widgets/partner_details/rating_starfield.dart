import 'package:flutter/material.dart';
import 'package:spotmies/utilities/appConfig.dart';

class RatingStarField extends StatefulWidget {
  final int? filledState;
  const RatingStarField({Key? key, this.filledState = 0}) : super(key: key);

  @override
  _RatingStarFieldState createState() => _RatingStarFieldState();
}

class _RatingStarFieldState extends State<RatingStarField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RatingStar(
          filled: widget.filledState! >= 1,
        ),
        RatingStar(
          filled: widget.filledState! >= 2,
        ),
        RatingStar(
          filled: widget.filledState! >= 3,
        ),
        RatingStar(
          filled: widget.filledState! >= 4,
        ),
        RatingStar(
          filled: widget.filledState! >= 5,
        ),
      ],
    );
  }
}

class RatingStar extends StatefulWidget {
  final bool? filled;
  const RatingStar({Key? key, this.filled = false}) : super(key: key);

  @override
  _RatingStarState createState() => _RatingStarState();
}

class _RatingStarState extends State<RatingStar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width(context) * 0.02),
      child: Icon(
        widget.filled! ? Icons.star_rounded : Icons.star_border_rounded,
        color: widget.filled! ? Colors.amber : Colors.grey,
        size: width(context) * 0.045,
      ),
    );
  }
}

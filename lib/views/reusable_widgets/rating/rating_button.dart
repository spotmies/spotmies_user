import 'package:flutter/material.dart';
import 'package:spotmies/views/reusable_widgets/rating/size_provider.dart';

class RatingButton extends StatefulWidget {
  final Function onPressed;
  const RatingButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  @override
  State<RatingButton> createState() => _RatingButtonState();
}

class _RatingButtonState extends State<RatingButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getProportionateHeight(8)),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(getProportionateSize(20)),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  widget.onPressed();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.all(getProportionateSize(24)),
                  ),
                ),
                child: Text(
                  "Submit",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(fontSize: getProportionateHeight(20)),
                )),
          ),
        ),
      ),
    );
  }
}
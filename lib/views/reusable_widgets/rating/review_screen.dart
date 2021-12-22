import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/models/rating_model.dart';
import 'package:spotmies/views/reusable_widgets/rating/rating_button.dart';
import 'package:spotmies/views/reusable_widgets/rating/rating_chip.dart';
import 'package:spotmies/views/reusable_widgets/rating/rating_star.dart';
import 'package:spotmies/views/reusable_widgets/rating/rating_textfield.dart';
import 'package:spotmies/views/reusable_widgets/rating/size_provider.dart';

reviewBS(BuildContext context, Function onSubmit) {
  return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            getProportionateSize(24),
          ),
        ),
      ),
      builder: (context) {
        return ChangeNotifierProvider<ServiceViewModel>(
          create: (context) => ServiceViewModel(),
          child: RatingCard(
            onFeedbackSubmitted: (int rating, String comment) {
              onSubmit(rating, comment);
            },
          ),
        );
      });
}

Color getMSColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.disabled
  };
  if (!states.any(interactiveStates.contains)) {
    return Colors.black;
  }
  return Colors.grey.shade700;
}

Color getMSForegroundColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.disabled
  };
  if (!states.any(interactiveStates.contains)) {
    return Colors.white;
  }
  return Colors.grey;
}

class RatingCard extends StatefulWidget {
  final Function onFeedbackSubmitted;
  const RatingCard({Key key, @required this.onFeedbackSubmitted})
      : super(key: key);

  @override
  _RatingCardState createState() => _RatingCardState();
}

class _RatingCardState extends State<RatingCard> {
  int starsGiven = 0;
  String comment = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getProportionateSize(20.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rate your Experience",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      iconSize: getProportionateSize(20),
                      splashRadius: getProportionateSize(20),
                      icon: const Icon(Icons.close_rounded))
                ],
              ),
              Text(
                "Were you satisfied with the service?",
                style: Theme.of(context).textTheme.caption,
              ),
              RatingStars(
                onStarsChanged: (int numberOfStars) {
                  setState(() {
                    starsGiven = numberOfStars + 1;
                  });
                  log(starsGiven.toString());
                },
              ),
              const RatingTextField(),
              SizedBox(
                height: getProportionateHeight(8),
              ),
              Consumer<ServiceViewModel>(builder: (context, model, _) {
                return RatingChips(
                  starsGiven: starsGiven == 0 ? 5 : starsGiven,
                  onChipSelected: (feedback, index) {
                    model.setFeedback(feedback);
                    model.changeListState(index);
                  },
                );
              }),
              SizedBox(
                height: getProportionateHeight(16),
              ),
              RatingButton(
                onPressed: () {
                  var feedbackText =
                      Provider.of<ServiceViewModel>(context, listen: false)
                          .feedback;
                  if (feedbackText.isNotEmpty && starsGiven > 0) {
                    print("Submit Data - $feedbackText with $starsGiven");
                    Navigator.pop(context);
                    widget.onFeedbackSubmitted(starsGiven, feedbackText);
                  } else {
                    var textRating =
                        starsGiven > 3 ? "feedback" : "suggestions";
                    var snackBarText =
                        "Please provide your rating and feedback!";
                    var duration = 2;
                    if (feedbackText.isEmpty && starsGiven > 0) {
                      snackBarText = "Please provide your $textRating!";
                      duration = 1;
                    } else if (feedbackText.isNotEmpty && starsGiven <= 0) {
                      snackBarText = "Please provide your rating!";

                      duration = 1;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(snackBarText),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: duration),
                    ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void resetChips(int index, List<bool> states) {
  for (var i = 0; i < states.length; i++) {
    states[i] = i == index ? !states[i] : false;
  }
}

class RatingStars extends StatefulWidget {
  final Function(int) onStarsChanged;
  const RatingStars({
    Key key,
    @required this.onStarsChanged,
  }) : super(key: key);

  @override
  _RatingStarsState createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  List<bool> starIndex = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RatingStar(
            index: 0,
            onPressed: () {
              setState(() {
                updateRatingStars(0, starIndex, widget.onStarsChanged);
              });
            },
            highestState:
                starIndex.lastIndexWhere((element) => element == true),
            state: starIndex[0]),
        RatingStar(
            index: 1,
            onPressed: () {
              setState(() {
                updateRatingStars(1, starIndex, widget.onStarsChanged);
              });
            },
            highestState:
                starIndex.lastIndexWhere((element) => element == true),
            state: starIndex[1]),
        RatingStar(
            index: 2,
            onPressed: () {
              setState(() {
                updateRatingStars(2, starIndex, widget.onStarsChanged);
              });
            },
            highestState:
                starIndex.lastIndexWhere((element) => element == true),
            state: starIndex[2]),
        RatingStar(
            index: 3,
            onPressed: () {
              setState(() {
                updateRatingStars(3, starIndex, widget.onStarsChanged);
              });
            },
            highestState:
                starIndex.lastIndexWhere((element) => element == true),
            state: starIndex[3]),
        RatingStar(
            index: 4,
            onPressed: () {
              setState(() {
                updateRatingStars(
                  4,
                  starIndex,
                  widget.onStarsChanged,
                );
              });
            },
            highestState:
                starIndex.lastIndexWhere((element) => element == true),
            state: starIndex[4]),
      ],
    );
  }
}

void updateRatingStars(
    int index, List<bool> starIndex, Function(int) onStarsChanged) {
  int numberOfStars = starIndex.lastIndexWhere((element) => element == true);
  if (numberOfStars == index) {
    for (var i = 0; i < starIndex.length; i++) {
      starIndex[i] = false;
    }
    onStarsChanged(-1);
  } else {
    for (var i = 0; i < starIndex.length; i++) {
      if (i == index) {
        starIndex[i] = true;
      } else {
        starIndex[i] = false;
      }
    }
    onStarsChanged(index);
  }
}

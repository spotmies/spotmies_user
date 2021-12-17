import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/models/rating_model.dart';
import 'package:spotmies/views/reusable_widgets/rating/rating_button.dart';
import 'package:spotmies/views/reusable_widgets/rating/rating_chip.dart';
import 'package:spotmies/views/reusable_widgets/rating/rating_star.dart';
import 'package:spotmies/views/reusable_widgets/rating/rating_textfield.dart';
import 'package:spotmies/views/reusable_widgets/rating/size_provider.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key key}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool hasUserGivenFeedBack = false;
  @override
  Widget build(BuildContext context) {
    SizeProvider().init(context);

    return Container(
      padding: EdgeInsets.all(getProportionateSize(16)),
      margin: EdgeInsets.only(top: getProportionateHeight(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            !hasUserGivenFeedBack ? "Your" : "Thank you",
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontSize: getProportionateHeight(36), height: 1),
          ),
          Text(
            hasUserGivenFeedBack ? "for your" : "Feedback",
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                fontSize: !hasUserGivenFeedBack
                    ? getProportionateHeight(64)
                    : getProportionateHeight(20),
                height: 1,
                color: !hasUserGivenFeedBack ? Colors.amber : Colors.black),
          ),
          Text(hasUserGivenFeedBack ? "Feedback." : "is very important to Us.",
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  fontSize: hasUserGivenFeedBack
                      ? getProportionateHeight(64)
                      : getProportionateHeight(20),
                  height: 1,
                  color: hasUserGivenFeedBack ? Colors.amber : Colors.black)),
          SizedBox(
            height: getProportionateHeight(16),
          ),
          hasUserGivenFeedBack
              ? const SizedBox()
              : Text(
                  "Your feedback helps us improve our service and help us serve you better.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.grey),
                ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(getProportionateSize(16)),
            child: const Image(image: AssetImage("assets/feedback.png")),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(getProportionateSize(16)),
              child: ElevatedButton(
                child: Padding(
                  padding: EdgeInsets.all(getProportionateSize(18)),
                  child: Text(
                    hasUserGivenFeedBack ? "Go to Home" : "Rate Our Service",
                    style: TextStyle(fontSize: getProportionateHeight(16)),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => getMSColor(states)),
                  foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => getMSForegroundColor(states)),
                ),
                onPressed: hasUserGivenFeedBack
                    ? null
                    : () {
                        showModalBottomSheet(
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
                                  onFeedbackSubmitted: () {
                                    setState(() {
                                      hasUserGivenFeedBack = true;
                                    });
                                  },
                                ),
                              );
                            });
                      },
              ),
            ),
          ),
          SizedBox(
            height: getProportionateHeight(10),
          )
        ],
      ),
    );
  }
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
  var starsGiven = 0;

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
                    widget.onFeedbackSubmitted();
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
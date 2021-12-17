import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/models/rating_model.dart';
import 'package:spotmies/views/reusable_widgets/rating/chip_data.dart';
import 'package:spotmies/views/reusable_widgets/rating/size_provider.dart';

class RatingChips extends StatefulWidget {
  final int starsGiven;
  final Function(String, int) onChipSelected;
  const RatingChips({
    Key key,
    @required this.starsGiven,
    @required this.onChipSelected,
  }) : super(key: key);

  @override
  _RatingChipsState createState() => _RatingChipsState();
}

class _RatingChipsState extends State<RatingChips> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RatingChip(
              text: chipData[widget.starsGiven][0] ?? "Excellent!",
              onChipSelected: (text, index, chipState) {
                widget.onChipSelected(chipState ? text : "", index);
              },
              index: 0,
            ),
            RatingChip(
              text: chipData[widget.starsGiven][1] ?? "Superb!",
              onChipSelected: (text, index, chipState) {
                widget.onChipSelected(chipState ? text : "", index);
              },
              index: 1,
            ),
            RatingChip(
              text: chipData[widget.starsGiven][2] ?? "Great!",
              onChipSelected: (text, index, chipState) {
                widget.onChipSelected(chipState ? text : "", index);
              },
              index: 2,
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RatingChip(
              text: chipData[widget.starsGiven][3] ?? "Wonderful!",
              onChipSelected: (text, index, chipState) {
                widget.onChipSelected(chipState ? text : "", index);
              },
              index: 3,
            ),
            (chipData[widget.starsGiven] ?? []).length > 4
                ? RatingChip(
                    text: chipData[widget.starsGiven][4] ?? "Sharing It Now!",
                    onChipSelected: (text, index, chipState) {
                      widget.onChipSelected(chipState ? text : "", index);
                    },
                    index: 4,
                  )
                : const SizedBox()
          ],
        ),
      ],
    );
  }
}

class RatingChip extends StatefulWidget {
  final String text;
  final int index;
  final Function(String, int, bool) onChipSelected;
  const RatingChip({
    Key key,
    @required this.text,
    @required this.onChipSelected,
    @required this.index,
  }) : super(key: key);
  @override
  _RatingChipState createState() => _RatingChipState();
}

class _RatingChipState extends State<RatingChip> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceViewModel>(builder: (context, model, _) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.all(getProportionateSize(4)),
        padding: EdgeInsets.all(getProportionateSize(8)),
        width: model.list[widget.index]
            ? max(
                (widget.text.length * getProportionateWidth(10) +
                    getProportionateWidth(20)),
                getProportionateWidth(120))
            : max(widget.text.length * getProportionateWidth(10),
                getProportionateWidth(85)),
        decoration: BoxDecoration(
            color: model.list[widget.index]
                ? Colors.amber.shade300
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(getProportionateSize(28))),
        child: InkWell(
          onTap: () {
            widget.onChipSelected(
                widget.text, widget.index, !model.list[widget.index]);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              model.list[widget.index]
                  ? Padding(
                      padding: EdgeInsets.only(right: getProportionateWidth(8)),
                      child: Icon(
                        Icons.check_rounded,
                        size: getProportionateSize(16),
                      ),
                    )
                  : const SizedBox(
                      width: 0,
                    ),
              Text(
                widget.text,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontSize: getProportionateHeight(14)),
              ),
            ],
          ),
        ),
      );
    });
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class ProcessCard extends StatelessWidget {
  final List? color;
  final List? images;
  final List? titles;
  ProcessCard({Key? key, this.color, this.images, this.titles})
      : super(key: key);

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  animateScroll(index) {
    itemScrollController.scrollTo(
        alignment: 0.05,
        index: index,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context) * 0.22,
      width: width(context),
      child: ScrollablePositionedList.builder(
          padding: EdgeInsets.only(
              right: width(context) * 0.02, left: width(context) * 0.02),
          itemCount: titles?.length as int,
          scrollDirection: Axis.horizontal,
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Container(
                  padding: EdgeInsets.all(
                    width(context) * 0.05,
                  ),
                  height: height(context) * 0.19,
                  width: width(context) * 0.86,
                  decoration: BoxDecoration(
                      color: color![index],
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWid(
                            text: titles![index],
                            size: width(context) * 0.06,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: height(context) * 0.01,
                          ),
                          TextWid(
                            text: 'Step ${index + 1}',
                            size: width(context) * 0.045,
                            color: SpotmiesTheme.secondary,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: height(context) * 0.02,
                          ),
                          ElevatedButtonWidget(
                            onClick: () {
                              index != 3
                                  ? animateScroll(index + 1)
                                  : animateScroll(0);
                            },
                            buttonName: index != 3 ? 'Next' : 'Back',
                            bgColor: SpotmiesTheme.background,
                            borderSideColor: SpotmiesTheme.background,
                            textColor: SpotmiesTheme.onBackground,
                            height: height(context) * 0.03,
                            minWidth: width(context) * 0.25,
                            textSize: width(context) * 0.03,
                            trailingIcon: Icon(
                              index != 3
                                  ? Icons.arrow_forward_ios
                                  : Icons.arrow_back,
                              size: width(context) * 0.03,
                              color: SpotmiesTheme.onBackground,
                            ),
                            borderRadius: 5.0,
                          )
                        ],
                      ),
                      Container(
                          width: width(context) * 0.35,
                          child: SvgPicture.asset(
                            images![index],
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  width: width(context) * 0.05,
                )
              ],
            );
          }),
    );
  }
}

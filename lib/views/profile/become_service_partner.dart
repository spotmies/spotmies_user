import 'package:flutter/material.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

Future becomServiceProvider(BuildContext context, {Function? onSubmit}) {
  // final hight = MediaQuery.of(context).size.height -
  //     MediaQuery.of(context).padding.top -
  //     kToolbarHeight;
  // final width = MediaQuery.of(context).size.width;
  return showModalBottomSheet(
      context: context,
      elevation: 22,
      backgroundColor: SpotmiesTheme.background,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: height(context) * 0.62,
          padding: EdgeInsets.only(top: height(context) * 0.03),
          child: ListView(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: width(context) * 0.07),
                  width: width(context) * 0.8,
                  child: TextWid(
                    text: 'Do you want become a Spotmies service provider?',
                    size: width(context) * 0.1,
                    lSpace: height(context) * 0.0017,
                    weight: FontWeight.w600,
                    flow: TextOverflow.visible,
                    align: TextAlign.start,
                    color: Color(0xFFb2dbe6),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: width(context) * 0.07),
              width: width(context) * 0.8,
              padding: EdgeInsets.only(top: 20, left: 0, right: 10, bottom: 20),
              child: TextWid(
                text:
                    'Click the button below to install the \'Spotmies Partner\' app\nand register to become service partner!',
                flow: TextOverflow.visible,
                color: SpotmiesTheme.onBackground,
              ),
            ),
            Container(
                height: height(context) * 0.2,
                width: width(context) * 0.55,
                child: Image.asset(
                    'assets/icons/spotmies_partner_logo${SpotmiesTheme.themeMode ? "" : "_light"}.png')),
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(horizontal: width(context) * 0.05),
              child: ElevatedButtonWidget(
                bgColor: SpotmiesTheme.primary,
                minWidth: width(context) * 0.8,
                height: height(context) * 0.06,
                textColor: Colors.white,
                buttonName: 'Get the Spotmies Partner app',
                textSize: width(context) * 0.05,
                textStyle: FontWeight.w600,
                borderRadius: height(context) * 0.015,
                borderSideColor: SpotmiesTheme.primary,
                onClick: () {
                  if (onSubmit != null) {
                    onSubmit();
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ]),
        );
      });
}

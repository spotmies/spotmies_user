import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotmies/utilities/appConfig.dart';

Widget profileShimmer(BuildContext context) {
  // final height(context) = MediaQuery.of(context).size.height -
  //     MediaQuery.of(context).padding.top -
  //     kToolbarHeight;
  // final width(context) = MediaQuery.of(context).size.width;
  return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        height: height(context),
        width: width(context),
        child: Column(
          children: [
            Container(
              // padding: EdgeInsets.only(bottom: height(context) * 0.006),
              child: Icon(
                Icons.account_circle,
                size: width(context) * 0.4,
                color: Colors.white,
              ),
            ),
            Container(
              height: 10,
              width: width(context) * 0.4,
              decoration: decorator(10),
            ),
            SizedBox(
              height: height(context) * 0.06,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              smallBlock(width(context)),
              Container(
                height: 30,
                width: 2,
                color: Colors.white,
              ),
              smallBlock(width(context))
            ]),
            SizedBox(
              height: height(context) * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height(context) * 0.001,
                  color: Colors.white,
                  width: width(context) * 0.32,
                ),
                Container(
                  height: height(context) * 0.001,
                  color: Colors.white,
                  width: width(context) * 0.32,
                )
              ],
            ),
            SizedBox(
              height: height(context) * 0.03,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(
                          bottom: height(context) * 0.025, right: 20, left: 20),
                      child: Container(
                        height: height(context) * 0.065,
                        decoration: decorator(20),
                      ),
                    );
                  }),
            )
          ],
        ),
      ));
}

BoxDecoration decorator(double border) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(border),
    color: Colors.white,
  );
}

Container smallBlock(double width) {
  return Container(
    height: 35,
    width: width * 0.3,
    decoration: decorator(10),
  );
}

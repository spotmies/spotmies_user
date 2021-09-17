import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget profileShimmer(BuildContext context) {
  final _hight = MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      kToolbarHeight;
  final _width = MediaQuery.of(context).size.width;
  return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Container(
        height: _hight,
        width: _width,
        child: Column(
          children: [
            Container(
              // padding: EdgeInsets.only(bottom: _hight * 0.006),
              child: Icon(
                Icons.account_circle,
                size: _width * 0.4,
                color: Colors.white,
              ),
            ),
            Container(
              height: 10,
              width: _width * 0.4,
              decoration: decorator(10),
            ),
            SizedBox(
              height: _hight * 0.06,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              smallBlock(_width),
              Container(
                height: 30,
                width: 2,
                color: Colors.white,
              ),
              smallBlock(_width)
            ]),
            SizedBox(
              height: _hight * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: _hight * 0.001,
                  color: Colors.white,
                  width: _width * 0.32,
                ),
                Container(
                  height: _hight * 0.001,
                  color: Colors.white,
                  width: _width * 0.32,
                )
              ],
            ),
            SizedBox(
              height: _hight * 0.03,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(
                          bottom: _hight * 0.025, right: 20, left: 20),
                      child: Container(
                        height: _hight * 0.065,
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

Container smallBlock(double _width) {
  return Container(
    height: 35,
    width: _width * 0.3,
    decoration: decorator(10),
  );
}

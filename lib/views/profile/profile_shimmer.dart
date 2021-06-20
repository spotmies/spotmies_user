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
              height: _hight * 0.39,
              width: _width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
            ),
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
                  margin: EdgeInsets.only(left: 1, right: 1),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  // color: Colors.amber,
                  height: _hight * 0.03,
                  width: _width * 0.29,
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
            Container(
              height: _hight * 0.37,
              width: _width * 1,
              child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                    );
                  }),
            )
          ],
        ),
      ));
}

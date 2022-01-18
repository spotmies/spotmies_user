import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget chatListShimmer(BuildContext context) {
  final _hight = MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      kToolbarHeight;
  final _width = MediaQuery.of(context).size.width;
  return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        children: [
          SizedBox(
            height: _hight * 0.02,
          ),

          Expanded(
            child: ListView.builder(
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: ListTile(
                      title: Container(
                        width: _width * 0.60,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      ),
                      // subtitle: Container(
                      //   padding: EdgeInsets.only(top: 5),
                      //   width: 50,
                      //   height: 10,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     color: Colors.white,
                      //   ),
                      // ),
                      leading: Icon(
                        Icons.account_circle,
                        size: _width * 0.2,
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
          )
          // Container(
          //   height: _hight * 0.37,
          //   width: _width * 1,
          //   child: GridView.builder(
          //       itemCount: 6,
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 3,
          //           crossAxisSpacing: 15,
          //           mainAxisSpacing: 15),
          //       itemBuilder: (BuildContext context, int index) {
          //         return Container(
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.only(
          //                   topLeft: Radius.circular(15),
          //                   bottomRight: Radius.circular(15))),
          //         );
          //       }),
          // )
        ],
      ));
}

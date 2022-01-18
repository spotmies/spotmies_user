import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmies/utilities/fonts.dart';

Widget servicelistBuilder(
  BuildContext context,
  buildName,
  double width,
  double hight,
  List<Map<String, Object>> buildData,
) {
  return Container(
    padding: EdgeInsets.all(width * 0.04),
    height: hight * 0.22,
    margin: EdgeInsets.only(
      top: 15,
    ),
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.shade100, blurRadius: 5, spreadRadius: 2)
        ],
        borderRadius: BorderRadius.circular(15)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$buildName',
                style:
                    fonts(width * 0.045, FontWeight.w600, Colors.blueGrey[600]),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'See More',
                  style: fonts(
                      width * 0.035, FontWeight.w600, Colors.blueGrey[900]),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: hight * 0.13,
          child: ListView.builder(
              itemCount: buildData.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(width * 0.02),
                      child: InkWell(
                        onTap: () {
                          log(
                            buildData[index]['job'].toString(),
                          );
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.blueGrey[50],
                            radius: width * 0.07,
                            child: Icon(
                              buildData[index]['icon'] as IconData?,
                              color: Colors.grey[900],
                            )),
                      ),
                    ),
                    Text(
                      buildData[index]['job'].toString(),
                      style: fonts(
                          width * 0.03, FontWeight.w600, Colors.grey[900]),
                    )
                  ],
                );
              }),
        )
      ],
    ),
  );
}

List catImages = [
  'assets/tradesman.svg',
  'assets/barber.svg',
  'assets/domestic.svg',
  'assets/software.svg',
  'assets/design.svg',
  'assets/education.svg',
  'assets/fliming.svg',
];

List catNames = [
  'Tradesman',
  'Personal Care',
  'Domestic',
  'Software',
  'Design',
  'Education',
  'Filming'
];

Widget serviceBlocksMore(
  BuildContext context,
  buildName,
  double width,
  double hight,
  List<Map<String, Object>> buildData,
) {
  return Container(
    padding: EdgeInsets.only(left: 15, top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            '$buildName',
            style: fonts(width * 0.045, FontWeight.w600, Colors.blueGrey[600]),
          ),
        ),
        Container(
          height: hight * 0.25,
          child: ListView.builder(
              itemCount: catNames.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: width * 0.03),
                      decoration: BoxDecoration(
                        // color: Colors.grey,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade100,
                              blurRadius: 5,
                              spreadRadius: 2)
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          DefaultTabController.of(context)
                              ?.animateTo(index + 1);
                        },
                        child: Container(
                            height: hight * 0.2,
                            width: width * 0.33,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              // color: Colors.indigo[900],
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.indigo.shade900,
                                    Colors.blue.shade900

                                    // ([Colors.green[100],Colors.pink[100],Colors]..shuffle()).first,
                                    // Colors.green[100]
                                  ],
                                  begin: const FractionalOffset(0.0, 0.5),
                                  end: const FractionalOffset(0.5, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            padding: EdgeInsets.only(top: 15, left: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  catNames[index],
                                  style: fonts(width * 0.04, FontWeight.w500,
                                      Colors.white),
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    height: hight * 0.12,
                                    // width: width * 0.23,
                                    child: SvgPicture.asset(catImages[index])),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Explore',
                                        style: fonts(width * 0.03,
                                            FontWeight.w700, Colors.white),
                                      ),
                                      Icon(
                                        Icons.double_arrow,
                                        size: width * 0.04,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    // Text(
                    //   buildData[index]['job'],
                    //   style: fonts(
                    //       width * 0.03, FontWeight.w600, Colors.grey[900]),
                    // )
                  ],
                );
              }),
        )
      ],
    ),
  );
}

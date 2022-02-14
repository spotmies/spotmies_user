import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/progressIndicator.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/posts/post_overview.dart';
import 'package:spotmies/views/reusable_widgets/load_more.dart';
import 'package:spotmies/views/reusable_widgets/partner_details/partner_store.dart';
import 'package:spotmies/views/reusable_widgets/profile_pic.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class PartnerList extends StatefulWidget {
  const PartnerList({Key? key}) : super(key: key);

  @override
  _PartnerListState createState() => _PartnerListState();
}

ScrollController? scrollController = ScrollController();
UniversalProvider? up = UniversalProvider();

class _PartnerListState extends State<PartnerList> {
  @override
  void initState() {
    up = Provider.of<UniversalProvider>(context, listen: false);
    up?.fetchPartnerList(0, 5);
    scrollController?.addListener(() {
      if (scrollController?.position.pixels ==
          scrollController?.position.maxScrollExtent) {
        getMoreData();
      }
    });
    super.initState();
  }

  getMoreData() {
    up?.fetchPartnerList(up?.partnerList.length, 2);
    log('message');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SpotmiesTheme.background,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: width(context) * 0.05,
              color: SpotmiesTheme.onBackground,
            )),
        title: TextWid(
          text: 'Find Partner',
          size: width(context) * 0.05,
          weight: FontWeight.w600,
          color: SpotmiesTheme.onBackground,
        ),
      ),
      body: Consumer<UniversalProvider>(builder: (context, data, child) {
        dynamic pl = data.partnerList;
        log(pl.toString());
        if (pl == null) {
          circleProgress();
        }
        return Container(
          child: ListView.builder(
            controller: scrollController,
            // itemExtent: 200,
            itemCount: pl.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == pl.length) {
                return Container(
                  height: height(context) * 0.6,
                  width: width(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (data.checkNull['id'] == "0")
                        CupertinoActivityIndicator(),
                      SizedBox(
                        width: width(context) * 0.015,
                      ),
                      TextWid(text: data.checkNull['content'])
                    ],
                  ),
                );
              }
              return Container(
                // height: hight * 0.24,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 5),
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ProfilePic(
                              profile: pl[index]['partnerPic'].toString(),
                              name: pl[index]['name'].toString(),
                              size: height(context) * 0.05,
                            ),
                            SizedBox(
                              width: width(context) * 0.07,
                            ),
                            Container(
                              height: height(context) * 0.11,
                              width: width(context) * 0.5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          TextWidget(
                                            text: toBeginningOfSentenceCase(
                                                  pl[index]['name'],
                                                ) ??
                                                "",
                                            size: width(context) * 0.04,
                                            weight: FontWeight.w600,
                                            color: SpotmiesTheme.onBackground,
                                          )
                                        ],
                                      ),
                                      Container(
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                              text: up?.getServiceNameById(
                                                      pl[index]['job']) +
                                                  ' | ',
                                              size: width(context) * 0.025,
                                              weight: FontWeight.w600,
                                              color: SpotmiesTheme.equal,
                                            ),
                                            TextWidget(
                                              // text:
                                              //     avg(pl['rate'])
                                              //         .toString(),
                                              text: '4.5',
                                              size: width(context) * 0.025,
                                              weight: FontWeight.w600,
                                              color: SpotmiesTheme.equal,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: width(context) * 0.025,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: Row(
                                        children: ['telugu', 'Hindi', 'English']
                                            .map((lang) => Container(
                                                  child: TextWid(
                                                    text: lang + "  ",
                                                    size:
                                                        width(context) * 0.026,
                                                    weight: FontWeight.w600,
                                                    color: SpotmiesTheme
                                                        .onBackground,
                                                  ),
                                                ))
                                            .toList()),
                                  ),
                                  Container(
                                    width: width(context) * 0.45,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_pin,
                                          size: width(context) * 0.03,
                                          color: SpotmiesTheme.onBackground,
                                        ),
                                        TextWid(
                                          text: 'vizag',
                                          size: width(context) * 0.03,
                                          weight: FontWeight.w600,
                                          color: SpotmiesTheme.onBackground,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: height(context) * 0.01,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     InkWell(
                    //       onTap: () {},
                    //       child: Row(
                    //         children: [
                    //           CircleAvatar(
                    //             radius: width(context) * 0.06,
                    //             backgroundColor: SpotmiesTheme.dull,
                    //             child: Icon(
                    //               Icons.call,
                    //               color: SpotmiesTheme.onBackground,
                    //               size: width(context) * 0.05,
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             width: height(context) * 0.02,
                    //           ),
                    //           TextWidget(
                    //             text: 'Call',
                    //             size: width(context) * 0.04,
                    //             weight: FontWeight.w600,
                    //             color: SpotmiesTheme.onBackground,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         // chatWithPatner(orderDetails);
                    //       },
                    //       child: Row(
                    //         children: [
                    //           CircleAvatar(
                    //             radius: width(context) * 0.06,
                    //             backgroundColor: SpotmiesTheme.dull,
                    //             child: Icon(
                    //               Icons.chat_bubble,
                    //               color: SpotmiesTheme.onBackground,
                    //               size: width(context) * 0.05,
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             width: height(context) * 0.02,
                    //           ),
                    //           TextWidget(
                    //             text: 'Message',
                    //             size: width(context) * 0.04,
                    //             weight: FontWeight.w600,
                    //             color: SpotmiesTheme.onBackground,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

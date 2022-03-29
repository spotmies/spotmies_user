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
import 'package:spotmies/views/reusable_widgets/partner_details/partner_store.dart';
import 'package:spotmies/views/reusable_widgets/profile_pic.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

import '../../chat/chatapp/personal_chat.dart';
import '../calling_wid.dart';

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
    up?.fetchPartnerList(0, 8);
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
          color: SpotmiesTheme.background,
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
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(bottom: 8),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PartnerStore(
                                    pid: pl[index]['pId'],
                                  )));
                        },
                        isThreeLine: true,
                        leading: ProfilePic(
                          profile: pl[index]['partnerPic'].toString(),
                          name: pl[index]['name'].toString(),
                          size: height(context) * 0.035,
                        ),
                        trailing: Container(
                          width: width(context) * 0.27,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => PersonalChat(
                                                  '1234',
                                                  pId: pl[index]['pId'],
                                                  pDetails: pl[index]['_id'],
                                                  normalChat: true,
                                                  name: pl[index]['name'],
                                                )));
                                  },
                                  icon: Icon(
                                    Icons.chat,
                                    size: width(context) * 0.04,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    calling(
                                        context,
                                        pl[index]["phNum"].toString(),
                                        pl[index]['pId'].toString(),
                                        pl[index]['partnerPic'],
                                        pl[index]['name'],
                                        pl[index]['partnerDeviceToken']);
                                  },
                                  icon: Icon(
                                    Icons.call,
                                    size: width(context) * 0.04,
                                  ))
                            ],
                          ),
                        ),
                        title: TextWidget(
                          text: toBeginningOfSentenceCase(
                                pl[index]['name'],
                              ) ??
                              "",
                          size: width(context) * 0.045,
                          weight: FontWeight.w600,
                          color: SpotmiesTheme.onBackground,
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text:
                                      up?.getServiceNameById(pl[index]['job']) +
                                          ' | ',
                                  size: width(context) * 0.025,
                                  weight: FontWeight.w600,
                                  color: SpotmiesTheme.equal,
                                ),
                                TextWidget(
                                  text: pl[index]['rate'].isEmpty
                                      ? "5.0"
                                      : avg(pl[index]['rate']).toString(),
                                  // text: '4.5',
                                  size: width(context) * 0.025,
                                  weight: FontWeight.w600,
                                  color: SpotmiesTheme.equal,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: width(context) * 0.035,
                                )
                              ],
                            ),
                            Container(
                              // color: Colors.amber,
                              height: height(context) * 0.02,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: pl[index]['lang'].length,
                                  itemBuilder: (context, i) {
                                    return TextWid(
                                      text: pl[index]['lang'][i] + "  ",
                                      size: width(context) * 0.026,
                                      weight: FontWeight.w600,
                                      color: SpotmiesTheme.onBackground,
                                    );
                                  }),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.business,
                                  size: width(context) * 0.03,
                                  color: SpotmiesTheme.onBackground,
                                ),
                                SizedBox(
                                  width: width(context) * 0.02,
                                ),
                                Container(
                                  width: width(context) * 0.3,
                                  child: TextWid(
                                    text: pl[index]['businessName'] == ""
                                        ? "Visakhaptnam"
                                        : pl[index]['businessName'],
                                    size: width(context) * 0.03,
                                    weight: FontWeight.w600,
                                    color: SpotmiesTheme.onBackground,
                                    flow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: width(context) * 0.15,
                        endIndent: width(context) * 0.15,
                      )
                    ],
                  ),
                );
              }
              // return InkWell(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => PartnerStore(
              //               pid: pl[index]['pId'],
              //             )));
              //   },
              //   child: Container(
              //     // height: hight * 0.24,
              //     padding: EdgeInsets.all(3),
              //     margin: EdgeInsets.only(bottom: 0),
              //     child: Column(
              //       children: [
              //         Container(
              //             // color: Colors.amber,
              //             padding: EdgeInsets.only(
              //                 left: width(context) * 0.05,
              //                 right: width(context) * 0.05,
              //                 top: width(context) * 0.01),
              //             child: Row(
              //               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 ProfilePic(
              //                   profile: pl[index]['partnerPic'].toString(),
              //                   name: pl[index]['name'].toString(),
              //                   size: height(context) * 0.035,
              //                 ),
              //                 SizedBox(
              //                   width: width(context) * 0.07,
              //                 ),
              //                 Container(
              //                   height: height(context) * 0.10,
              //                   width: width(context) * 0.6,
              //                   // color: Colors.amber,
              //                   child: Column(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceEvenly,
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Column(
              //                         children: [
              //                           // Row(
              //                           //   mainAxisAlignment:
              //                           //       MainAxisAlignment.start,
              //                           //   children: [
              //                           //     RatingStarField(
              //                           //       filledState: (pl[index]['rate']
              //                           //                   .isEmpty
              //                           //               ? 5.0
              //                           //               : avg(pl[index]['rate']))
              //                           //           .round(),
              //                           //     ),
              //                           //   ],
              //                           // ),
              //                           Row(
              //                             children: [
              //                               TextWidget(
              //                                 text: toBeginningOfSentenceCase(
              //                                       pl[index]['name'],
              //                                     ) ??
              //                                     "",
              //                                 size: width(context) * 0.055,
              //                                 weight: FontWeight.w600,
              //                                 color: SpotmiesTheme.onBackground,
              //                               )
              //                             ],
              //                           ),
              //                           SizedBox(
              //                             height: height(context) * 0.005,
              //                           ),
              //                           Container(
              //                             child: Row(
              //                               // mainAxisAlignment: MainAxisAlignment.start,
              //                               children: [
              //                                 TextWidget(
              //                                   text: up?.getServiceNameById(
              //                                           pl[index]['job']) +
              //                                       ' | ',
              //                                   size: width(context) * 0.035,
              //                                   weight: FontWeight.w600,
              //                                   color: SpotmiesTheme.equal,
              //                                 ),
              //                                 TextWidget(
              //                                   text: pl[index]['rate'].isEmpty
              //                                       ? "5.0"
              //                                       : avg(pl[index]['rate'])
              //                                           .toString(),
              //                                   // text: '4.5',
              //                                   size: width(context) * 0.035,
              //                                   weight: FontWeight.w600,
              //                                   color: SpotmiesTheme.equal,
              //                                 ),
              //                                 Icon(
              //                                   Icons.star,
              //                                   color: Colors.amber,
              //                                   size: width(context) * 0.035,
              //                                 )
              //                               ],
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                       SizedBox(
              //                         height: height(context) * 0.005,
              //                       ),

              //                       // Container(
              //                       //   // color: Colors.amber,
              //                       //   height: height(context) * 0.02,
              //                       //   child: ListView.builder(
              //                       //       scrollDirection: Axis.horizontal,
              //                       //       itemCount: pl[index]['lang'].length,
              //                       //       itemBuilder: (context, i) {
              //                       //         return TextWid(
              //                       //           text: pl[index]['lang'][i] + "  ",
              //                       //           size: width(context) * 0.026,
              //                       //           weight: FontWeight.w600,
              //                       //           color: SpotmiesTheme.onBackground,
              //                       //         );
              //                       //       }),
              //                       // ),
              //                       // Container(
              //                       //   width: width(context) * 0.45,
              //                       //   height: height(context) * 0.025,
              //                       //   // color: Colors.amber,
              //                       //   child: Row(
              //                       //     children: [
              //                       //       Icon(
              //                       //         Icons.business,
              //                       //         size: width(context) * 0.03,
              //                       //         color: SpotmiesTheme.onBackground,
              //                       //       ),
              //                       //       SizedBox(
              //                       //         width: width(context) * 0.02,
              //                       //       ),
              //                       //       TextWid(
              //                       //         text:
              //                       //             pl[index]['businessName'] == ""
              //                       //                 ? "Visakhaptnam"
              //                       //                 : pl[index]['businessName'],
              //                       //         size: width(context) * 0.03,
              //                       //         weight: FontWeight.w600,
              //                       //         color: SpotmiesTheme.onBackground,
              //                       //       ),
              //                       //     ],
              //                       //   ),
              //                       // ),
              //                     ],
              //                   ),
              //                 )
              //               ],
              //             )),
              //         SizedBox(
              //           height: height(context) * 0.01,
              //         ),
              //         // Row(
              //         //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         //   children: [
              //         //     InkWell(
              //         //       onTap: () {},
              //         //       child: Row(
              //         //         children: [
              //         //           CircleAvatar(
              //         //             radius: width(context) * 0.06,
              //         //             backgroundColor: SpotmiesTheme.dull,
              //         //             child: Icon(
              //         //               Icons.call,
              //         //               color: SpotmiesTheme.onBackground,
              //         //               size: width(context) * 0.05,
              //         //             ),
              //         //           ),
              //         //           SizedBox(
              //         //             width: height(context) * 0.02,
              //         //           ),
              //         //           TextWidget(
              //         //             text: 'Call',
              //         //             size: width(context) * 0.04,
              //         //             weight: FontWeight.w600,
              //         //             color: SpotmiesTheme.onBackground,
              //         //           ),
              //         //         ],
              //         //       ),
              //         //     ),
              //         //     InkWell(
              //         //       onTap: () {
              //         //         // chatWithPatner(orderDetails);
              //         //       },
              //         //       child: Row(
              //         //         children: [
              //         //           CircleAvatar(
              //         //             radius: width(context) * 0.06,
              //         //             backgroundColor: SpotmiesTheme.dull,
              //         //             child: Icon(
              //         //               Icons.chat_bubble,
              //         //               color: SpotmiesTheme.onBackground,
              //         //               size: width(context) * 0.05,
              //         //             ),
              //         //           ),
              //         //           SizedBox(
              //         //             width: height(context) * 0.02,
              //         //           ),
              //         //           TextWidget(
              //         //             text: 'Message',
              //         //             size: width(context) * 0.04,
              //         //             weight: FontWeight.w600,
              //         //             color: SpotmiesTheme.onBackground,
              //         //           ),
              //         //         ],
              //         //       ),
              //         //     ),
              //         //   ],
              //         // ),
              //       ],
              //     ),
              //   ),
              // );

              ),
        );
      }),
    );
  }
}

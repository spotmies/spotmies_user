import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/progressIndicator.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/views/home/ads/adpost.dart';
import 'package:spotmies/views/home/data.dart';
import 'package:spotmies/views/home/searchJobs/search.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class CatelogOverView extends StatefulWidget {
  final dynamic service;
  final int? index;
  final Color? color;
  const CatelogOverView({Key? key, this.service, this.index, this.color})
      : super(key: key);

  @override
  State<CatelogOverView> createState() => _CatelogOverViewState();
}

class _CatelogOverViewState extends State<CatelogOverView> {
  UniversalProvider? up;
  ScrollController? scrollController = ScrollController();
  @override
  void initState() {
    up = Provider.of<UniversalProvider>(context, listen: false);
    up?.fetchCatelogList(0, 8, widget.service["serviceId"]);
    scrollController?.addListener(() {
      if (scrollController?.position.pixels ==
          scrollController?.position.maxScrollExtent) {
        getMoreData();
      }
    });
    log("38     ----->      ${up?.catelogList}");
    super.initState();
  }

  getMoreData() {
    up?.fetchCatelogList(
        up?.catelogList.length, 2, widget.service["serviceId"]);
    log('message');
  }

  eraseData() {
    Navigator.pop(context);
    up?.catelogList.clear();
  }

  @override
  Widget build(BuildContext context) {
    // log(widget.service.toString());
    return WillPopScope(
      onWillPop: () async {
        eraseData();
        return true;
      },
      child: Consumer<UniversalProvider>(builder: (context, data, child) {
        dynamic cat = data.catelogList;
        if (cat == null) {
          circleProgress();
        }
        return Scaffold(
          backgroundColor: widget.color,
          body: ListView(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: height(context) * 0.29,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                            left: width(context) * 0.05,
                            top: width(context) * 0.05,
                          ),
                          height: height(context) * 0.2,
                          width: width(context) * 0.9,
                          decoration: BoxDecoration(
                              color: SpotmiesTheme.background,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWid(
                                text: widget.service['nameOfService'],
                                size: width(context) * 0.05,
                                weight: FontWeight.w600,
                                color: SpotmiesTheme.onBackground,
                              ),
                              SizedBox(
                                height: height(context) * 0.01,
                              ),
                              SizedBox(
                                width: width(context) * 0.5,
                                child: TextWid(
                                  text:
                                      'wertyuiop bsdjhbuisad ivuusd jbdfj bhsadf ibdfhsd f hjdbfhusad  vhdbsyuhfbfysad bvudsbvsad  byuf v',
                                  size: width(context) * 0.04,
                                  weight: FontWeight.w400,
                                  flow: TextOverflow.visible,
                                  color: SpotmiesTheme.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Container(
                                  height: height(context) * 0.17,
                                  width: width(context) * 0.5,
                                  // color: Colors.amber,
                                  child: SvgPicture.asset(
                                      catImages[widget.index!])),
                              SizedBox(
                                height: height(context) * 0.03,
                              ),
                              Container(
                                height: height(context) * 0.01,
                                width: width(context) * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: widget.color,
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                  Container(
                    height: height(context) * 0.75,
                    width: width(context) * 0.9,
                    padding: EdgeInsets.all(width(context) * 0.05),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: SpotmiesTheme.background),
                    child: Column(
                      children: [
                        TextWid(
                          text: 'Choose service',
                          size: width(context) * 0.05,
                          weight: FontWeight.w600,
                        ),
                        Container(
                          height: height(context) * 0.67,
                          padding: EdgeInsets.only(top: width(context) * 0.03),
                          child: ListView.builder(
                              itemCount: cat.length,
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                return Container(
                                  // height: height(context) * 0.08,
                                  // width: width(context) * 0.8,
                                  margin: EdgeInsets.all(width(context) * 0.01),
                                  // padding: EdgeInsets.all(width(context) * 0.05),
                                  decoration: BoxDecoration(
                                      color: SpotmiesTheme.surfaceVariant,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PostAd(
                                                  sid: widget
                                                      .service['serviceId'])));
                                    },
                                    title: TextWid(
                                      text: cat[index]["name"],
                                      size: width(context) * 0.05,
                                      weight: FontWeight.w400,
                                    ),
                                    leading: Icon(Icons.work),
                                    trailing: Icon(Icons.arrow_forward),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

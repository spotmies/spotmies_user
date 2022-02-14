import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/progressIndicator.dart';
import 'package:spotmies/views/reusable_widgets/partner_details/partner.dart';
import 'package:spotmies/views/reusable_widgets/partner_details/partner_list.dart';
import 'package:spotmies/views/reusable_widgets/partner_details/rating_starfield.dart';
import 'package:spotmies/views/home/banner.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class PartnerStore extends StatefulWidget {
  final String? pid;
  const PartnerStore({Key? key, this.pid}) : super(key: key);

  @override
  _PartnerStoreState createState() => _PartnerStoreState();
}

UniversalProvider? up = UniversalProvider();
late TabController _tabController;
var _controller = ScrollController();
var isDrawingLayout = true;

class _PartnerStoreState extends State<PartnerStore>
    with TickerProviderStateMixin {
  @override
  void initState() {
    up = Provider.of<UniversalProvider>(context, listen: false);
    up?.fetchPartnerStore(widget.pid);
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        isDrawingLayout = false;
      });
    });
    _controller.addListener(() {
      setState(() {});
    });
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UniversalProvider>(builder: (context, data, child) {
      dynamic ps = data.partnerStore;

      log(ps.toString());
      if (ps == null) {
        return circleProgress();
      }
      return Scaffold(
        body: CustomScrollView(
          // physics: NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: SpotmiesTheme.background,
              // centerTitle: true,
              pinned: true,
              floating: true,
              automaticallyImplyLeading: false,
              expandedHeight: height(context) * 0.39,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: SpotmiesTheme.onBackground,
                  )),
              title: TextWid(
                text: 'Partner Store Details',
                color: SpotmiesTheme.onBackground,
                size: width(context) * 0.05,
                weight: FontWeight.w600,
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: height(context) * 0.16,
                      // color: Colors.amber,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width(context) * 0.05,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              ps['partnerPic'],
                              fit: BoxFit.cover,
                              height: height(context) * 0.13,
                              width: height(context) * 0.13,
                            ),
                          ),
                          SizedBox(
                            width: width(context) * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWid(
                                text: toBeginningOfSentenceCase(ps['name'])
                                    .toString(),
                                size: width(context) * 0.06,
                                weight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: height(context) * 0.005,
                              ),
                              TextWid(
                                text: toBeginningOfSentenceCase(
                                        up?.getServiceNameById(ps['job']))
                                    .toString(),
                                size: width(context) * 0.04,
                                weight: FontWeight.w400,
                              ),
                              SizedBox(
                                height: height(context) * 0.02,
                              ),
                              SizedBox(
                                width: width(context) * 0.65,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButtonWidget(
                                      minWidth: width(context) * 0.30,
                                      height: height(context) * 0.04,
                                      bgColor: SpotmiesTheme.background,
                                      // onClick: onClick,
                                      onClick: () {},
                                      buttonName: 'Call',
                                      textColor: SpotmiesTheme.onBackground,
                                      borderRadius: 10.0,
                                      textSize: width(context) * 0.035,
                                      leadingIcon: Icon(
                                        Icons.call,
                                        size: width(context) * 0.035,
                                        color: SpotmiesTheme.onBackground,
                                      ),
                                      borderSideColor: SpotmiesTheme.background,
                                    ),
                                    ElevatedButtonWidget(
                                      minWidth: width(context) * 0.30,
                                      height: height(context) * 0.04,
                                      bgColor: SpotmiesTheme.background,
                                      // onClick: onClick,
                                      onClick: () {},
                                      buttonName: 'Message',
                                      textColor: SpotmiesTheme.onBackground,
                                      borderRadius: 10.0,
                                      textSize: width(context) * 0.035,
                                      trailingIcon: Icon(
                                        Icons.chat_bubble,
                                        size: width(context) * 0.035,
                                        color: SpotmiesTheme.onBackground,
                                      ),
                                      borderSideColor: SpotmiesTheme.background,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width(context) * 0.8,
                      padding: EdgeInsets.only(bottom: width(context) * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              TextWid(
                                text: 'Completed'.toString(),
                                size: width(context) * 0.03,
                                weight: FontWeight.w400,
                              ),
                              SizedBox(
                                height: height(context) * 0.01,
                              ),
                              TextWid(
                                text: ps['orders'].length.toString(),
                                size: width(context) * 0.05,
                                weight: FontWeight.w600,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              TextWid(
                                text: 'Rating'.toString(),
                                size: width(context) * 0.03,
                                weight: FontWeight.w400,
                              ),
                              SizedBox(
                                height: height(context) * 0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWid(
                                    text: avg(ps['rate']).toString(),
                                    size: width(context) * 0.05,
                                    weight: FontWeight.w600,
                                  ),
                                  Icon(
                                    Icons.star_rounded,
                                    size: width(context) * 0.05,
                                    color: Colors.amber,
                                  )
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              TextWid(
                                text: 'Services'.toString(),
                                size: width(context) * 0.03,
                                weight: FontWeight.w400,
                              ),
                              SizedBox(
                                height: height(context) * 0.01,
                              ),
                              TextWid(
                                text: ps['catelogs'].length.toString(),
                                size: width(context) * 0.05,
                                weight: FontWeight.w600,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height(context) * 0.06,
                    )
                  ],
                ),
              ),
              bottom: TabBar(
                indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 2, color: SpotmiesTheme.onBackground),
                    insets: EdgeInsets.symmetric(
                        horizontal: width(context) * 0.05)),
                unselectedLabelColor: SpotmiesTheme.equal,
                labelStyle: GoogleFonts.josefinSans(
                    fontSize: width(context) * 0.045,
                    fontWeight: FontWeight.w600),
                labelColor: SpotmiesTheme.onBackground,
                tabs: const [
                  Tab(
                    text: "Catalogues",
                  ),
                  Tab(
                    text: "Reviews",
                  )
                ],
                controller: _tabController,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: SpotmiesTheme.background,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        children: [
                          Container(
                            width: width(context),
                            height: height(context) * 0.6,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: ps['rate'].length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        ps['rate'][index]['uDetails']['pic']
                                            .toString(),
                                        width: width(context) * 0.1,
                                        height: width(context) * 0.1,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    onTap: () {},
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWid(
                                            text: toBeginningOfSentenceCase(
                                                    ps['rate'][index]
                                                        ['uDetails']['name'])
                                                .toString(),
                                            weight: FontWeight.w600,
                                            size: width(context) * 0.04),
                                        RatingStarField(
                                          filledState:
                                              (ps['rate'][index]['rating'] / 20)
                                                  .round(),
                                        )
                                      ],
                                    ),
                                    subtitle: TextWid(
                                      text: toBeginningOfSentenceCase(
                                              ps['rate'][index]['description'])
                                          .toString(),
                                      size: width(context) * 0.035,
                                    ),
                                  );
                                }),
                          ),
                          Container(
                            width: width(context),
                            height: height(context) * 0.6,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: ps['rate'].length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        ps['rate'][index]['uDetails']['pic']
                                            .toString(),
                                        width: width(context) * 0.1,
                                        height: width(context) * 0.1,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    onTap: () {},
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWid(
                                            text: toBeginningOfSentenceCase(
                                                    ps['rate'][index]['uDetails']
                                                        ['name'])
                                                .toString(),
                                            weight: FontWeight.w600,
                                            size: width(context) * 0.04),
                                        RatingStarField(
                                          filledState:
                                              (ps['rate'][index]['rating'] / 20)
                                                  .round(),
                                        )
                                      ],
                                    ),
                                    subtitle: TextWid(
                                      text: toBeginningOfSentenceCase(
                                              ps['rate'][index]['description'])
                                          .toString(),
                                      size: width(context) * 0.035,
                                    ),
                                  );
                                }),
                          )
                        ],
                        controller: _tabController,
                      ),
                    )
                  ],
                ),
                height: height(context) * 1.5,
              ),
            )
          ],
        ),
      );
    });
  }
}

avg(
  List<dynamic>? args,
) {
  int sum = 0;
  List avg = args!;

  for (var i = 0; i < avg.length; i++) {
    if (avg[i]['rating'] != null) {
      sum += avg[i]['rating'] as int;
    } else {
      sum += 100;
    }
  }
  int rate = (sum / avg.length).round();

  return rate / 20;
}

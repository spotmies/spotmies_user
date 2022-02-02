import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/home_controllers/home_controller.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/views/home/ServiceListVertical.dart';
import 'package:spotmies/views/home/searchJobs/search.dart';
import 'package:spotmies/views/home/serviceListHorizontal.dart';
import 'package:spotmies/views/profile/profilePic.dart';
import 'package:spotmies/views/reusable_widgets/profile_pic.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends StateMVC<Home> {
  late HomeController _homeController;
  late UniversalProvider up;

  _HomeState() : super(HomeController()) {
    this._homeController = controller as HomeController;
  }

  List images = [
    'assets/uploadPic.svg',
    'assets/setLocation.svg',
    'assets/getQuotes.svg',
    'assets/getService.svg',
  ];
  List titles = [
    'Take a Picture',
    'Set a Location',
    'Get Quotes',
    'Get Service'
  ];

  List icons = [
    Icons.phone_iphone,
    Icons.campaign,
    Icons.architecture,
    Icons.photo_camera,
    Icons.laptop_mac,
    Icons.more_horiz,
  ];
  List serviceNames = [
    'App\ndeveloper',
    'Google\ncampaigns',
    'Logo\ndesigner',
    'Photo shoot',
    'Computer\nservices',
    'More',
  ];

  List<Map<String, Object>> tradesman = [
    {
      "job": "Electrcian",
      "icon": Icons.electrical_services,
      "desc": 'Light,Fan,Wiring,etc.,'
    },
    {
      "job": "Plumber",
      "icon": Icons.plumbing,
      "desc": 'Motor,Water,pipes,etc.,'
    },
    {"job": "Painter", "icon": Icons.brush, "desc": 'Wall Paint,grafity,etc.,'},
    {
      "job": "Chef",
      "icon": Icons.coffee,
      "desc": 'Indian,Chineese,contenental,etc.,'
    },
    {
      "job": "Electrcian",
      "icon": Icons.electrical_services,
      "desc": 'Light,Fan,Wiring,etc.,'
    },
    {
      "job": "Plumber",
      "icon": Icons.plumbing,
      "desc": 'Motor,Water,pipes,etc.,'
    },
    {"job": "Painter", "icon": Icons.brush, "desc": 'Wall Paint,grafity,etc.,'},
    {
      "job": "Chef",
      "icon": Icons.coffee,
      "desc": 'Indian,Chineese,contenental,etc.,'
    },
  ];

  @override
  void initState() {
    up = Provider.of<UniversalProvider>(context, listen: false);
    up.setCurrentConstants("home");
    _homeController.getAddressofLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List color = [
      SpotmiesTheme.light1,
      SpotmiesTheme.light2,
      SpotmiesTheme.light3,
      SpotmiesTheme.light4,
      SpotmiesTheme.light1,
      SpotmiesTheme.light2,
      SpotmiesTheme.light3,
      SpotmiesTheme.light4,
      SpotmiesTheme.light1,
      SpotmiesTheme.light2,
      SpotmiesTheme.light3,
      SpotmiesTheme.light4,
      SpotmiesTheme.light1,
      SpotmiesTheme.light2,
      SpotmiesTheme.light3,
      SpotmiesTheme.light4,
      SpotmiesTheme.light1,
      SpotmiesTheme.light2,
      SpotmiesTheme.light3,
      SpotmiesTheme.light4,
    ];
    //getToken();
    // final height(context) = MediaQuery.of(context).size.height -
    //     MediaQuery.of(context).padding.top -
    //     kToolbarHeight;
    // final width(context) = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: SpotmiesTheme.background,
        appBar: AppBar(
          backgroundColor: SpotmiesTheme.background,
          leading: Icon(
            Icons.location_searching,
            color: SpotmiesTheme.primary,
            size: width(context) * 0.05,
          ),
          elevation: 0,
          title: Container(
            width: width(context) * 0.5,
            child: InkWell(
              onTap: () async {
                await _homeController.getAddressofLocation();
              },
              child: Text(
                  (_homeController.add2 == null)
                      ? 'seethammadhara'
                      : _homeController.add2!,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.josefinSans(
                    fontSize: width(context) * 0.045,
                    fontWeight: FontWeight.bold,
                    color: SpotmiesTheme.primary,
                  )),
            ),
          ),
          actions: [
            Container(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FilterLocalListPage()));
                  },
                  icon: Icon(
                    Icons.search,
                    color: SpotmiesTheme.primary,
                  ),
                )),
            Container(
                padding: EdgeInsets.only(right: 10),
                child: profilePic(context, null, 'u', width(context) * 0.1,
                    edit: false)),
          ],
        ),
        body: ListView(
          children: [
            processSteps(context, images, titles, color),
            popularServices(context, icons, serviceNames),
            categeries(context, color),
          ],
        ));
  }
}

categeries(BuildContext context, List colors) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.only(left: width(context) * 0.075),
        alignment: Alignment.centerLeft,
        // color: Colors.amber,
        height: height(context) * 0.07,
        width: width(context),
        child: TextWid(
          text: 'Categories',
          size: width(context) * 0.06,
          weight: FontWeight.w600,
        ),
      ),
      Container(
        height: height(context) * 0.25,
        child: ListView.builder(
            padding: EdgeInsets.only(left: width(context) * 0.04),
            itemCount: catNames.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: width(context) * 0.03),
                    decoration: BoxDecoration(
                        // color: Colors.grey,
                        ),
                    child: InkWell(
                      onTap: () {
                        DefaultTabController.of(context)?.animateTo(index + 1);
                      },
                      child: Container(
                          height: height(context) * 0.2,
                          width: width(context) * 0.33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: colors[index + 1],
                            // gradient: LinearGradient(
                            //     colors: [
                            //       SpotmiesTheme.primary,
                            //       SpotmiesTheme.tertiaryVariant

                            //       // ([Colors.green[100],Colors.pink[100],Colors]..shuffle()).first,
                            //       // Colors.green[100]
                            //     ],
                            //     begin: const FractionalOffset(0.0, 0.5),
                            //     end: const FractionalOffset(0.5, 0.0),
                            //     stops: [0.0, 1.0],
                            //     tileMode: TileMode.clamp),
                          ),
                          padding: EdgeInsets.only(top: 15, left: 7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWid(
                                text: catNames[index],
                                size: width(context) * 0.04,
                                weight: FontWeight.w500,
                                color: SpotmiesTheme.onBackground,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                  height: height(context) * 0.12,
                                  // width: width * 0.23,
                                  child: SvgPicture.asset(catImages[index])),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextWid(
                                      text: 'Explore',
                                      size: width(context) * 0.03,
                                      weight: FontWeight.w700,
                                      color: SpotmiesTheme.onBackground,
                                    ),
                                    Icon(
                                      Icons.double_arrow,
                                      size: width(context) * 0.04,
                                      color: SpotmiesTheme.onBackground,
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
      ),
    ],
  );
}

popularServices(BuildContext context, List icons, List serviceNames) {
  return Container(
    // alignment: Alignment.center,
    height: height(context) * 0.44,
    width: width(context),
    // color: Colors.amber,

    child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: width(context) * 0.075),
          alignment: Alignment.centerLeft,
          // color: Colors.amber,
          height: height(context) * 0.07,
          width: width(context),
          child: TextWid(
            text: 'Popular services',
            size: width(context) * 0.06,
            weight: FontWeight.w600,
          ),
        ),
        Container(
          height: height(context) * 0.35,
          // color: Colors.amber,
          child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: icons.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return Container(
                  height: height(context) * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        icons[index],
                        color: SpotmiesTheme.onBackground,
                      ),
                      TextWid(
                        text: serviceNames[index],
                        align: TextAlign.center,
                        color: SpotmiesTheme.onBackground,
                      )
                    ],
                  ),
                );
              }),
        ),
      ],
    ),
  );
}

processSteps(BuildContext context, images, titles, color) {
  return Container(
    height: height(context) * 0.22,
    width: width(context),
    child: ListView.builder(
        padding: EdgeInsets.only(
            right: width(context) * 0.02, left: width(context) * 0.02),
        itemCount: images.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Container(
                padding: EdgeInsets.all(
                  width(context) * 0.05,
                ),
                height: height(context) * 0.18,
                width: width(context) * 0.86,
                decoration: BoxDecoration(
                    color: color[index],
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWid(
                          text: titles[index],
                          size: width(context) * 0.06,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: height(context) * 0.01,
                        ),
                        TextWid(
                          text: 'Step ${index + 1}',
                          size: width(context) * 0.045,
                          color: SpotmiesTheme.secondary,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: height(context) * 0.02,
                        ),
                        ElevatedButtonWidget(
                          buttonName: 'Next',
                          bgColor: SpotmiesTheme.primary,
                          borderSideColor: SpotmiesTheme.primary,
                          textColor: SpotmiesTheme.background,
                          height: height(context) * 0.03,
                          minWidth: width(context) * 0.25,
                          textSize: width(context) * 0.03,
                          trailingIcon: Icon(
                            Icons.arrow_forward_ios,
                            size: width(context) * 0.03,
                            color: SpotmiesTheme.background,
                          ),
                          borderRadius: 5.0,
                        )
                      ],
                    ),
                    Container(
                        width: width(context) * 0.35,
                        child: SvgPicture.asset(
                          images[index],
                        ))
                  ],
                ),
              ),
              SizedBox(
                width: width(context) * 0.05,
              )
            ],
          );
        }),
  );
}

//default tab controller(length:8)

// var list = [
  //   Center(
  //     child: Services(value: 0),
  //   ),
  //   Center(
  //     child: Services(value: 1),
  //   ),
  //   Center(
  //     child: Services(value: 2),
  //   ),
  //   Center(
  //     child: Services(value: 3),
  //   ),
  //   Center(
  //     child: Services(value: 4),
  //   ),
  //   Center(
  //     child: Services(value: 5),
  //   ),
  //   Center(
  //     child: Services(value: 6),
  //   ),
  //   Center(
  //     child: Services(value: 7),
  //   ),
  // ];
 // bottom: PreferredSize(
          //   preferredSize: Size.fromHeight(height(context) * 0.09),
          //   child: Container(
          //     height: height(context) * 0.06,
          //     padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
          //     child: TextWid(
          //       text: 'Home',
          //       align: TextAlign.start,
          //     ),
          //     // child: TabBar(
          //     //     isScrollable: true,
          //     //     unselectedLabelColor: Colors.grey[600],
          //     //     indicatorSize: TabBarIndicatorSize.tab,
          //     //     indicatorWeight: 0,
          //     //     indicator: BoxDecoration(
          //     //         borderRadius: BorderRadius.circular(5),
          //     //         color: SpotmiesTheme.primary),
          //     //     labelStyle: fonts(
          //     //         width(context) * 0.04, FontWeight.w600, Colors.white),
          //     //     tabs: [
          //     //       Tab(
          //     //         icon: Center(
          //     //           child: Text('All Services'),
          //     //         ),
          //     //       ),
          //     //       Tab(
          //     //         icon: Center(
          //     //           child: Text('Tradesman Services'),
          //     //         ),
          //     //       ),
          //     //       Tab(
          //     //         icon: Center(
          //     //           child: Text('Personal Care'),
          //     //         ),
          //     //       ),
          //     //       Tab(
          //     //         icon: Center(
          //     //           child: Text('Domestic'),
          //     //         ),
          //     //       ),
          //     //       Tab(
          //     //         icon: Center(
          //     //           child: Text('Software'),
          //     //         ),
          //     //       ),
          //     //       Tab(
          //     //         icon: Center(
          //     //           child: Text('Designing'),
          //     //         ),
          //     //       ),
          //     //       Tab(
          //     //         icon: Center(
          //     //           child: Text('Education'),
          //     //         ),
          //     //       ),
          //     //       Tab(
          //     //         icon: Center(
          //     //           child: Text('Filming'),
          //     //         ),
          //     //       ),
          //     //     ]),
          //   ),
          // ),
          // body: TabBarView(children: list),

// body: CustomScrollView(
        //   physics: const BouncingScrollPhysics(
        //       parent: AlwaysScrollableScrollPhysics()),
        //   slivers: [
        //     SliverAppBar(
        //       elevation: 0,
        //       stretch: true,
        //       backgroundColor: SpotmiesTheme.background,
        //       leading: Icon(
        //         Icons.location_searching,
        //         color: SpotmiesTheme.primary,
        //         size: width(context) * 0.05,
        //       ),
        //       onStretchTrigger: () {
        //         return Future<void>.value();
        //       },
        //       pinned: true,
        //       snap: false,
        //       floating: true,
        //       expandedHeight: height(context) * 0.18,
        //       title: Container(
        //         width: width(context) * 0.5,
        //         child: InkWell(
        //           onTap: () async {
        //             await _homeController.getAddressofLocation();
        //           },
        //           child: Text(
        //               (_homeController.add2 == null)
        //                   ? 'seethammadhara'
        //                   : _homeController.add2!,
        //               overflow: TextOverflow.ellipsis,
        //               textAlign: TextAlign.left,
        //               style: GoogleFonts.josefinSans(
        //                 fontSize: width(context) * 0.045,
        //                 fontWeight: FontWeight.bold,
        //                 color: SpotmiesTheme.primary,
        //               )),
        //         ),
        //       ),
        //       actions: [
        //         Container(
        //             padding: EdgeInsets.only(right: 10),
        //             child: IconButton(
        //               onPressed: () {
        //                 Navigator.of(context).push(MaterialPageRoute(
        //                     builder: (context) => FilterLocalListPage()));
        //               },
        //               icon: Icon(
        //                 Icons.search,
        //                 color: SpotmiesTheme.primary,
        //               ),
        //             )),
        //       ],
        //       flexibleSpace: FlexibleSpaceBar(
        //         stretchModes: <StretchMode>[
        //           StretchMode.zoomBackground,
        //           StretchMode.fadeTitle,
        //         ],
        //         background: Column(
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           children: [
        //             Container(
        //               padding: EdgeInsets.only(
        //                   left: width(context) * 0.05,
        //                   right: width(context) * 0.05),
        //               height: height(context) * 0.1,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                     children: [
        //                       TextWid(
        //                         text: 'Welcome, Satish',
        //                         color: SpotmiesTheme.primary,
        //                         size: width(context) * 0.06,
        //                         weight: FontWeight.w600,
        //                       ),
        //                       // TextWid(
        //                       //   text: 'Satish',
        //                       //   color: SpotmiesTheme.primary,
        //                       //   size: width(context) * 0.07,
        //                       //   weight: FontWeight.w500,
        //                       // ),
        //                     ],
        //                   ),
        //                   Container(
        //                       child: profilePic(
        //                           context, null, 'u', width(context) * 0.12,
        //                           edit: false)),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

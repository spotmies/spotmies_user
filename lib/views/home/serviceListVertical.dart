import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/views/home/ServiceListHorizontal.dart';
import 'package:spotmies/views/home/listBuilderVertical.dart';

class Services extends StatefulWidget {
  final int value;

  Services({this.value});

  @override
  _ServicesState createState() => _ServicesState(value);
}

class _ServicesState extends State<Services> {
  UniversalProvider up;
  int value;
  _ServicesState(this.value);

  List images = [
    'assets/uploadPic.svg',
    'assets/setLocation.svg',
    'assets/getQuotes.svg',
    'assets/getService.svg',
  ];
  List titles = [
    'Step 1: Take a Picture',
    'Step 2: Set a Location',
    'Step 3: Get Quotes',
    'Step 4: Get Service'
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

  List<Map<String, Object>> beauty = [
    {"job": "Beauty", "icon": Icons.face, "desc": 'Facial,waxing,tanning,etc'},
    {
      "job": "Spa",
      "icon": Icons.face,
      "desc": 'Massage,Oil Massage,Head Massage,etc'
    },
    {
      "job": "Hair Cut",
      "icon": Icons.face,
      "desc": 'Coluring,HairCut,Hair Treatment,etc'
    },
    {"job": "Tatto", "icon": Icons.face, "desc": 'Tribal,Modern,Classic,etc'},
  ];

  List<Map<String, Object>> software = [
    {
      "job": "Web App",
      "icon": Icons.web,
      "desc": 'Websites,Web Apps,Blogs,etc'
    },
    {
      "job": "Mobile App",
      "icon": Icons.android,
      "desc": 'Mobiles Apps,Mobile Games,etc'
    },
    {
      "job": "Digital Market",
      "icon": Icons.sell,
      "desc": 'SEO,Social Media Marketing,etc'
    },
  ];

  @override
  void initState() {
    up = Provider.of<UniversalProvider>(context, listen: false);
    up.setCurrentConstants("home");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final height(context) = MediaQuery.of(context).size.height -
    //     MediaQuery.of(context).padding.top -
    //     kToolbarHeight;
    // final width(context) = MediaQuery.of(context).size.width;
    if (value == 0) {
      return Container(
        height: height(context),
        padding: EdgeInsets.all(0),
        child: ListView(
          children: [
            Container(
                height: height(context) * 0.30,
                width: width(context) * 0.8,
                padding: EdgeInsets.only(top: 10, bottom: 0),
                child: CarouselSlider.builder(
                  itemCount: images.length,
                  itemBuilder: (ctx, index, realIdx) {
                    return Container(
                      height: height(context) * 0.30,
                      width: width(context) * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300],
                                blurRadius: 5,
                                spreadRadius: 2)
                          ]),
                      // padding: EdgeInsets.only(top: 10, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              height: height(context) * 0.18,
                              width: width(context) * 0.7,
                              padding: EdgeInsets.all(10),
                              child: SvgPicture.asset(images[index])),
                          Text(
                            titles[index],
                            style: fonts(width(context) * 0.05, FontWeight.w600,
                                Colors.grey[900]),
                          )
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 1000),
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                  ),
                )),
            Container(
              child: servicelistBuilder(context, 'Popular Domestic Services',
                  width(context), height(context), tradesman),
            ),
            Container(
              child: serviceBlocksMore(context, 'Categories', width(context),
                  height(context), tradesman),
            ),
            Container(
              child: servicelistBuilder(context, 'Corparate Services',
                  width(context), height(context), software),
            ),
          ],
        ),
      );
    }
    if (value == 1) {
      return Center(
          child: serviceIndividualBuilder(context, 'Tradesman', width(context),
              height(context), tradesman));
    }
    if (value == 2) {
      return Center(
        child: serviceIndividualBuilder(
            context, 'Beauty', width(context), height(context), beauty),
      );
    }
    if (value == 3) {
      return Center(
          child: serviceIndividualBuilder(
              context, 'Domestic', width(context), height(context), tradesman));
    }
    if (value == 4) {
      return Center(
          child: serviceIndividualBuilder(
              context, 'Software', width(context), height(context), software));
    }
    if (value == 5) {
      return Center(
          child: serviceIndividualBuilder(context, 'Designing', width(context),
              height(context), tradesman));
    }
    if (value == 6) {
      return Center(
          child: serviceIndividualBuilder(
              context, 'Education', width(context), height(context), beauty));
    }
    if (value == 7) {
      return Center(
          child: serviceIndividualBuilder(
              context, 'Filming', width(context), height(context), software));
    } else {
      return Container();
    }
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/home_controllers/ad_controll.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/utilities/progressIndicator.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/home/ads/maps.dart';
import 'package:spotmies/views/maps/onLine_placesSearch.dart';
import 'package:spotmies/views/profile/profile_shimmer.dart';
import 'package:spotmies/views/reusable_widgets/audio.dart';
import 'package:spotmies/views/reusable_widgets/pageSlider.dart';

//path for adding post data

class PostAd extends StatefulWidget {
  final int jobFromHome;
  PostAd({this.jobFromHome});
  @override
  _PostAdState createState() => _PostAdState(jobFromHome);
}

class _PostAdState extends StateMVC<PostAd> {
  AdController _adController;
  _PostAdState(this.jobFromHome) : super(AdController()) {
    this._adController = controller;
  }
  int jobFromHome;

  var latitude = "";
  var longitude = "";
  String add1 = "";
  String add2 = "";
  String add3 = "";

  UserDetailsProvider uDetailsProvider;

  @override
  void initState() {
    uDetailsProvider = Provider.of<UserDetailsProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Consumer<UserDetailsProvider>(builder: (context, data, child) {
      // if (data.user == null) return circleProgress();
      var user = data.user;
      if (data.getLoader || user == null)
        return Center(child: profileShimmer(context));
      if(_adController.isUploading) return circleProgress();
      return Scaffold(
          resizeToAvoidBottomInset: false,
          key: _adController.scaffoldkey,
          backgroundColor: Colors.white,
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(children: [
              PageSlider(key: _adController.sliderKey, pages: [
                Container(height: _hight * 1.08, child: ad1(_hight, _width)),
                Container(height: _hight * 1.08, child: ad2(_hight, _width)),
                Container(
                    height: _hight * 1.08, child: ad3(_hight, _width, user)),
              ]),
            ]),
          )));
    });
  }

  steps(
    int step,
    double width,
  ) {
    return Container(
      width: width * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: step == 1 ? width * 0.015 : width * 0.01,
            backgroundColor:
                step == 1 ? Colors.indigo[900] : Colors.indigo[100],
          ),
          CircleAvatar(
            radius: step == 2 ? width * 0.015 : width * 0.01,
            backgroundColor:
                step == 2 ? Colors.indigo[900] : Colors.indigo[100],
          ),
          CircleAvatar(
            radius: step == 3 ? width * 0.015 : width * 0.01,
            backgroundColor:
                step == 3 ? Colors.indigo[900] : Colors.indigo[100],
          )
        ],
      ),
    );
  }

  Widget ad1(double hight, double width) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: hight * 0.05,
          ),
          width: width * 1,
          child: Container(
            height: hight * 1,
            width: width,
            padding: EdgeInsets.only(top: hight * 0.03),
            child: Form(
              key: _adController.formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      bottom: width * 0.05,
                    ),
                    height: hight * 0.1,
                    width: width * 0.8,
                    child: Center(
                      child: steps(1, width),
                    ),
                  ),
                  Container(
                    height: hight * 0.7,
                    width: width * 0.87,
                    child: ListView(
                      children: [
                        Container(
                            height: hight * 0.15,
                            child: SvgPicture.asset('assets/like.svg')),
                        SizedBox(
                          height: hight * 0.022,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: width * 0.03, right: width * 0.00),
                          height: hight * 0.12,
                          width: width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text: 'Category:',
                                color: Colors.grey[900],
                                size: width * 0.05,
                                weight: FontWeight.w600,
                              ),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: width * 0.03, right: width * 0.03),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[300],
                                            blurRadius: 3,
                                            spreadRadius: 1)
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: DropdownButton(
                                    underline: SizedBox(),
                                    value: _adController.dropDownValue,
                                    icon: Icon(
                                      Icons.arrow_drop_down_circle,
                                      size: width * 0.06,
                                      color: Colors.indigo[900],
                                    ),
                                    items: <int>[
                                      0,
                                      1,
                                      2,
                                      3,
                                      4,
                                      5,
                                      6,
                                      7,
                                      8,
                                      9,
                                      10,
                                      11,
                                    ].map<DropdownMenuItem<int>>(
                                        (int jobFromFAB) {
                                      return DropdownMenuItem<int>(
                                          value: jobFromFAB,
                                          child: TextWidget(
                                            text: _adController.jobs.elementAt(
                                              jobFromHome == null
                                                  ? jobFromFAB
                                                  : jobFromHome,
                                            ),
                                            color: Colors.grey[900],
                                            size: width * 0.04,
                                            weight: FontWeight.w500,
                                          ));
                                    }).toList(),
                                    onChanged: (newVal) {
                                      setState(() {
                                        _adController.dropDownValue = newVal;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 3,
                                    spreadRadius: 1)
                              ],
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(15)),
                          height: hight * 0.087,
                          width: width * 0.8,
                          child: TextFormField(
                            controller: _adController.problem,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please discribe your problem';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.indigo[50])),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey[200])),
                              hintStyle: fonts(width * 0.05, FontWeight.w400,
                                  Colors.grey[500]),
                              hintText: 'Problem',
                              suffixIcon: Icon(
                                Icons.error_outline_rounded,
                                color: Colors.indigo[900],
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: hight * 0.03, top: hight * 0.06),
                            ),
                            onChanged: (value) {
                              this._adController.title = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: hight * 0.022,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 3,
                                    spreadRadius: 1)
                              ],
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(15)),
                          height: hight * 0.087,
                          width: width * 0.8,
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            // validator: (value) {
                            //   if (value.isEmpty) {
                            //     return 'Please assumed money';
                            //   }
                            //   return null;
                            // },0
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.indigo[900])),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey[200])),
                              hintStyle: fonts(width * 0.05, FontWeight.w400,
                                  Colors.grey[500]),
                              hintText: 'Money',
                              suffixIcon: Icon(
                                Icons.account_balance_wallet,
                                color: Colors.indigo[900],
                              ),
                              //border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: hight * 0.03, top: hight * 0.06),
                            ),
                            onChanged: (value) {
                              this._adController.money = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: hight * 0.022,
                        ),
                        InkWell(
                          onTap: () async {
                            await _adController.pickDate(context);
                            await _adController.picktime(context);
                          },
                          child: Container(
                              padding: EdgeInsets.only(
                                  left: width * 0.03,
                                  right: width * 0.03,
                                  top: width * 0.03),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[300],
                                        blurRadius: 3,
                                        spreadRadius: 1)
                                  ],
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(15)),
                              height: hight * 0.12,
                              width: width * 0.8,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      TextWidget(
                                        text: 'Schedule:',
                                        color: Colors.grey[900],
                                        size: width * 0.05,
                                        weight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: hight * 0.07,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextWidget(
                                          text: 'Date:  ' +
                                              DateFormat('dd MMM yyyy').format(
                                                  (DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          (_adController
                                                              .pickedDate
                                                              .millisecondsSinceEpoch)))),
                                          color: Colors.grey[900],
                                          size: width * 0.04,
                                          weight: FontWeight.w500,
                                        ),
                                        TextWidget(
                                          text:
                                              'Time:${_adController.pickedTime.format(context)}',
                                          color: Colors.grey[900],
                                          size: width * 0.04,
                                          weight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: hight * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButtonWidget(
                          onClick: () {
                            _adController.sliderKey.currentState.previous();
                          },
                          buttonName: 'Back',
                          bgColor: Colors.indigo[50],
                          textColor: Colors.indigo[900],
                          height: hight * 0.05,
                          minWidth: width * 0.30,
                          textSize: hight * 0.02,
                          leadingIcon: Icon(
                            Icons.arrow_back_ios,
                            size: hight * 0.015,
                            color: Colors.indigo[900],
                          ),
                          borderRadius: 10.0,
                        ),
                        ElevatedButtonWidget(
                          onClick: () async {
                            await _adController.step1();
                          },
                          buttonName: 'Next',
                          bgColor: Colors.indigo[900],
                          textColor: Colors.white,
                          height: hight * 0.05,
                          minWidth: width * 0.60,
                          textSize: hight * 0.02,
                          trailingIcon: Icon(
                            Icons.arrow_forward_ios,
                            size: hight * 0.015,
                          ),
                          borderRadius: 10.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ad2(double hight, double width) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: hight * 0.05,
          ),
          width: width * 1,
          child: Container(
            height: hight * 1,
            width: width,
            padding: EdgeInsets.only(top: hight * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: width * 0.05,
                  ),
                  height: hight * 0.1,
                  width: width * 0.8,
                  child: Center(
                    child: steps(2, width),
                  ),
                ),
                Container(
                  height: hight * 0.7,
                  width: width * 0.87,
                  child: ListView(
                    children: [
                      Container(
                          height: hight * 0.15,
                          child: SvgPicture.asset('assets/like.svg')),
                      SizedBox(
                        height: hight * 0.022,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                          ),
                          height: hight * 0.47,
                          width: width * 0.8,
                          child: Column(
                            children: [
                              Container(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        return !_adController.uploading
                                            ? _adController.chooseImage()
                                            : null;
                                      },
                                      icon: Icon(Icons.camera)),
                                  IconButton(
                                      onPressed: () {
                                        _adController.pickVideo();
                                      },
                                      icon: Icon(Icons.video_camera_back)),
                                  IconButton(
                                      onPressed: () {
                                        log(_adController.serviceImages
                                            .toString());
                                        audioRecoder(context, hight, width,
                                            _adController);
                                      },
                                      icon: Icon(Icons.mic))
                                ],
                              )),
                              SizedBox(
                                height: hight * 0.022,
                              ),
                              _adController.serviceImages.length == 0
                                  ? Container(
                                      height: hight * 0.35,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              icon: Icon(
                                                Icons.perm_camera_mic,
                                                size: 45,
                                                // color: Colors.grey,
                                              ),
                                              onPressed: () {}),
                                          SizedBox(
                                            height: hight * 0.05,
                                          ),
                                          TextWidget(
                                            text:
                                                'Let us know your problem by uploading \n Image/Video/Audio',
                                            size: width * 0.05,
                                            align: TextAlign.center,
                                            weight: FontWeight.w600,
                                            // lSpace: 1,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          height: hight * 0.22,
                                          width: width * 1,
                                          child: GridView.builder(
                                              itemCount: _adController
                                                      .serviceImages.length +
                                                  1,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      mainAxisSpacing: 3.5,
                                                      crossAxisSpacing: 3.5,
                                                      crossAxisCount: 4),
                                              itemBuilder: (context, index) {
                                                // String type =  _adController.serviceImages[index].toString();
                                                return index == 0
                                                    ? Center(
                                                        child: IconButton(
                                                            icon:
                                                                Icon(Icons.add),
                                                            onPressed: () {
                                                              return !_adController
                                                                      .uploading
                                                                  ? _adController
                                                                      .chooseImage()
                                                                  : null;
                                                            }),
                                                      )
                                                    : Stack(children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: FileImage(
                                                                      _adController
                                                                              .serviceImages[
                                                                          index -
                                                                              1]),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                        Positioned(
                                                            right: 0,
                                                            top: 0,
                                                            child: InkWell(
                                                                onTap: () {
                                                                  _adController
                                                                      .serviceImages
                                                                      .removeAt(
                                                                          index -
                                                                              1);

                                                                  _adController
                                                                      .refresh();
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  size: width *
                                                                      0.05,
                                                                  color: Colors
                                                                      .white,
                                                                )))
                                                      ]);
                                              }),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: hight * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButtonWidget(
                        onClick: () {
                          _adController.sliderKey.currentState.previous();
                        },
                        buttonName: 'Back',
                        bgColor: Colors.indigo[50],
                        textColor: Colors.indigo[900],
                        height: hight * 0.05,
                        minWidth: width * 0.30,
                        textSize: hight * 0.02,
                        leadingIcon: Icon(
                          Icons.arrow_back_ios,
                          size: hight * 0.015,
                          color: Colors.indigo[900],
                        ),
                        borderRadius: 10.0,
                      ),
                      ElevatedButtonWidget(
                        onClick: () async {
                          await _adController.step1();
                        },
                        buttonName: 'Next',
                        bgColor: Colors.indigo[900],
                        textColor: Colors.white,
                        height: hight * 0.05,
                        minWidth: width * 0.60,
                        textSize: hight * 0.02,
                        trailingIcon: Icon(
                          Icons.arrow_forward_ios,
                          size: hight * 0.015,
                        ),
                        borderRadius: 10.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ad3(double hight, double width, user) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: hight * 0.05,
          ),
          width: width * 1,
          child: Container(
            height: hight * 1,
            width: width,
            padding: EdgeInsets.only(top: hight * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: width * 0.05,
                  ),
                  height: hight * 0.1,
                  width: width * 0.8,
                  child: Center(
                    child: steps(3, width),
                  ),
                ),
                Container(
                  height: hight * 0.75,
                  width: width * 0.87,
                  child: ListView(
                    children: [
                      TextWidget(
                        text: 'Choose Service Location',
                        size: width * 0.06,
                        align: TextAlign.center,
                        weight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: hight * 0.022,
                      ),
                      Container(
                        height: hight * 0.3,
                        child: Maps(),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 5,
                              spreadRadius: 2)
                        ]),
                      ),
                      SizedBox(
                        height: hight * 0.022,
                      ),
                      Container(
                        height: hight * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    TextWidget(
                                        text: _adController.latitude + ","),
                                    TextWidget(text: _adController.longitude),
                                  ],
                                ),
                                TextWidget(
                                  text: _adController.add2,
                                  size: width * 0.04,
                                  flow: TextOverflow.visible,
                                  weight: FontWeight.w500,
                                ),
                                SizedBox(
                                  height: hight * 0.03,
                                ),
                              ],
                            ),
                            Container(
                              height: hight * 0.1,
                              width: width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButtonWidget(
                                    buttonName: 'My Location',
                                    bgColor: Colors.transparent,
                                    borderSideColor: Colors.indigo[900],
                                    textSize: width * 0.035,
                                    borderRadius: 15.0,
                                    onClick: () {
                                      _adController.getCurrentLocation();
                                      _adController.getAddressofLocation();
                                    },
                                    height: hight * 0.07,
                                    minWidth: width * 0.35,
                                  ),
                                  ElevatedButtonWidget(
                                    buttonName: 'Change Location',
                                    bgColor: Colors.transparent,
                                    borderSideColor: Colors.indigo[900],
                                    borderRadius: 15.0,
                                    textSize: width * 0.035,
                                    height: hight * 0.07,
                                    minWidth: width * 0.35,
                                    onClick: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OnlinePlaceSearch()));
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: hight * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButtonWidget(
                        onClick: () {
                          _adController.sliderKey.currentState.previous();
                        },
                        buttonName: 'Back',
                        bgColor: Colors.indigo[50],
                        textColor: Colors.indigo[900],
                        height: hight * 0.05,
                        minWidth: width * 0.30,
                        textSize: hight * 0.02,
                        leadingIcon: Icon(
                          Icons.arrow_back_ios,
                          size: hight * 0.015,
                          color: Colors.indigo[900],
                        ),
                        borderRadius: 10.0,
                      ),
                      ElevatedButtonWidget(
                        onClick: () async {
                          
                          await _adController.step3(user);
                        },
                        buttonName: 'Finish',
                        bgColor: Colors.indigo[900],
                        textColor: Colors.white,
                        height: hight * 0.05,
                        minWidth: width * 0.60,
                        textSize: hight * 0.02,
                        trailingIcon: Icon(
                          Icons.arrow_forward_ios,
                          size: hight * 0.015,
                        ),
                        borderRadius: 10.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


//   Widget ad4(double hight, double width) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.only(
//             top: hight * 0.05,
//           ),
//           width: width * 1,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30)),
//                 height: hight * 0.6,
//                 width: width * 0.9,
//                 padding: EdgeInsets.only(top: hight * 0.03),
//                 child: ListView(
//                   children: [
//                     Column(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                             bottom: width * 0.05,
//                           ),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(15)),
//                           height: hight * 0.1,
//                           width: width * 0.8,
//                           child: Center(
//                             child: steps(1, width),
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             _adController.getCurrentLocation();
//                             _adController.getAddressofLocation();
//                           },
//                           child: Container(
//                             padding: EdgeInsets.only(
//                                 left: width * 0.03,
//                                 right: width * 0.03,
//                                 top: width * 0.03),
//                             decoration: BoxDecoration(
//                                 color: Colors.grey[100],
//                                 borderRadius: BorderRadius.circular(15)),
//                             height: hight * 0.25,
//                             width: width * 0.8,
//                             child: Container(
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Location:',
//                                         style: TextStyle(
//                                             fontSize: width * 0.05,
//                                             color: Colors.grey[700],
//                                             fontWeight: FontWeight.w500),
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(_adController.latitude),
//                                           Text(_adController.longitude),
//                                         ],
//                                       ),
//                                       Text(
//                                         _adController.add2,
//                                       ),
//                                       // SizedBox(height: hight * 0.015),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       ElevatedButton.icon(
//                                         onPressed: () {
//                                           _adController.getCurrentLocation();
//                                           _adController.getAddressofLocation();
//                                         },
//                                         icon: Icon(
//                                           Icons.gps_fixed,
//                                           color: Colors.blue[900],
//                                         ),
//                                         label: Text(
//                                           'Get Location',
//                                           style: TextStyle(
//                                               color: Colors.blue[900]),
//                                         ),
//                                         style: ButtonStyle(
//                                           elevation:
//                                               MaterialStateProperty.all(0),
//                                           backgroundColor:
//                                               MaterialStateProperty.all(
//                                                   Colors.grey[100]),
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget ad5(double hight, double width) {
//     return SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.only(
//           top: hight * 0.05,
//         ),
//         width: width * 1,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Container(
//               decoration: BoxDecoration(boxShadow: [
//                 BoxShadow(
//                     color: Colors.grey[400],
//                     blurRadius: 8,
//                     spreadRadius: 2,
//                     offset: Offset(3, 6)),
//                 BoxShadow(
//                     color: Colors.grey[100],
//                     blurRadius: 8,
//                     spreadRadius: 2,
//                     offset: Offset(-3, -3))
//               ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
//               height: hight * 0.6,
//               width: width * 0.9,
//               padding: EdgeInsets.only(top: hight * 0.03),
//               child: ListView(
//                 children: [
//                   Column(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.only(
//                           bottom: width * 0.05,
//                         ),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15)),
//                         height: hight * 0.08,
//                         width: width * 0.8,
//                         child: Center(
//                           child: Text('Step 3/3'),
//                         ),
//                       ),
//                       Center(
//                         child: Container(
//                           padding: EdgeInsets.only(
//                               left: width * 0.03,
//                               right: width * 0.03,
//                               top: width * 0.03),
//                           decoration: BoxDecoration(
//                               color: Colors.grey[100],
//                               borderRadius: BorderRadius.circular(15)),
//                           height: hight * 0.47,
//                           width: width * 0.8,
//                           child: Column(
//                             children: [
//                               Container(
//                                   child: Row(
//                                 children: [
//                                   Text(
//                                     'Upload images/Video/Voice:',
//                                     style: TextStyle(
//                                         fontSize: width * 0.05,
//                                         color: Colors.grey[700],
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ],
//                               )),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               _adController.serviceImages == null
//                                   ? Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         IconButton(
//                                             icon: Icon(
//                                               Icons.cloud_upload_outlined,
//                                               size: 45,
//                                               color: Colors.grey,
//                                             ),
//                                             onPressed: () {}),
//                                         SizedBox(
//                                           height: 7,
//                                         ),
//                                         Text(
//                                             'Let us know your problem by uploading image')
//                                       ],
//                                     )
//                                   : Column(
//                                       children: [
//                                         Container(
//                                           height: hight * 0.22,
//                                           width: width * 1,
//                                           child: GridView.builder(
//                                               itemCount: _adController
//                                                       .serviceImages.length +
//                                                   1,
//                                               gridDelegate:
//                                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                                       crossAxisCount: 5),
//                                               itemBuilder: (context, index) {
//                                                 return index == 0
//                                                     ? Center(
//                                                         child: IconButton(
//                                                             icon:
//                                                                 Icon(Icons.add),
//                                                             onPressed: () =>
//                                                                 !_adController
//                                                                         .uploading
//                                                                     ? _adController
//                                                                         .chooseImage()
//                                                                     : null),
//                                                       )
//                                                     : Stack(
//                                                         alignment:
//                                                             Alignment.topRight,
//                                                         children: [
//                                                             Container(
//                                                               margin: EdgeInsets
//                                                                   .all(6),
//                                                               decoration: BoxDecoration(
//                                                                   image: DecorationImage(
//                                                                       image: FileImage(_adController
//                                                                               .serviceImages[
//                                                                           index -
//                                                                               1]),
//                                                                       fit: BoxFit
//                                                                           .cover)),
//                                                             ),
//                                                             Positioned(
//                                                               left: 37.0,
//                                                               bottom: 37.0,
//                                                               child: IconButton(
//                                                                   icon: Icon(
//                                                                     Icons
//                                                                         .remove_circle,
//                                                                     color: Colors
//                                                                             .redAccent[
//                                                                         200],
//                                                                   ),
//                                                                   onPressed:
//                                                                       () async {
//                                                                     _adController
//                                                                         .serviceImages
//                                                                         .removeAt(
//                                                                             0);

//                                                                     refresh();
//                                                                   }),
//                                                             ),
//                                                           ]);
//                                               }),
//                                         ),
//                                       ],
//                                     ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Center(
//         child: Container(
//           padding: EdgeInsets.all(20),
//           height: _hight * 1,
//           width: _width * 1,
//           //color: Colors.amber,
//           child: ListView(
//             children: [
//               Container(
//                 padding: EdgeInsets.only(left: 10, right: 5),
//                 height: _hight * 0.1,
//                 width: _width * 1,
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey[50],
//                         spreadRadius: 3,
//                         //offset: Offset.infinite,
//                         blurRadius: 1,
//                       )
//                     ],
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Select Technician:',
//                         style: TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.w500)),
//                     // SizedBox(
//                     //   width: 10,
//                     // ),
//                     Container(
//                       width: _width * 0.4,
//                       child: DropdownButton(
//                         underline: SizedBox(),
//                         value: _adController.dropDownValue,
//                         hint: Text(
//                           '$_adController.dropDownValue',
//                           style: TextStyle(fontSize: _width * 0.015),
//                         ),
//                         icon: Icon(
//                           Icons.arrow_downward_outlined,
//                           size: _width * 0.06,
//                         ),
//                         items: [
//                           DropdownMenuItem(
//                             value: 0,
//                             child: Text('AC Service'),
//                           ),
//                           DropdownMenuItem(
//                             value: 1,
//                             child: Text('Computer'),
//                           ),
//                           DropdownMenuItem(
//                             value: 2,
//                             child: Text('TV Repair'),
//                           ),
//                           DropdownMenuItem(
//                             value: 3,
//                             child: Text('development'),
//                           ),
//                           DropdownMenuItem(
//                             value: 4,
//                             child: Text('tutor'),
//                           ),
//                           DropdownMenuItem(
//                             value: 5,
//                             child: Text('beauty'),
//                           ),
//                           DropdownMenuItem(
//                             value: 6,
//                             child: Text('photography'),
//                           ),
//                           DropdownMenuItem(
//                             value: 7,
//                             child: Text('drivers'),
//                           ),
//                           DropdownMenuItem(
//                             value: 8,
//                             child: Text('events'),
//                           ),
//                         ],
//                         onChanged: (newVal) {
//                           //print(dropDownValue);
//                           setState(() {
//                             _adController.dropDownValue = newVal;
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               Container(
//                 padding: EdgeInsets.all(5),
//                 height: _hight * 0.1,
//                 width: _width * 1,
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey[50],
//                         spreadRadius: 3,
//                         //offset: Offset.infinite,
//                         blurRadius: 1,
//                       )
//                     ],
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15)),
//                 child: TextField(
//                   keyboardType: TextInputType.name,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                         borderSide: BorderSide(width: 1, color: Colors.white)),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                         borderSide: BorderSide(width: 1, color: Colors.white)),
//                     hintStyle: TextStyle(fontSize: 17),
//                     hintText: 'title',
//                     suffixIcon: Icon(Icons.report_problem),
//                     //border: InputBorder.none,
//                     contentPadding: EdgeInsets.all(20),
//                   ),
//                   onChanged: (value) {
//                     this._adController.title = value;
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               Container(
//                 padding: EdgeInsets.all(5),
//                 height: _hight * 0.1,
//                 width: _width * 1,
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey[50],
//                         spreadRadius: 3,
//                         // offset: Offset.infinite,
//                         blurRadius: 1,
//                       )
//                     ],
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15)),
//                 child: TextField(
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                         borderSide: BorderSide(width: 1, color: Colors.white)),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                         borderSide: BorderSide(width: 1, color: Colors.white)),
//                     hintStyle: TextStyle(fontSize: 17),
//                     hintText: 'money',
//                     suffixIcon: Icon(Icons.attach_money),
//                     //border: InputBorder.none,
//                     contentPadding: EdgeInsets.all(20),
//                   ),
//                   onChanged: (value) {
//                     this._adController.money = value;
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               InkWell(
//                 onTap: () {
//                   _adController.pickDate();
//                 },
//                 child: Container(
//                     padding: EdgeInsets.all(5),
//                     height: _hight * 0.18,
//                     width: _width * 1,
//                     decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey[50],
//                             spreadRadius: 3,
//                             // offset: Offset.infinite,
//                             blurRadius: 1,
//                           )
//                         ],
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15)),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               'Set Schedule:',
//                               style: TextStyle(
//                                   fontSize: 17, fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: _hight * 0.04,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Text(
//                                 'Date:  ${_adController.pickedDate.day}/${_adController.pickedDate.month}/${_adController.pickedDate.year}',
//                                 style: TextStyle(fontSize: 15)),
//                             Text(
//                                 'Time:  ${_adController.pickedTime.hour}:${_adController.pickedTime.minute}',
//                                 style: TextStyle(fontSize: 15))
//                           ],
//                         ),
//                       ],
//                     )),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               InkWell(
//                 onTap: () {
//                   print(_adController.longitude + '512');
//                   _adController.getCurrentLocation();
//                   _adController.getAddressofLocation();
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   height: _hight * 0.25,
//                   width: _width * 1,
//                   decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey[50],
//                           spreadRadius: 3,
//                           blurRadius: 1,
//                         )
//                       ],
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15)),
//                   child: Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Location:',
//                               style: TextStyle(
//                                   fontSize: 17, fontWeight: FontWeight.w500),
//                             ),
//                             Row(
//                               children: [
//                                 Text(_adController.latitude),
//                                 Text(_adController.longitude),
//                               ],
//                             ),
//                             Text(_adController.add2),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               Center(
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   height: _hight * 0.35,
//                   width: _width * 1,
//                   decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey[50],
//                           spreadRadius: 3,
//                           blurRadius: 1,
//                         )
//                       ],
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15)),
//                   child: Column(
//                     children: [
//                       Container(
//                           child: Row(
//                         children: [
//                           Text('Upload images:',
//                               style: TextStyle(
//                                   fontSize: 17, fontWeight: FontWeight.w500)),
//                         ],
//                       )),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       _adController.profilepic == null
//                           ? Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 IconButton(
//                                     icon: Icon(
//                                       Icons.cloud_upload_outlined,
//                                       size: 45,
//                                       color: Colors.grey,
//                                     ),
//                                     onPressed: () {}),
//                                 SizedBox(
//                                   height: 7,
//                                 ),
//                                 Text(
//                                     'Let us know your problem by uploading image')
//                               ],
//                             )
//                           : Column(
//                               children: [
//                                 Container(
//                                   height: _hight * 0.22,
//                                   width: _width * 1,
//                                   child: GridView.builder(
//                                       itemCount:
//                                           _adController.profilepic.length + 1,
//                                       gridDelegate:
//                                           SliverGridDelegateWithFixedCrossAxisCount(
//                                               crossAxisCount: 5),
//                                       itemBuilder: (context, index) {
//                                         return index == 0
//                                             ? Center(
//                                                 child: IconButton(
//                                                     icon: Icon(Icons.add),
//                                                     onPressed: () =>
//                                                         !_adController.uploading
//                                                             ? _adController
//                                                                 .chooseImage()
//                                                             : null),
//                                               )
//                                             : Stack(
//                                                 alignment: Alignment.topRight,
//                                                 children: [
//                                                     Container(
//                                                       margin: EdgeInsets.all(6),
//                                                       decoration: BoxDecoration(
//                                                           image: DecorationImage(
//                                                               image: FileImage(
//                                                                   _adController
//                                                                           .profilepic[
//                                                                       index -
//                                                                           1]),
//                                                               fit: BoxFit
//                                                                   .cover)),
//                                                     ),
//                                                     Positioned(
//                                                       left: 37.0,
//                                                       bottom: 37.0,
//                                                       child: IconButton(
//                                                           icon: Icon(
//                                                             Icons.remove_circle,
//                                                             color: Colors
//                                                                 .redAccent[200],
//                                                           ),
//                                                           onPressed: () async {
//                                                             _adController
//                                                                 .profilepic
//                                                                 .removeAt(0);

//                                                             refresh();
//                                                           }),
//                                                     ),
//                                                   ]);
//                                       }),
//                                 ),
//                               ],
//                             ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all(Colors.blue[900]),
//                       ),
//                       child: Text(
//                         'Submit',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () async {
//                         // _adController.adbutton();
//                         FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(FirebaseAuth.instance.currentUser.uid)
//                             .collection('adpost')
//                             .doc(_adController.docc.id)
//                             .set({'dummy': 'dsgdfga'});
//                         print(_adController.docc.id);
//                       })
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),

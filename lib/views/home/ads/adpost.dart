import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/home_controllers/ad_controll.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/utilities/progressIndicator.dart';
import 'package:spotmies/views/home/ads/page2.dart';
import 'package:spotmies/views/home/ads/page3.dart';
import 'package:spotmies/views/home/ads/page1.dart';
import 'package:spotmies/views/reusable_widgets/onFailure.dart';
import 'package:spotmies/views/reusable_widgets/onPending.dart';
import 'package:spotmies/views/reusable_widgets/onSuccuss.dart';
import 'package:spotmies/views/reusable_widgets/pageSlider.dart';
import 'package:spotmies/utilities/appConfig.dart';

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
  UniversalProvider up;

  UserDetailsProvider uDetailsProvider;

  @override
  void initState() {
    _adController.isUploading = 0;
    uDetailsProvider = Provider.of<UserDetailsProvider>(context, listen: false);
    up = Provider.of<UniversalProvider>(context, listen: false);
    up.setCurrentConstants("serviceRequest");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("============ Render AdPost ==============");
    return Consumer<UserDetailsProvider>(builder: (context, data, child) {
      var user = data.user;
      if (data.getLoader || user == null) return circleProgress();
      switch (_adController.isUploading) {
        case 1:
          return onPending(height(context), width(context));
        case 2:
          return onFail(height(context), width(context), context);
        case 3:
          return onSuccess(height(context), width(context), context);

          break;
        default:
          break;
      }
      return Scaffold(
          resizeToAvoidBottomInset: false,
          key: _adController.scaffoldkey,
          backgroundColor: Colors.white,
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(children: [
              PageSlider(key: _adController.sliderKey, pages: [
                Container(
                    height: height(context) * 1.08,
                    child: page1(height(context), width(context), context,
                        _adController, up)),
                Container(
                    height: height(context) * 1.08,
                    child: page2(height(context), width(context), context,
                        _adController)),
                Container(
                    height: height(context) * 1.08,
                    child: page3(height(context), width(context), user,
                        _adController, context)),
              ]),
            ]),
          )));
    });
  }
}

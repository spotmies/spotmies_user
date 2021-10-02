import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/home_controllers/ad_controll.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/views/home/ads/page2.dart';
import 'package:spotmies/views/home/ads/page3.dart';
import 'package:spotmies/views/home/ads/page1.dart';
import 'package:spotmies/views/profile/profile_shimmer.dart';
import 'package:spotmies/views/reusable_widgets/onFailure.dart';
import 'package:spotmies/views/reusable_widgets/onPending.dart';
import 'package:spotmies/views/reusable_widgets/onSuccuss.dart';
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
    _adController.isUploading = 0;
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
      switch (_adController.isUploading) {
        case 1:
          return onPending(_hight, _width);
        case 2:
          return onFail(_hight, _width, context);
        case 3:
          return onSuccess(_hight, _width, context);

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
                    height: _hight * 1.08,
                    child: page1(_hight, _width, context, _adController)),
                // child: page1(_hight, _width, context, _adController)),
                Container(
                    height: _hight * 1.08,
                    child: page2(_hight, _width, context, _adController)),
                Container(
                    height: _hight * 1.08,
                    child: page3(_hight, _width, user, _adController, context)),
              ]),
            ]),
          )));
    });
  }
}

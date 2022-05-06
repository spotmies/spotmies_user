import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/home_controllers/ad_controll.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/utilities/progressIndicator.dart';
import 'package:spotmies/views/home/ads/catPost.dart';
import 'package:spotmies/views/home/ads/page2.dart';
import 'package:spotmies/views/home/ads/page3.dart';
import 'package:spotmies/views/home/ads/page1.dart';
import 'package:spotmies/views/home/ads/page4.dart';
import 'package:spotmies/views/reusable_widgets/onFailure.dart';
import 'package:spotmies/views/reusable_widgets/onPending.dart';
import 'package:spotmies/views/reusable_widgets/onSuccuss.dart';
import 'package:spotmies/views/reusable_widgets/pageSlider.dart';
import 'package:spotmies/utilities/appConfig.dart';

class PostAd extends StatefulWidget {
  final int? sid;
  final bool? cat;
  final dynamic catData;
  PostAd({this.sid, this.cat, this.catData});
  @override
  _PostAdState createState() => _PostAdState();
}

class _PostAdState extends StateMVC<PostAd> {
  late AdController _adController;
  _PostAdState() : super(AdController()) {
    this._adController = controller as AdController;
  }

  var latitude = "";
  var longitude = "";
  String add1 = "";
  String add2 = "";
  String add3 = "";
  UniversalProvider? up;

  UserDetailsProvider? uDetailsProvider;

  GetOrdersProvider? ordersProvider;

  @override
  void initState() {
    _adController.isUploading = 0;
    uDetailsProvider = Provider.of<UserDetailsProvider>(context, listen: false);
    ordersProvider = Provider.of<GetOrdersProvider>(context, listen: false);
    up = Provider.of<UniversalProvider>(context, listen: false);
    up?.setCurrentConstants("serviceRequest");
    _adController.getAddressofLocation();
    _adController.pickedDate = DateTime.now();
    _adController.pickedTime = TimeOfDay.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("============ Render AdPost ==============");
    if (widget.sid != null) {
      _adController.dropDownValue = widget.sid;
    }
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

        default:
          break;
      }
      return Scaffold(
          resizeToAvoidBottomInset: false,
          key: _adController.scaffoldkey,
          backgroundColor: SpotmiesTheme.background,
          body: SafeArea(
              child: SingleChildScrollView(
            child: widget.cat == true
                ? CatBook(cat: widget.catData, user: user)
                // :
                // ? catPost(context, _adController, up!, widget.catData,
                //     ordersProvider, user)
                : Column(children: [
                    PageSlider(key: _adController.sliderKey, pages: [
                      Container(
                          height: height(context) * 1.08,
                          // child: Page1(),
                          child:
                              page1(context, _adController, up!, widget.sid)),
                      Container(
                          height: height(context) * 1.08,
                          child: page2(height(context), width(context), context,
                              _adController)),
                      Container(
                          height: height(context) * 1.08,
                          child: page3(height(context), width(context), user,
                              _adController, context, ordersProvider)),
                      Container(
                          height: height(context) * 1.08,
                          child: page4(height(context), width(context), user,
                              _adController, context, ordersProvider, up)),
                    ]),
                  ]),
          )));
    });
  }
}

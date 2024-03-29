import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:share/share.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/controllers/profile_controllers/help.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/views/profile/privacyPolicies.dart';
import 'package:spotmies/views/login/loginpage.dart';
import 'package:spotmies/views/profile/settings.dart';

class ProfileController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();

  final TextStyle headerStyle = TextStyle(
    color: Colors.grey.shade800,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );

  var color = LinearGradient(
      colors: [Colors.indigo[900], Colors.blue[800]],
      begin: FractionalOffset(0.8, 0.4),
      end: FractionalOffset(0.2, 0.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp);
  var shadow = [
    BoxShadow(
        color: Colors.grey[200],
        blurRadius: 2,
        spreadRadius: 2,
        offset: Offset(4, 4)),
    BoxShadow(
        color: Colors.grey[50],
        blurRadius: 2,
        spreadRadius: 2,
        offset: Offset(-4, -4))
  ];
  List tabnames = [
    'Share',
    'Policies',
    'Promotions',
    'Settings',
    'Help',
    'Logout'
  ];
  List icons = [
    Icons.share,
    Icons.security,
    Icons.local_offer,
    Icons.settings,
    Icons.help,
    Icons.power_settings_new
  ];
  List routes = [];
  String uuId = FirebaseAuth.instance.currentUser.uid;

  editProfile() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Setting()));
  }

  help() {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HelpAndSupport()));
  }

  privacy() {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PrivacyPolicyWebView()));
  }

  share() {
    return Share.share(
        'https://play.google.com/store/apps/details?id=com.spotmiespartner');
  }

  updateProfileDetails(body) async {
    dynamic response =
        await Server().editMethod(API.editPersonalInfo + uuId, body);
    if (response.statusCode == 200) {
      response = jsonDecode(response.body);
      return response;
    }
    return null;
  }

  Widget drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            title: Text('0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  submitQuery(String subject, String pDID, BuildContext context,
      {String suggestionFor: "faq"}) async {
    Map<String, String> body = {
      "subject": subject,
      "suggestionFor": suggestionFor,
      "suggestionFrom": "userApp",
      "uId": FirebaseAuth.instance.currentUser.uid,
      "uDetails": pDID,
    };
    dynamic response = await Server().postMethod(API.newSuggestion, body);
    // print("36 $response");
    if (response.statusCode == 200 || response.statusCode == 204) {
      log(response.body.toString());
      snackbar(context, 'Done');
    } else if (response.statusCode == 404) {
      log(response.body.toString());
      snackbar(context, 'Something went wrong');
    } else {
      log(response.body.toString());
      snackbar(context, 'server error');
      // loader = false;
    }
  }

  signout() async {
    await FirebaseAuth.instance.signOut().then((action) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPageScreen()));
    }).catchError((e) {
      print(e);
    });
  }
}

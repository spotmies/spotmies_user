import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotmies/views/reusable_widgets/bottom_options_menu.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utilities/constants.dart';
import '../internet_calling/calling.dart';

void calling(BuildContext context, String phNum, String pId, String profile,
    String name, String deviceToken,
    {String msgId = "", String ordId = "", bool isIncoming = false}) {
  bottomOptionsMenu(context, options: Constants.bottomSheetOptionsForCalling,
      option1Click: () {
    // launch("tel://$phNum");
    launchUrl(Uri(scheme: "tel", path: phNum.toString()));
  }, option2Click: () {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MyCalling(
              msgId: msgId,
              ordId: ordId,
              uId: FirebaseAuth.instance.currentUser?.uid,
              pId: pId,
              isIncoming: isIncoming,
              name: name,
              profile: profile,
              partnerDeviceToken: profile,
            )));
  });
}

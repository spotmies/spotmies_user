import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/profile/editDetailsBS.dart';
// import 'package:spotmies/views/profile/editDetailsBS.dart';
import 'package:spotmies/views/profile/feedBack.dart';
import 'package:spotmies/views/profile/help&supportBS.dart';
import 'package:spotmies/views/profile/orderHistoryBS.dart';
import 'package:spotmies/views/profile/privacyPolicies.dart';
import 'package:spotmies/controllers/profile_controllers/profile_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/views/profile/inviteBS.dart';
import 'package:spotmies/views/profile/profilePic.dart';
import 'package:spotmies/views/profile/profile_shimmer.dart';
import 'package:spotmies/views/profile/promotionsBS.dart';
import 'package:spotmies/views/profile/settingsBS.dart';
import 'package:spotmies/views/profile/signoutBS.dart';
import 'package:spotmies/views/reusable_widgets/queryBS.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends StateMVC<Profile> {
  late ProfileController _profileController;
  late UniversalProvider up;
  late UserDetailsProvider profileProvider;
  late GetOrdersProvider ordersProvider;

  _ProfileState() : super(ProfileController()) {
    this._profileController = controller as ProfileController;
  }

  var mode = true;

  List tabnames = [
    'Invite a friend',
    'Privacy Policies',
    'Order History',
    'Promotions',
    'Help & Support',
    'FeedBack',
    'Settings',
    'SignOut',
  ];
  List icons = [
    Icons.share,
    Icons.security,
    Icons.history,
    Icons.local_offer,
    Icons.help,
    Icons.feedback,
    Icons.settings,
    Icons.power_settings_new
  ];
  var editpic;

  @override
  void initState() {
    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);
    ordersProvider = Provider.of<GetOrdersProvider>(context, listen: false);
    up = Provider.of<UniversalProvider>(context, listen: false);
    up.setCurrentConstants("profile");

    editpic = profileProvider.getUser['pic'];
    super.initState();
  }

  onClickk() {
    print("onClick");
  }

  @override
  Widget build(BuildContext context) {
    log("============ Render Profile ==============");
    // final height(context) = MediaQuery.of(context).size.height -
    //     MediaQuery.of(context).padding.top -
    //     kToolbarHeight;
    // final width(context) = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _profileController.scaffoldkey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Profile',
            style: GoogleFonts.josefinSans(
                color: Colors.grey[900], fontWeight: FontWeight.w700)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
                radius: width(context) * 0.046,
                backgroundColor: Colors.indigo[100],
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        mode = !mode;
                      });
                    },
                    icon: Icon(
                      !mode ? Icons.light_mode : Icons.dark_mode,
                      size: width(context) * 0.05,
                      color: mode ? Colors.grey[800] : Colors.white,
                    ))),
          )
        ],
      ),
      body: Container(
        child: Consumer<UserDetailsProvider>(builder: (context, data, child) {
          dynamic u = data.getUser;

          if (data.getLoader || u == null)
            return Center(child: profileShimmer(context));

          // return TextButton(
          //     onPressed: () {
          //       signOut(context);
          //     },
          //     child: Text("logout"));
          return ListView(
            children: [
              profilePic(context, u['pic'], u['name'], onClick: () {
                editDetails(context, width(context), height(context),
                    profileProvider, editpic, _profileController,
                    details: u);
              }),
              Container(
                height: height(context) * 0.08,
                // color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      u['name'] ?? 'Spotmies User',
                      style: fonts(width(context) * 0.05, FontWeight.w600,
                          Colors.grey[900]),
                    ),
                    Text(
                      u['phNum'].toString(),
                      style: fonts(width(context) * 0.03, FontWeight.w500,
                          Colors.grey[900]),
                    )
                  ],
                ),
              ),
              Container(
                height: height(context) * 0.08,
                // color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: width(context) * 0.4,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '₹ ' + '1234',
                              style: fonts(width(context) * 0.04,
                                  FontWeight.w600, Colors.grey[900]),
                            ),
                            Text(
                              'Total Savings',
                              style: fonts(width(context) * 0.02,
                                  FontWeight.w500, Colors.grey[900]),
                            ),
                          ]),
                    ),
                    Container(
                      width: width(context) * 0.002,
                      height: height(context) * 0.04,
                      color: Colors.grey[500],
                    ),
                    Container(
                      width: width(context) * 0.4,
                      child: Consumer<GetOrdersProvider>(
                          builder: (context, data, child) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data.getOrdersList.length.toString(),
                                style: fonts(width(context) * 0.04,
                                    FontWeight.w600, Colors.grey[900]),
                              ),
                              Text('Total orders',
                                  style: fonts(width(context) * 0.02,
                                      FontWeight.w500, Colors.grey[900])),
                            ]);
                      }),
                    )
                  ],
                ),
              ),
              Container(
                height: height(context) * 0.6,
                child: ListView.builder(
                    itemCount: tabnames.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                              bottom: index == tabnames.length - 1
                                  ? height(context) * 0.09
                                  : 0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade200,
                                      blurRadius: 5,
                                      spreadRadius: 2)
                                ]),
                            child: ListTile(
                              onTap: () {
                                if (index == 0) {
                                  invites(
                                      context, height(context), width(context));
                                }
                                if (index == 1) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          PrivacyPolicyWebView()));
                                }
                                if (index == 2) {
                                  history(
                                      context, height(context), width(context));
                                }
                                if (index == 3) {
                                  promotions(
                                      context, height(context), width(context));
                                }
                                if (index == 4) {
                                  helpAndSupport(
                                      context,
                                      height(context),
                                      width(context),
                                      _profileController,
                                      u['_id']);
                                }
                                if (index == 5) {
                                  newQueryBS(context, onSubmit: (String value) {
                                    _profileController.submitQuery(
                                        value, u['_id'].toString(), context,
                                        suggestionFor: "feedback");
                                  });
                                }
                                if (index == 6) {
                                  settings(
                                      context, height(context), width(context));
                                }
                                if (index == 7) {
                                  signOut(
                                      context, height(context), width(context));
                                }
                              },
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(icons[index],
                                      size: width(context) * 0.04),
                                ],
                              ),
                              title: Text(tabnames[index],
                                  style: fonts(width(context) * 0.04,
                                      FontWeight.w500, Colors.blueGrey[900])),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: width(context) * 0.04,
                              ),
                            ),
                          ));
                    }),
              ),
            ],
          );
        }),
      ),
    );
  }
}

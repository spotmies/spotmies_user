import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/providers/localization_provider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/profile/editDetailsBS.dart';
// import 'package:spotmies/views/profile/editDetailsBS.dart';
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
    mode = !(Provider.of<ThemeProvider>(context, listen: false)
        .isDarkThemeEnabled);
    editpic = profileProvider.getUser['pic'];
    super.initState();
  }

  onClickk() {
    print("onClick");
  }

  @override
  Widget build(BuildContext context) {
    mode =
        !(Provider.of<ThemeProvider>(context, listen: true).isDarkThemeEnabled);
    log("============ Render Profile ==============");

    return Consumer<LocalizationProvider>(builder: (context, data, child) {
      List tabnames = [
        tr('invite'),
        tr('privacy_policies'),
        tr('service_history'),
        tr('promotions'),
        tr('help&support'),
        tr('feedback'),
        tr('settings'),
        tr('signout'),
      ];
      return Scaffold(
        key: _profileController.scaffoldkey,
        backgroundColor: SpotmiesTheme.background,
        appBar: AppBar(
          backgroundColor: SpotmiesTheme.background,
          elevation: 0,
          title: TextWidget(
            text: tr('profile'),
            color: SpotmiesTheme.secondaryVariant,
            size: width(context) * 0.06,
            weight: FontWeight.w600,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CircleAvatar(
                  radius: width(context) * 0.046,
                  backgroundColor: SpotmiesTheme.secondary,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          mode = !mode;
                          Provider.of<ThemeProvider>(context, listen: false)
                              .setThemeMode(
                                  mode ? ThemeMode.light : ThemeMode.dark);
                        });
                      },
                      icon: Icon(
                        !mode ? Icons.light_mode : Icons.dark_mode,
                        size: width(context) * 0.05,
                        color: SpotmiesTheme.background,
                      ))),
            )
          ],
        ),
        body: Container(
          child: Consumer<UserDetailsProvider>(builder: (context, data, child) {
            dynamic u = data.getUser;

            if (data.getLoader || u == null)
              return Center(child: profileShimmer(context));

            return ListView(
              children: [
                SizedBox(
                  height: height(context) * 0.04,
                ),
                profilePic(context, u['pic'], u['name'], width(context) * 0.4,
                    onClick: () {
                  editDetails(context, width(context), height(context),
                      profileProvider, editpic, _profileController,
                      details: u);
                }),
                Container(
                  height: height(context) * 0.08,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        u['name'] ?? 'Spotmies User',
                        style: fonts(width(context) * 0.05, FontWeight.w600,
                            SpotmiesTheme.secondaryVariant),
                      ),
                      Text(
                        u['phNum'].toString(),
                        style: fonts(width(context) * 0.03, FontWeight.w500,
                            SpotmiesTheme.secondaryVariant),
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
                                style: fonts(
                                    width(context) * 0.04,
                                    FontWeight.w600,
                                    SpotmiesTheme.secondaryVariant),
                              ),
                              Text(
                                tr('total_savings'),
                                style: fonts(
                                    width(context) * 0.02,
                                    FontWeight.w500,
                                    SpotmiesTheme.secondaryVariant),
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
                                  style: fonts(
                                      width(context) * 0.04,
                                      FontWeight.w600,
                                      SpotmiesTheme.secondaryVariant),
                                ),
                                Text(tr('total_orders'),
                                    style: fonts(
                                        width(context) * 0.02,
                                        FontWeight.w500,
                                        SpotmiesTheme.secondaryVariant)),
                              ]);
                        }),
                      )
                    ],
                  ),
                ),
                Container(
                  height: height(context) * 0.8,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
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
                                  color: SpotmiesTheme.background,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: SpotmiesTheme.shadow,
                                        blurRadius: 3,
                                        spreadRadius: 1)
                                  ]),
                              child: ListTile(
                                onTap: () {
                                  if (index == 0) {
                                    invites(context, height(context),
                                        width(context));
                                  }
                                  if (index == 1) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PrivacyPolicyWebView()));
                                  }
                                  if (index == 2) {
                                    history(context, height(context),
                                        width(context));
                                  }
                                  if (index == 3) {
                                    promotions(context, height(context),
                                        width(context));
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
                                    newQueryBS(context,
                                        onSubmit: (String value) {
                                      _profileController.submitQuery(
                                          value, u['_id'].toString(), context,
                                          suggestionFor: "feedback");
                                    });
                                  }
                                  if (index == 6) {
                                    settings(
                                      context,
                                      height(context),
                                      width(context),
                                    );
                                  }
                                  if (index == 7) {
                                    signOut(context, height(context),
                                        width(context));
                                  }
                                },
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      icons[index],
                                      size: width(context) * 0.04,
                                      color: SpotmiesTheme.secondaryVariant,
                                    ),
                                  ],
                                ),
                                title: Text(tabnames[index],
                                    style: fonts(
                                      width(context) * 0.04,
                                      FontWeight.w500,
                                      SpotmiesTheme.secondaryVariant,
                                    )),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: SpotmiesTheme.secondaryVariant,
                                  size: width(context) * 0.04,
                                ),
                              ),
                            ));
                      }),
                ),
                // SizedBox(
                //   height: height(context) * 0.01,
                // )
              ],
            );
          }),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/home_controllers/home_controller.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/home/banner.dart';
import 'package:spotmies/views/home/categeries_card.dart';
import 'package:spotmies/models/data.dart';
import 'package:spotmies/views/home/notification_screens.dart';
import 'package:spotmies/views/home/searchJobs/search.dart';
import 'package:spotmies/views/home/processSteps_card.dart';
import 'package:spotmies/views/home/popular_services_card.dart';
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
  getLocation() async {
    print(up.add2);
    if (up.add2 == "") {
      print("getting address");
      String subLocality = await _homeController.getAddressofLocation(context);
      up.setAdd2(subLocality);
    }
  }

  @override
  initState() {
    up = Provider.of<UniversalProvider>(context, listen: false);
    up.setCurrentConstants("home");

    getLocation();
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
    return Scaffold(
        backgroundColor: SpotmiesTheme.background,
        appBar: AppBar(
          backgroundColor: SpotmiesTheme.background,
          leading: Icon(
            Icons.location_searching,
            color: SpotmiesTheme.onBackground,
            size: width(context) * 0.05,
          ),
          elevation: 0,
          title: Container(
            width: width(context) * 0.5,
            child: InkWell(
              onTap: () async {
                String loc =
                    await _homeController.getAddressofLocation(context);
                up.setAdd2(loc);
              },
              child:
                  Text((up.add2 != "") ? up.getAdd2.toString() : "Loading...",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.josefinSans(
                        fontSize: width(context) * 0.045,
                        fontWeight: FontWeight.bold,
                        color: SpotmiesTheme.onBackground,
                      )),
            ),
          ),
          actions: [
            Container(
                // padding: EdgeInsets.only(right: 10),
                child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FilterLocalListPage()));
              },
              icon: Icon(
                Icons.search,
                color: SpotmiesTheme.onBackground,
              ),
            )),
            Container(
                // padding: EdgeInsets.only(right: 10),
                child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NotifyHome()));
              },
              icon: Icon(
                Icons.notifications_outlined,
                color: SpotmiesTheme.onBackground,
              ),
            )),
          ],
        ),
        body: ListView(
          children: [
            ProcessCard(images: images, titles: titles, color: color),
            PopularServices(
              icons: icons,
              serviceNames: serviceNames,
            ),
            Categories(color: color),
            banner(context),
            bottomFooter(context),
          ],
        ));
  }
}

//never get too tied to search technician on market ,make your work with spotmies now
bottomFooter(BuildContext context) {
  return Container(
      height: height(context) * 0.6,
      width: width(context),
      alignment: Alignment.center,
      padding: EdgeInsets.only(
          left: width(context) * 0.03, right: width(context) * 0.03),
      child: RichText(
        text: TextSpan(
          text: '\" ',
          style:
              fonts(width(context) * 0.1, FontWeight.bold, SpotmiesTheme.dull),
          children: <TextSpan>[
            TextSpan(
              text: 'Don\'t ',
              style: fonts(
                  width(context) * 0.13, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: 'get ',
              style: fonts(
                  width(context) * 0.07, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: 'tired ',
              style: fonts(
                  width(context) * 0.1, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: 'searching ',
              style: fonts(
                  width(context) * 0.16, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: 'for ',
              style: fonts(
                  width(context) * 0.1, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: 'technicians ',
              style: fonts(
                  width(context) * 0.19, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: ' in the',
              style: fonts(
                  width(context) * 0.05, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: ' market',
              style: fonts(
                  width(context) * 0.13, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: ', get your ',
              style: fonts(
                  width(context) * 0.08, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: 'work done',
              style: fonts(
                  width(context) * 0.14, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: ' with ',
              style: fonts(
                  width(context) * 0.08, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: 'Spotmies ',
              style: fonts(
                  width(context) * 0.15, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: 'now',
              style: fonts(
                  width(context) * 0.07, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: '\" ',
              style: fonts(
                  width(context) * 0.1, FontWeight.bold, SpotmiesTheme.dull),
            )
          ],
        ),
      ));
}

bottomFooterForPartner(BuildContext context) {
  return Container(
      height: height(context) * 0.5,
      width: width(context),
      padding: EdgeInsets.only(
          left: width(context) * 0.03, right: width(context) * 0.03),
      child: RichText(
        text: TextSpan(
          text: '\" ',
          style:
              fonts(width(context) * 0.2, FontWeight.bold, SpotmiesTheme.dull),
          children: <TextSpan>[
            TextSpan(
              text: 'A ',
              style: fonts(
                  width(context) * 0.1, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: 'good repution',
              style: fonts(
                  width(context) * 0.21, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: ' is more ',
              style: fonts(
                  width(context) * 0.1, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: 'valuable ',
              style: fonts(
                  width(context) * 0.18, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: 'than ',
              style: fonts(
                  width(context) * 0.1, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: 'money',
              style: fonts(
                  width(context) * 0.15, FontWeight.bold, SpotmiesTheme.dull),
            ),
            TextSpan(
              text: ' \" ',
              style: fonts(
                  width(context) * 0.2, FontWeight.bold, SpotmiesTheme.dull),
            )
          ],
        ),
      ));
}

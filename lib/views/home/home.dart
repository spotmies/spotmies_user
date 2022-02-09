import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/home_controllers/home_controller.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/home/categeries_card.dart';
import 'package:spotmies/views/home/data.dart';
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

  @override
  void initState() {
    up = Provider.of<UniversalProvider>(context, listen: false);
    up.setCurrentConstants("home");
    _homeController.getAddressofLocation();

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
                await _homeController.getAddressofLocation();
              },
              child: Text(
                  (_homeController.add2 == null)
                      ? 'seethammadhara'
                      : _homeController.add2!,
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
              onPressed: () {},
              icon: Icon(
                Icons.notifications_outlined,
                color: SpotmiesTheme.onBackground,
              ),
            )),
            // Container(
            //     padding: EdgeInsets.only(right: 10),
            //     child: profilePic(context, null, 'u', width(context) * 0.1,
            //         edit: false)),
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
            // categeries(context, color),
            // banner(context)
          ],
        ));
  }
}

banner(BuildContext context) {
  return Column(
    children: [
      Container(
        height: height(context) * 0.2,
        width: width(context),
        child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(
                left: width(context) * 0.03, right: width(context) * 0.03),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                      height: height(context) * 0.18,
                      width: width(context) * 0.9,
                      padding: EdgeInsets.all(width(context) * 0.04),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              // color: Colors.amber,
                              width: width(context) * 0.35,
                              child: SvgPicture.asset(catImages[0])),
                          Container(
                            width: width(context) * 0.45,
                            height: height(context) * 0.16,
                            // color: Colors.amber,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextWid(
                                  text: 'Easy to use',
                                  align: TextAlign.end,
                                  size: width(context) * 0.06,
                                  weight: FontWeight.w600,
                                  color: Colors.grey[50],
                                ),
                                SizedBox(
                                  height: height(context) * 0.01,
                                ),
                                TextWid(
                                  text:
                                      'Easy to use hjfiausd jnfiunsdiuf jnsduifuis IJBFIUhgiu',
                                  align: TextAlign.end,
                                  size: width(context) * 0.04,
                                  flow: TextOverflow.visible,
                                  color: Colors.grey[100],
                                  weight: FontWeight.w500,
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    width: width(context) * 0.03,
                  )
                ],
              );
            }),
      ),
      SizedBox(
        height: height(context) * 0.05,
      )
    ],
  );
}

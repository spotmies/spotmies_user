import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/controllers/home_controllers/home_controller.dart';
import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/views/home/ServiceListVertical.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends StateMVC<Home> {
  HomeController _homeController;
  _HomeState() : super(HomeController()) {
    this._homeController = controller;
  }

  var list = [
    Center(
      child: Services(value: 0),
    ),
    Center(
      child: Services(value: 1),
    ),
    Center(
      child: Services(value: 2),
    ),
    Center(
      child: Services(value: 3),
    ),
    Center(
      child: Services(value: 4),
    ),
    Center(
      child: Services(value: 5),
    ),
    Center(
      child: Services(value: 6),
    ),
    Center(
      child: Services(value: 7),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    //getToken();
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.location_searching,
            color: Colors.indigo[900],
          ),
          title: Container(
            width: _width * 0.5,
            child: TextButton(
              child: Text(
                  _homeController.add2 == null
                      ? 'seethammadhara'
                      : _homeController.add2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.josefinSans(
                    fontSize: _width * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[900],
                  )),
              onPressed: () async {
                await _homeController.getAddressofLocation();
              },
            ),
          ),
          actions: [
            Container(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    // var index = 0;
                    // showSearch<String>(
                    //   context: context,
                    //   delegate: CustomDelegate(),
                    // );
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => FilterLocalListPage()));
                    // FilterLocalListPage();
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.indigo[900],
                  ),
                )),
            Container(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    // promotions(context, _hight, _width);
                    // partnerDetailsSummury(context, _hight, _width);
                  },
                  icon: Icon(
                    Icons.local_offer_sharp,
                    color: Colors.indigo[900],
                  ),
                )),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(_hight * 0.09),
            child: Container(
              height: _hight * 0.06,
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey[600],
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 0,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.indigo[900]),
                  labelStyle:
                      fonts(_width * 0.04, FontWeight.w600, Colors.white),
                  tabs: [
                    Tab(
                      icon: Center(
                        child: Text('All Services'),
                      ),
                    ),
                    Tab(
                      icon: Center(
                        child: Text('Tradesman Services'),
                      ),
                    ),
                    Tab(
                      icon: Center(
                        child: Text('Personal Care'),
                      ),
                    ),
                    Tab(
                      icon: Center(
                        child: Text('Domestic'),
                      ),
                    ),
                    Tab(
                      icon: Center(
                        child: Text('Software'),
                      ),
                    ),
                    Tab(
                      icon: Center(
                        child: Text('Designing'),
                      ),
                    ),
                    Tab(
                      icon: Center(
                        child: Text('Education'),
                      ),
                    ),
                    Tab(
                      icon: Center(
                        child: Text('Filming'),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        body: TabBarView(children: list),
        // backgroundColor: Colors.white,
        // appBar: AppBar(
        //   toolbarHeight: 48,
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   title: Container(
        //     width: _width * 0.5,
        //     child: Row(
        //       children: [
        //         Icon(
        //           Icons.location_on,
        //           color: Colors.blue[900],
        //           size: 15,
        //         ),
        //         TextButton(
        //           child: Text(
        //               _homeController.add2 == null
        //                   ? 'seethammadhara'
        //                   : _homeController.add2,
        //               overflow: TextOverflow.ellipsis,
        //               style: GoogleFonts.josefinSans(
        //                 fontSize: _width * 0.04,
        //                 fontWeight: FontWeight.bold,
        //                 color: Colors.blue[900],
        //               )),
        //           onPressed: () async {
        //             await _homeController.getAddressofLocation();
        //           },
        //         ),
        //       ],
        //     ),
        //   ),
        //   actions: [
        //     IconButton(
        //         icon: Icon(
        //           Icons.notifications_active,
        //           color: Colors.blue[900],
        //         ),
        //         onPressed: () async {}),
        //     SizedBox(
        //       width: 5,
        //     ),
        //   ],
        // ),
        // body: Container(
        //   padding: EdgeInsets.only(top: 15, left: 5, right: 5),
        //   width: _width * 1,
        //   child: GridView.builder(
        //     itemCount: _homeController.jobs.length,
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5),
        //     itemBuilder: (BuildContext context, int index) {
        //       return Column(
        //         children: [
        //           Padding(
        //             padding: EdgeInsets.all(5),
        //             child: FloatingActionButton(
        //                 mini: true,
        //                 heroTag: '$index',
        //                 backgroundColor: Colors.blue[900],
        //                 child: Icon(
        //                   _homeController.icons[index],
        //                   color: Colors.white,
        //                   size: _width * 0.05,
        //                 ),
        //                 onPressed: () {
        //                   Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) => PostAd(
        //                                 jobFromHome: index,
        //                               )));
        //                 }),
        //           ),
        //           SizedBox(
        //             height: _hight * 0.005,
        //           ),
        //           Text(_homeController.jobs[index],
        //               style: GoogleFonts.josefinSans(
        //                 fontSize: _width * 0.03,
        //                 color: Colors.black,
        //               ))
        //         ],
        //       );
        //     },
        //   ),
        // )
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';
// import 'package:spotmies/utilities/fonts.dart';
// import 'package:spotmies/views/home/ServiceListVertical.dart';

// class UserHome extends StatefulWidget {
//   const UserHome({Key key}) : super(key: key);

//   @override
//   _UserHomeState createState() => _UserHomeState();
//    HomeController _homeController;
// //   _HomeState() : super(HomeController()) {
// //     this._homeController = controller;
// //   }
// }

// class _UserHomeState extends StateMVC<UserHome> {
//   var list = [
//     Center(
//       child: Services(value: 0),
//     ),
//     Center(
//       child: Services(value: 1),
//     ),
//     Center(
//       child: Services(value: 2),
//     ),
//     Center(
//       child: Services(value: 3),
//     ),
//     Center(
//       child: Services(value: 4),
//     ),
//     Center(
//       child: Services(value: 5),
//     ),
//     Center(
//       child: Services(value: 6),
//     ),
//     Center(
//       child: Services(value: 7),
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     final _hight = MediaQuery.of(context).size.height -
//         MediaQuery.of(context).padding.top -
//         kToolbarHeight;
//     final _width = MediaQuery.of(context).size.width;
//     return DefaultTabController(
//       length: 8,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           leading: Icon(
//             Icons.location_searching,
//             color: Colors.indigo[900],
//           ),
//           title: Container(
//             width: _width * 0.5,
//             child:  TextButton(
//                   child: Text(
//                       _homeController.add2 == null
//                           ? 'seethammadhara'
//                           : _homeController.add2,
//                       overflow: TextOverflow.ellipsis,
//                       style: GoogleFonts.josefinSans(
//                         fontSize: _width * 0.04,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue[900],
//                       )),
//                   onPressed: () async {
//                     await _homeController.getAddressofLocation();
//                   },
//                 ),

//             // Text(
//             //   'MMTC,Seethammadhara',
//             //   overflow: TextOverflow.ellipsis,
//             //   style: fonts(_width * 0.045, FontWeight.w600, Colors.indigo[900]),
//             // ),
//           ),
//           actions: [
//             Container(
//                 padding: EdgeInsets.only(right: 10),
//                 child: IconButton(
//                   onPressed: () {
//                     // var index = 0;
//                     // showSearch<String>(
//                     //   context: context,
//                     //   delegate: CustomDelegate(),
//                     // );
//                     // Navigator.of(context).push(MaterialPageRoute(
//                     //     builder: (context) => FilterLocalListPage()));
//                     // FilterLocalListPage();
//                   },
//                   icon: Icon(
//                     Icons.search,
//                     color: Colors.indigo[900],
//                   ),
//                 )),
//             Container(
//                 padding: EdgeInsets.only(right: 10),
//                 child: IconButton(
//                   onPressed: () {
//                     // promotions(context, _hight, _width);
//                     // partnerDetailsSummury(context, _hight, _width);
//                   },
//                   icon: Icon(
//                     Icons.local_offer_sharp,
//                     color: Colors.indigo[900],
//                   ),
//                 )),
//           ],
//           bottom: PreferredSize(
//             preferredSize: Size.fromHeight(_hight * 0.09),
//             child: Container(
//               height: _hight * 0.06,
//               padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
//               child: TabBar(
//                   isScrollable: true,
//                   unselectedLabelColor: Colors.grey[600],
//                   indicatorSize: TabBarIndicatorSize.tab,
//                   indicatorWeight: 0,
//                   indicator: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: Colors.indigo[900]),
//                   labelStyle:
//                       fonts(_width * 0.04, FontWeight.w600, Colors.white),
//                   tabs: [
//                     Tab(
//                       icon: Center(
//                         child: Text('All Services'),
//                       ),
//                     ),
//                     Tab(
//                       icon: Center(
//                         child: Text('Tradesman Services'),
//                       ),
//                     ),
//                     Tab(
//                       icon: Center(
//                         child: Text('Personal Care'),
//                       ),
//                     ),
//                     Tab(
//                       icon: Center(
//                         child: Text('Domestic'),
//                       ),
//                     ),
//                     Tab(
//                       icon: Center(
//                         child: Text('Software'),
//                       ),
//                     ),
//                     Tab(
//                       icon: Center(
//                         child: Text('Designing'),
//                       ),
//                     ),
//                     Tab(
//                       icon: Center(
//                         child: Text('Education'),
//                       ),
//                     ),
//                     Tab(
//                       icon: Center(
//                         child: Text('Filming'),
//                       ),
//                     ),
//                   ]),
//             ),
//           ),
//         ),
//         body: TabBarView(children: list),
//       ),
//     );
//   }
// }

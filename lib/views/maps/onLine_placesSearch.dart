import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/apiCalls/placesAPI.dart';

import 'package:spotmies/models/placesModel.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/searchWidget.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/maps/maps.dart';

class OnlinePlaceSearch extends StatefulWidget {
  @override
  OnlinePlaceSearchState createState() => OnlinePlaceSearchState();
}

class OnlinePlaceSearchState extends State<OnlinePlaceSearch> {
  // List<Places> geoLocations = [];
  String query = '';
  Timer debouncer;
  UniversalProvider universalProvider;

  @override
  void initState() {
    super.initState();
    universalProvider = Provider.of<UniversalProvider>(context, listen: false);

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    if (universalProvider.geoLocations.length > 0) return;
    // var geoLocationss = await PlacesApi.getLoc(query);
    universalProvider.setLocationsLoader(true);
    List geoLocationss = await PlacesApi.getAllLocations();
    universalProvider.setLocationsLoader(false);
    universalProvider.setGeoLocations(geoLocationss);
    // setState(() => this.geoLocations = geoLocations);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Consumer<UniversalProvider>(builder: (context, data, child) {
          return SafeArea(
            child: Column(
              children: [
                // LinearProgressIndicator(
                //   color: Colors.indigo[900],
                //   backgroundColor: Colors.grey[100],
                // ),
                buildSearch(),
                data.locationsLoader
                    ? Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.indigo[900],
                              backgroundColor: Colors.grey[100],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextWidget(
                              text: 'Please Wait Data is Fetching ....',
                            )
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: data.searchLocations.length,
                          itemBuilder: (context, index) {
                            final book = data.searchLocations[index];

                            //return

                            if (index == 0) {
                              return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Maps(
                                                  isNavigate: false,
                                                )));
                                  },
                                  leading: CircleAvatar(
                                      backgroundColor: Colors.grey[200],
                                      child: Icon(Icons.gps_fixed)),
                                  title: TextWidget(
                                    text: 'Your Location',
                                    size: 15,
                                    weight: FontWeight.w700,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.directions),
                                  ));
                            } else {
                              return buildBook(book);
                            }
                          },
                        ),
                      ),
              ],
            ),
          );
        }),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Find Place',
        icon: Icons.location_searching,
        onChanged: searchLocations,
      );
  searchLocations(String query) {
    if (query.length > 3) {
      dynamic searches = getArea(query, universalProvider.geoLocations);
      universalProvider.setSearchLocations(searches);
    } else if (query.length == 0) {
      universalProvider.showAllLocation();
    }
  }

  Future searchBook(String query) async => debounce(() async {
        final geoLocations = await PlacesApi.getLoc(query);

        if (!mounted) return;

        // setState(() {
        //   this.query = query;
        //   this.geoLocations = geoLocations;
        // });
      });

  Widget buildBook(dynamic geo) => ListTile(
      onTap: () {
        log(geo['coordinates'].toString());

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Maps(
                      coordinates: geo['coordinates'],
                      isNavigate: false,
                      isSearch: true,
                    )));
      },
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: Icon(
          Icons.near_me,
          color: Colors.grey[700],
        ),
      ),
      title: TextWidget(
        text: geo['subLocality'],
        size: 15,
        weight: FontWeight.w600,
      ),
      subtitle: TextWidget(
        text: geo['addressLine'],
        size: 12,
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.directions),
      ));
}

// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:spotmies/apiCalls/apiCalling.dart';
// import 'package:spotmies/apiCalls/apiUrl.dart';
// import 'package:spotmies/utilities/searchWidget.dart';
// import 'package:spotmies/views/maps/placesModel.dart';

// class MapPlaceSearch extends StatefulWidget {
//   @override
//   MapPlaceSearchState createState() => MapPlaceSearchState();
// }

// class MapPlaceSearchState extends State<MapPlaceSearch> {
//   List<Places> place;
//   String query = '';
//   var mapplace;
//   var isLoading = false;

// //  fetchData() async {
// //     setState(() {
// //       isLoading = true;
// //     });
// //     var response = await Server().getMethod(API.places);
// //     if (response.statusCode == 200) {
// //       place = (json.decode(response.body) as List)
// //           .map((data) => new Places.fromJson(data))
// //           .toList();
// //       setState(() {
// //         isLoading = false;
// //       });
// //     } else {
// //       throw Exception('Failed to load photos');
// //     }
// //   }

//   @override
//   void initState() {
//     super.initState();

//     place = allJobs;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // WidgetsBinding.instance.addPostFrameCallback((_) async {
//     //   final prefs = await SharedPreferences.getInstance();
//     //   String mpd = prefs.getString('places');
//     //   // log(jsonDecode(mpd));
//     //   mapplace = mpd;
//     // });

//     return Scaffold(
//       body: SafeArea(
//           // child:Text(jsonDecode(mapplace))
//          child: Column(
//             children: <Widget>[
//               buildSearch(),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: 1,
//                   itemBuilder: (context, index) {
//                     final book = place[index];
//                     log(book.toJson().toString());
//                     return buildBook(book);
//                   },
//                 ),
//               ),
//             ],
//           ),
//           ),
//     );
//   }

//   Widget buildSearch() => SearchWidget(
//         text: query,
//         hintText: 'Search',
//         onChanged: searchBook,
//       );

//   Widget buildBook(Places map) => ListTile(
//         onTap: () {
//          // log(map.coordinates.latitude.toString() + map.coordinates.logitude.toString());
//         },
//         leading: IconButton(
//           onPressed: () {},
//           icon: Icon(Icons.home_repair_service),
//         ),
//         //  Image.network(
//         //   job.urlImage,
//         //   fit: BoxFit.cover,
//         //   width: 50,
//         //   height: 50,
//         // ),
//         title: Text(
//           //'',
//          map.subLocality,
//           style: GoogleFonts.josefinSans(
//               color: Colors.grey[900], fontWeight: FontWeight.w600),
//         ),
//         subtitle: Text(
//           //'',
//           map.addressLine,
//           style: GoogleFonts.josefinSans(
//               color: Colors.grey[600], fontWeight: FontWeight.w500),
//         ),
//       );

//   void searchBook(String query) {
//     final books = allJobs.where((map) {
//       final sublocality = map.subLocality.toLowerCase();
//       final addressline = map.addressLine.toLowerCase();
//       final searchLower = query.toLowerCase();

//       return sublocality.contains(searchLower) ||
//           addressline.contains(searchLower);
//     }).toList();

//     setState(() {
//       this.query = query;
//       this.place = books;
//     });
//   }
// }

// var ss = {"id": '398', "job": "Electric", "canDoWorks": "nothing"};

// final allJobs = [
//   Places(
//     id: ss['id'],
//     subLocality: ss['job'],
//     locality: ss['canDoWorks'],
//     addressLine:
//         'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
//   ),
// ];

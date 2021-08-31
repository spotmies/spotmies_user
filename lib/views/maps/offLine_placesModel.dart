import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
// import 'package:http/http.dart' as http;

import 'package:spotmies/models/placesModel.dart';
import 'package:spotmies/utilities/searchWidget.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/home/ads/maps.dart';

class OfflinePlaceSearch extends StatefulWidget {
  @override
  OfflinePlaceSearchState createState() => OfflinePlaceSearchState();
}

class OfflinePlaceSearchState extends State<OfflinePlaceSearch> {
  List<Places> geoLocations = [];
  String query = '';
  Timer debouncer;

  @override
  void initState() {
    super.initState();

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
    var geoLocations = await PlacesLocal.placeLoc(query);
    // .catchError((e) {
    //   log(e.toString());
    // });
    // log('message');

    setState(() => this.geoLocations = geoLocations);
  }

  @override
  Widget build(BuildContext context) {
    // log(geoLocations.length.toString());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            buildSearch(),
            geoLocations.length == 0
                ? Container(
                    height: 600,
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
                      itemCount: geoLocations.length,
                      itemBuilder: (context, index) {
                        final book = geoLocations[index];
                        if (index == 0) {
                          return ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Maps()));
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
      ),
    );
  }

  Widget buildSearch() {
    return SearchWidget(
      text: query,
      hintText: 'Find Place',
      icon: Icons.location_searching,
      onChanged: searchBook,
    );
  }

  Future searchBook(String query) async {
    debounce(() async {
      final geoLoc = await PlacesLocal.placeLoc(query);
      // log(geoLoc.toString());

      if (!mounted) return;

      setState(() {
        this.query = query;
        this.geoLocations = geoLoc;
      });
    });
  }

  Widget buildBook(Places geo) {
    // log(geo.subLocality);
    return ListTile(
        onTap: () {
          log(geo.coordinates.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Maps(coordinates: geo.coordinates)));
        },
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Icon(
            Icons.near_me,
            color: Colors.grey[700],
          ),
        ),
        title: TextWidget(
          text: geo.subLocality,
          size: 15,
          weight: FontWeight.w600,
        ),
        subtitle: TextWidget(
          text: geo.addressLine,
          size: 12,
        ),
        trailing: Icon(Icons.directions));
  }
}

class PlacesLocal {
  static Future<List<Places>> placeLoc(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var location = prefs.getString('places');
    final places = jsonDecode(location);
    if (location != null) {
      return places.map((json) => Places.fromJson(json)).where((geo) {
        final subLocality = geo.subLocality.toLowerCase();
        final locality = geo.addressLine.toLowerCase();
        final coord = geo.coordinates.toString();
        final searchLower = query.toLowerCase();
        return subLocality.contains(searchLower) ||
            locality.contains(searchLower) ||
            coord.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}




 //  var geoLocations =  prefs.getString('places');
    // //  List<String> places = (jsonDecode(geoLocations)as List<dynamic>).cast<String>();
    //  List<dynamic> newData = List<dynamic>.from(json.decode(geoLocations));
    //  log(jsonDecode(geoLocations));
          // final List places = jsonDecode(geoLocations);



//  Future searchBook(String query) async => debounce(() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var geo =  prefs.getString('places');
//      final places = jsonDecode(geo);
//      //

//      final loc = places.where((locations){
//         final subLocality = locations.subLocality.toLowerCase();
//         final locality = locations.addressLine.toLowerCase();
//         final coord = locations.coordinates.toString();
//          final searchLower = query.toLowerCase();
//           return subLocality.contains(searchLower) ||
//           locality.contains(searchLower) ||
//           coord.contains(searchLower);
//      }).toList();
//         // final geoLocations = await PlacesLocal.placeLoc(query);

//         if (!mounted) return;

//         setState(() {
//           this.query = query;
//           this.geoLocations = geoLocations;
//         });
//       });
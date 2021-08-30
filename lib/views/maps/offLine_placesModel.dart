import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotmies/apiCalls/placesAPI.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
    final geoLocations = await PlacesLocal.geoLocal(query);

    setState(() => this.geoLocations = geoLocations);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Find Place',
        icon: Icons.location_searching,
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final geoLocations = await PlacesLocal.geoLocal(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.geoLocations = geoLocations;
        });
      });

  Widget buildBook(Places geo) => ListTile(
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

class PlacesLocal {
  static Future<List<Places>> geoLocal(String query) async {
    List place;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(place ==null){
      log(place.toString());
      getLoc(query);
      
    }if(place != null){
      log(place.toString());
      var mpd = prefs.getString('places');
    place = jsonDecode(mpd);
    final List geoLocations = place;
    return geoLocations.map((json) => Places.fromJson(json)).where((geo) {
      final subLocality = geo.subLocality.toLowerCase();
      final locality = geo.addressLine.toLowerCase();
      final coord = geo.coordinates.toString();
      final searchLower = query.toLowerCase();

      return subLocality.contains(searchLower) ||
          locality.contains(searchLower) ||
          coord.contains(searchLower);
    }).toList();

    }else{
       throw Exception();
    }
    
  }
}

Future<List<Places>> getLoc(String query) async {
  //  Map<String,dynamic> place;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final url = Uri.parse('https://spotmiesserver.herokuapp.com/api/geocode/all');
  final response = await http.get(url);
  prefs.setString('places', jsonEncode(response.body));

  if (response.statusCode == 200) {
    // final List geoLocations = json.decode(response.body);
    log('API Hit');
    

    // return geoLocations.map((json) => Places.fromJson(json)).where((geo) {
    //   final subLocality = geo.subLocality.toLowerCase();
    //   final locality = geo.addressLine.toLowerCase();
    //   final coord = geo.coordinates.toString();
    //   final searchLower = query.toLowerCase();

    //   return subLocality.contains(searchLower) ||
    //       locality.contains(searchLower) ||
    //       coord.contains(searchLower);
    // }).toList();
  } else {
    throw Exception();
  }
}

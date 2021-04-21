// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:latlong/latlong.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: MapApp(),
// //     );
// //   }
// // }

// class Gmap extends StatefulWidget {
//   @override
//   _GmapState createState() => _GmapState();
// }

// class _GmapState extends State<Gmap> {
//   double long = 49.5;
//   double lat = -0.09;
//   LatLng point = LatLng(49.5, -0.09);
//   var location = [];

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         FlutterMap(
//           options: MapOptions(
//             onTap: (p) async {
//               location = await Geocoder.local.findAddressesFromCoordinates(
//                   new Coordinates(p.latitude, p.longitude));

//               setState(() {
//                 point = p;
//                 print(p);
//               });

//               print(
//                   "${location.first.countryName} - ${location.first.featureName}");
//             },
//             center: LatLng(49.5, -0.09),
//             zoom: 5.0,
//           ),
//           layers: [
//             TileLayerOptions(
//                 urlTemplate:
//                     "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                 subdomains: ['a', 'b', 'c']),
//             MarkerLayerOptions(
//               markers: [
//                 Marker(
//                   width: 80.0,
//                   height: 80.0,
//                   point: point,
//                   builder: (ctx) => Container(
//                     child: Icon(
//                       Icons.location_on,
//                       color: Colors.red,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Card(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.all(16.0),
//                     hintText: "Search for your localisation",
//                     prefixIcon: Icon(Icons.location_on_outlined),
//                   ),
//                 ),
//               ),
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Text(
//                           "${location.first.countryName},${location.first.locality}, ${location.first.featureName}"),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Gmap extends StatefulWidget {
  @override
  _GmapState createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  var _controller = TextEditingController();
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyle);
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('id-1'),
        position: LatLng(17.833, 82.33),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // final _hight = MediaQuery.of(context).size.height -
    //     MediaQuery.of(context).padding.top -
    //     kToolbarHeight;
    // final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(
        //   Icons.arrow_back,
        //   //color: Colors.black,
        // ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Container(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search',
              // hintStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(width: 1, color: Colors.white)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(width: 1, color: Colors.white)),
            ),
          ),
        ),
      ),
      body:
          //  ListView(
          //   children: [
          //     //TextField(),
          //     Container(
          // height: _hight * 1,
          // width: _width * 1,
          // child:
          GoogleMap(
              onMapCreated: _onMapCreated,
              //mapType: MapType.terrain,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(17.833, 82.33),
                zoom: 15,
              )),
    );
    //     ],
    //   ),
    // );
  }
}

class Utils {
  static String mapStyle = '''
[]
  ''';
}

// import 'package:flutter/material.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:google_places_flutter/model/prediction.dart';

// // void main() => runApp(MyApp());

// // class MyApp extends StatelessWidget {
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: MyHomePage(title: 'Custom Autocomplete sample'),
// //     );
// //   }
// // }

// class Gmap extends StatefulWidget {
//   @override
//   _GmapState createState() => _GmapState();
// }

// class _GmapState extends State<Gmap> {
//   TextEditingController controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(''),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(height: 20),
//             placesAutoCompleteTextField(),
//           ],
//         ),
//       ),
//     );
//   }

//   placesAutoCompleteTextField() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: GooglePlaceAutoCompleteTextField(
//           textEditingController: controller,
//           googleAPIKey: "AIzaSyDsBYFDuPmxR3AtMFz-rO8vZrM2C-UoNdo",
//           inputDecoration: InputDecoration(hintText: "Search your location"),
//           debounceTime: 50,

//           // countries: ["in","fr"],

//           // isLatLngRequired: true,
//           // getPlaceDetailWithLatLng: (Prediction prediction) {
//           // print("placeDetails" + prediction.lng.toString());},

//           itmClick: (Prediction prediction) {
//             controller.text = prediction.description;

//             controller.selection = TextSelection.fromPosition(
//                 TextPosition(offset: prediction.description.length));
//           }
//           // default 600 ms ,
//           ),
//     );
//   }
// }

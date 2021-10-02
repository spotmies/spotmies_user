import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class Maps extends StatefulWidget {
  final String ordId;
  final Map coordinates;
  Maps({this.ordId, this.coordinates});
  @override
  _MapsState createState() => _MapsState(ordId, coordinates);
}

class _MapsState extends State<Maps> {
  TextEditingController searchController = TextEditingController();
  String ordId;
  Map coordinates;
  _MapsState(this.ordId, this.coordinates);
  var formkey = GlobalKey<FormState>();
  var scaffoldkey = GlobalKey<ScaffoldState>();
  GoogleMapController googleMapController;
  Position position;
  double lat;
  double long;
  String addressline = "";
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  void getmarker(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        onTap: () {
          bottomAddressSheet(coordinates['latitude'], coordinates['logitude']);
        },
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(snippet: 'Address'));
    setState(() {
      markers[markerId] = _marker;
    });
  }

  void getCurrentLocation() async {
    Position currentPosition =
        await GeolocatorPlatform.instance.getCurrentPosition();
    setState(() {
      position = currentPosition;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    if (position == null)
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    return Scaffold(
      key: scaffoldkey,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(alignment: Alignment.topCenter, children: [
          GoogleMap(
            onTap: (tapped) async {
              final coordinated =
                  Coordinates(tapped.latitude, tapped.longitude);
              var address = await Geocoder.local
                  .findAddressesFromCoordinates(coordinated);
              var firstAddress = address.first.addressLine;
              if (markers.isNotEmpty) markers.clear();
              if (markers.isEmpty) getmarker(tapped.latitude, tapped.longitude);

              setState(() {
                lat = tapped.latitude;
                long = tapped.longitude;
                addressline = firstAddress;
              });
              bottomAddressSheet(lat, long);
            },
            // mapType: MapType.satellite,
            buildingsEnabled: true,
            compassEnabled: true,
            trafficEnabled: true,
            myLocationButtonEnabled: true,

            onMapCreated: (GoogleMapController controller) {
              setState(() {
                googleMapController = controller;
              });
            },
            initialCameraPosition: CameraPosition(
                target: coordinates != null
                    ? navigateMaps(
                        coordinates['latitude'], coordinates['logitude'])
                    //LatLng(coordinates['latitude'], coordinates['logitude'])
                    : LatLng(position.latitude, position.longitude),
                zoom: 17),
            markers: Set<Marker>.of(markers.values),
          ),
        ]),
      ),
    );
  }

  navigateMaps(lati, logi) {
    if (markers.isNotEmpty) markers.clear();
    if (markers.isEmpty) getmarker(lati, logi);
    return LatLng(lati, logi);
  }

  @override
  void dispose() {
    super.dispose();
  }

  bottomAddressSheet(double lat, double long) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        elevation: 22,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            height: hight * 0.35,
            child: Column(
              children: [
                Container(
                  height: hight * 0.27,
                  padding: EdgeInsets.all(width * 0.05),
                  child: ListView(
                    children: [
                      TextWidget(
                        text: 'Your Address:',
                        size: width * 0.06,
                        weight: FontWeight.w600,
                        flow: TextOverflow.visible,
                      ),
                      SizedBox(
                        height: hight * 0.01,
                      ),
                      TextWidget(
                        text: addressline,
                        size: width * 0.055,
                        weight: FontWeight.w600,
                        flow: TextOverflow.visible,
                        color: Colors.grey[700],
                      ),
                      TextWidget(
                        text: lat.toString() + ", " + long.toString(),
                        size: width * 0.055,
                        weight: FontWeight.w600,
                        flow: TextOverflow.visible,
                        color: Colors.grey[700],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButtonWidget(
                      minWidth: width * 0.3,
                      height: hight * 0.05,
                      bgColor: Colors.indigo[50],
                      buttonName: 'Close',
                      textColor: Colors.grey[900],
                      borderRadius: 15.0,
                      textSize: width * 0.04,
                      leadingIcon: Icon(
                        Icons.clear,
                        size: width * 0.04,
                        color: Colors.grey[900],
                      ),
                      borderSideColor: Colors.indigo[50],
                      onClick: () {
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButtonWidget(
                      minWidth: width * 0.5,
                      height: hight * 0.05,
                      bgColor: Colors.indigo[900],
                      onClick: () {
                        launch(
                            'https://www.google.com/maps/search/?api=1&query=$lat,$long');
                      },
                      buttonName: 'Navigate',
                      textColor: Colors.white,
                      borderRadius: 15.0,
                      textSize: width * 0.04,
                      trailingIcon: Icon(
                        Icons.near_me,
                        size: width * 0.03,
                        color: Colors.white,
                      ),
                      borderSideColor: Colors.indigo[900],
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}







// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:spotmies/providers/mapsProvider.dart';
// import 'package:spotmies/views/profile/profile_shimmer.dart';

// class Maps extends StatefulWidget {
//   String ordId;
//   Maps({
//     this.ordId,
//   });
//   @override
//   _MapsState createState() => _MapsState(ordId);
// }

// class _MapsState extends State<Maps> {
//   TextEditingController searchController = TextEditingController();
//   String ordId;
//   _MapsState(
//     this.ordId,
//   );
//   var formkey = GlobalKey<FormState>();
//   var scaffoldkey = GlobalKey<ScaffoldState>();
//   GoogleMapController googleMapController;
//   Position position;
//   double lat;
//   double long;
//   String addressline = "";
//   // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//   // void getmarker(double lat, double long) {
//   //   MarkerId markerId = MarkerId(lat.toString() + long.toString());
//   //   Marker _marker = Marker(
//   //       markerId: markerId,
//   //       position: LatLng(lat, long),
//   //       draggable: true,
//   //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
//   //       infoWindow: InfoWindow(snippet: 'Address'));
//   //   setState(() {
//   //     markers[markerId] = _marker;
//   //   });
//   // }

//   // void getCurrentLocation() async {
//   //   Position currentPosition =
//   //       await GeolocatorPlatform.instance.getCurrentPosition();
//   //   setState(() {
//   //     position = currentPosition;
//   //   });
//   // }

//   @override
//   void initState() {
//     super.initState();
//     var details = Provider.of<MapsProvider>(context, listen: false);
//     details.getmarker(lat, long);
//     details.getCurrentLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     CircularProgressIndicator();
//     return Scaffold(
//       key: scaffoldkey,
//       resizeToAvoidBottomInset: false,
//       body: Consumer<MapsProvider>(builder: (context, data, child) {
//         if (data.position == null)
//           return Center(child: profileShimmer(context));
//         var m = data.markers;
//         var p = data.position;
//         print(p);
//         print(m);

//         return Container(
//           child: Stack(alignment: Alignment.topCenter, children: [
//             GoogleMap(
//               onTap: (tapped) async {
//                 final coordinated =
//                     Coordinates(tapped.latitude, tapped.longitude);
//                 var address = await Geocoder.local
//                     .findAddressesFromCoordinates(coordinated);
//                 var firstAddress = address.first.addressLine;
//                 if (data.markers.isNotEmpty) data.markers.clear();
//                 if (data.markers.isEmpty)
//                   MapsProvider().getmarker(tapped.latitude, tapped.longitude);

//                 setState(() {
//                   lat = tapped.latitude;
//                   long = tapped.longitude;
//                   addressline = firstAddress;
//                 });
//                 bottomSheet();
//               },
//               // myLocationButtonEnabled: true,

//               buildingsEnabled: true,
//               compassEnabled: true,
//               trafficEnabled: true,
//               // myLocationButtonEnabled: true,
//               onMapCreated: (GoogleMapController controller) {
//                 setState(() {
//                   googleMapController = controller;
//                 });
//               },
//               initialCameraPosition: CameraPosition(
//                   target: LatLng(
//                       //17.356, 21.654
//                       p.latitude,
//                       p.longitude),
//                   zoom: 15),
//               markers: Set<Marker>.of(m.values),
//             ),
//             // FloatingSearchAppBar(
//             //   title: const Text('Title'),
//             //   transitionDuration: const Duration(milliseconds: 800),
//             //   color: Colors.greenAccent.shade100,
//             //   colorOnScroll: Colors.greenAccent.shade200,
//             //   automaticallyImplyBackButton: false,
//             //   clearQueryOnClose: true,
//             //   hint: 'Search...',
//             //   iconColor: Colors.grey,
//             //   transitionCurve: Curves.easeInOutCubic,
//             //   // actions: [],
//             //   // progress: true,
//             //   debounceDelay: const Duration(milliseconds: 500),
//             //   body: ListView.separated(
//             //     padding: EdgeInsets.zero,
//             //     itemCount: 100,
//             //     separatorBuilder: (context, index) => const Divider(),
//             //     itemBuilder: (context, index) {
//             //       return ListTile(
//             //         onTap: () {
//             //           print(val[index]);
//             //         },
//             //         // title: Text('Item $index'),
//             //       );
//             //     },
//             //   ),
//             // )

//             // SafeArea(
//             //   child: Padding(
//             //     padding: EdgeInsets.only(top: 10),
//             //     child: Container(
//             //       padding: EdgeInsets.only(
//             //         right: 10,
//             //         left: 10,
//             //       ),
//             //       constraints: BoxConstraints(
//             //           maxHeight: _hight * 0.11, minHeight: _hight * 0.09),
//             //       width: _width * 0.9,
//             //       // height: _hight * 0.09,
//             //       decoration: BoxDecoration(
//             //           boxShadow: [
//             //             BoxShadow(
//             //                 color: Colors.grey[400],
//             //                 blurRadius: 5,
//             //                 spreadRadius: 2,
//             //                 offset: Offset(0, 4))
//             //           ],
//             //           color: Colors.white,
//             //           borderRadius: BorderRadius.only(
//             //               topLeft: Radius.circular(30),
//             //               topRight: Radius.circular(30),
//             //               bottomLeft: Radius.circular(30),
//             //               bottomRight: Radius.circular(30))),
//             //       child: Form(
//             //         key: formkey,
//             //         child: TextFormField(
//             //           textInputAction: TextInputAction.search,

//             //           onFieldSubmitted: (value) {
//             //             print(value);
//             //           },
//             //           textCapitalization: TextCapitalization.sentences,
//             //           decoration: InputDecoration(
//             //             suffixIcon: IconButton(
//             //               icon: Icon(
//             //                 Icons.search,
//             //                 color: Colors.grey[600],
//             //               ),
//             //               onPressed: () {
//             //                 if (formkey.currentState.validate()) {
//             //                   formkey.currentState.save();
//             //                   print('$searchController');
//             //                 }
//             //               },
//             //             ),
//             //             errorStyle: TextStyle(color: Colors.blue[900]),
//             //             focusedErrorBorder: OutlineInputBorder(
//             //                 borderRadius: BorderRadius.all(Radius.circular(15)),
//             //                 borderSide:
//             //                     BorderSide(width: 1, color: Colors.white)),
//             //             focusedBorder: OutlineInputBorder(
//             //                 borderRadius: BorderRadius.all(Radius.circular(15)),
//             //                 borderSide:
//             //                     BorderSide(width: 1, color: Colors.white)),
//             //             enabledBorder: OutlineInputBorder(
//             //                 borderRadius: BorderRadius.all(Radius.circular(15)),
//             //                 borderSide:
//             //                     BorderSide(width: 1, color: Colors.white)),
//             //             hintStyle: TextStyle(fontSize: 17),
//             //             hintText: 'Search',
//             //           ),
//             //           controller: searchController,
//             //           validator: (value) {
//             //             if (value.isEmpty) {
//             //               return 'Please enter input to get service';
//             //             }
//             //             return null;
//             //           },
//             //           //maxLength: 10,
//             //           keyboardType: TextInputType.streetAddress,
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             // )
//           ]),
//         );
//       }),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   bottomSheet() {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           // BorderRadius.only(
//           //     topLeft: Radius.circular(30), topRight: Radius.circular(30));
//           return Container(
//             color: Colors.transparent,
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.2,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       topRight: Radius.circular(30))),
//               width: double.infinity,
//               child: Column(
//                 children: [
//                   Text(
//                     addressline,
//                     style: TextStyle(fontSize: 25),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }

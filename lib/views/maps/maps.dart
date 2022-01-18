import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/addressExtractor.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';
import 'package:url_launcher/url_launcher.dart';

class Maps extends StatefulWidget {
  final Map coordinates;
  final bool isNavigate;
  final bool isSearch;
  final Function? onSave;
  final bool popBackTwice;
  final String actionLabel;
  // final AdController addresscontroller;
  Maps(
      {this.coordinates = const {},
      this.isNavigate = true,
      this.isSearch = true,
      this.onSave,
      this.popBackTwice = false,
      this.actionLabel = "save"
      // this.addresscontroller
      });
  @override
  _MapsState createState() => _MapsState(coordinates);
}

class _MapsState extends State<Maps> {
  TextEditingController searchController = TextEditingController();
  late UniversalProvider up;
  late Map coordinates;
  _MapsState(this.coordinates);
  var formkey = GlobalKey<FormState>();
  var scaffoldkey = GlobalKey<ScaffoldState>();
  late GoogleMapController googleMapController;
  Map<String, double> generatedCoordinates = {"lat": 0.00, "log": 0.00};
  late Position position;
  late double lat;
  late double long;
  String addressline = "";
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  void getmarker(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        onTap: () async {
          final coordinated = coordinates == null
              ? Coordinates(position.latitude, position.longitude)
              : Coordinates(coordinates['latitude'], coordinates['logitude']);
          var address =
              await Geocoder.local.findAddressesFromCoordinates(coordinated);
          var firstAddress = address.first.addressLine;

          setState(() {
            lat = coordinates == null
                ? position.latitude
                : coordinates['latitude'];
            long = coordinates == null
                ? position.latitude
                : coordinates['logitude'];
            addressline = firstAddress;
          });
          coordinates == null
              ? bottomAddressSheet(
                  position.latitude,
                  position.longitude,
                )
              : bottomAddressSheet(
                  coordinates['latitude'],
                  coordinates['logitude'],
                );
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
    up = Provider.of<UniversalProvider>(context, listen: false);
    up.setCurrentConstants("maps");
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    // final height(context) = MediaQuery.of(context).size.height -
    //     MediaQuery.of(context).padding.top -
    //     kToolbarHeight;
    // final width(context) = MediaQuery.of(context).size.width;
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
              bottomAddressSheet(
                lat,
                long,
              );
            },
            // mapType: MapType.satellite,

            buildingsEnabled: true,
            compassEnabled: false,
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
                    : navigateMaps(position.latitude, position.longitude),
                zoom: 17),
            markers: Set<Marker>.of(markers.values),
          ),
          if (widget.isSearch)
            Positioned(
                top: height(context) * 0.07,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: width(context) * 0.05,
                        right: width(context) * 0.03),
                    height: height(context) * 0.07,
                    width: width(context) * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              spreadRadius: 3)
                        ],
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWid(
                          text: 'Search',
                          size: width(context) * 0.05,
                          color: Colors.grey.shade500,
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.grey[500],
                        ),
                      ],
                    ),
                  ),
                ))
        ]),
      ),
    );
  }

  navigateMaps(lati, logi) {
    // if (markers.isNotEmpty) markers.clear();
    if (markers.isEmpty) getmarker(lati, logi);
    return LatLng(lati, logi);
  }

  @override
  void dispose() {
    super.dispose();
  }

  bottomAddressSheet(
    double lat,
    double long,
  ) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    generatedCoordinates['lat'] = lat;
    generatedCoordinates['log'] = long;
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
                      TextWid(
                        text: 'Your Address:',
                        size: width * 0.06,
                        weight: FontWeight.w600,
                        flow: TextOverflow.visible,
                      ),
                      SizedBox(
                        height: hight * 0.01,
                      ),
                      TextWid(
                        text: addressline,
                        size: width * 0.055,
                        weight: FontWeight.w600,
                        flow: TextOverflow.visible,
                        color: Colors.grey.shade700,
                      ),
                      TextWid(
                        text: lat.toString() + ", " + long.toString(),
                        size: width * 0.055,
                        weight: FontWeight.w600,
                        flow: TextOverflow.visible,
                        color: Colors.grey.shade700,
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
                    widget.isNavigate == true
                        ? ElevatedButtonWidget(
                            minWidth: width * 0.5,
                            height: hight * 0.05,
                            bgColor: Colors.indigo[900],
                            onClick: () async {
                              try {
                                launch(
                                    'https://www.google.com/maps/search/?api=1&query=$lat,$long');
                              } catch (e) {
                                snackbar(context, "something went worng");
                              }
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
                        : ElevatedButtonWidget(
                            minWidth: width * 0.5,
                            height: hight * 0.05,
                            bgColor: Colors.indigo[900],
                            onClick: () async {
                              log(lat.toString() + '\n' + long.toString());

                              final coordinates = Coordinates(lat, long);
                              var addresses = await Geocoder.local
                                  .findAddressesFromCoordinates(coordinates);

                              Map<String, String> generatedAddress =
                                  addressExtractor(addresses.first);
                              log(generatedAddress.toString());
                              if (widget.onSave == null) {
                                return snackbar(
                                    context, "something went wrong");
                              } else {
                                widget.onSave!(
                                    generatedCoordinates, generatedAddress);
                                Navigator.pop(context);
                                if (widget.popBackTwice) Navigator.pop(context);
                              }
                              // setState(() {
                              //   addresscontroller.fullAddress = val;
                              // });
                              // }
                              // Navigator.of(context)
                              //     .popUntil(ModalRoute.withName("/postad"));
                            },
                            buttonName: widget.actionLabel,
                            textColor: Colors.white,
                            borderRadius: 15.0,
                            textSize: width * 0.04,
                            trailingIcon: Icon(
                              Icons.gps_fixed,
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

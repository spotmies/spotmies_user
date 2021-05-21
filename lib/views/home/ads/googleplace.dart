// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'dart:math' show cos, sqrt, asin;
// import 'dart:core';

// import '../../../main.dart';

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();  
// }

// class _MapScreenState extends State<MapScreen> {
//   Completer<GoogleMapController> _controller = Completer();
 
//   static final CameraPosition _initialCameraPosition = CameraPosition(
//     target: LatLng(33.515343, 36.289590),
//     zoom: 14.4746,
//   );

//   LatLng currentLocation = _initialCameraPosition.target;

//   BitmapDescriptor _locationIcon;

//   Set<Marker> _markers = {};

//   Set<Polyline> _polylines = {};

//   @override
//   void initState() {
//     _buildMarkerFromAssets();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(onPressed: _showSearchDialog, icon: Icon(Icons.search))
//         ],
//       ),
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           GoogleMap(
//             initialCameraPosition: _initialCameraPosition,
//             mapType: MapType.normal,
//             onMapCreated: (controller) async {
//               String style = await DefaultAssetBundle.of(context)
//                   .loadString('assets/map_style.json');
//               // customize your map style at: https://mapstyle.withgoogle.com/
//               controller.setMapStyle(style);
//               _controller.complete(controller);
//             },
//             onCameraMove: (e) => currentLocation = e.target,
//             markers: _markers,
//             polylines: _polylines,
//           ),
//           SizedBox(
//             width: 40,
//             height: 40,
//             child: Image.asset('assets/images/location_icon.png'),
//           )
//         ],
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: () => _drawPolyline(
//                 LatLng(38.52900208591146, -98.54919254779816), currentLocation),
//             child: Icon(Icons.settings_ethernet_rounded),
//           ),
//           FloatingActionButton(
//             onPressed: () => _setMarker(currentLocation),
//             child: Icon(Icons.location_on),
//           ),
//           FloatingActionButton(
//             onPressed: () => _getMyLocation(),
//             child: Icon(Icons.gps_fixed),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         height: 20,
//         alignment: Alignment.center,
//         child: Text(
//             "lat: ${currentLocation.latitude}, long: ${currentLocation.longitude}"),
//       ),
//     );
//   }

//   Future<void> _drawPolyline(LatLng from, LatLng to) async {
//     Polyline polyline = await PolylineService().drawPolyline(from, to);

//     _polylines.add(polyline);

//     _setMarker(from);
//     _setMarker(to);

//     setState(() {});
//   }

//   void _setMarker(LatLng _location) {
//     Marker newMarker = Marker(
//       markerId: MarkerId(_location.toString()),
//       icon: BitmapDescriptor.defaultMarker,
//       // icon: _locationIcon,
//       position: _location,
//       infoWindow: InfoWindow(
//           title: "Title",
//           snippet: "${currentLocation.latitude}, ${currentLocation.longitude}"),
//     );
//     _markers.add(newMarker);
//     setState(() {});
//   }

//   Future<void> _buildMarkerFromAssets() async {
//     if (_locationIcon == null) {
//       _locationIcon = await BitmapDescriptor.fromAssetImage(
//           ImageConfiguration(size: Size(48, 48)),
//           'assets/images/location_icon.png');
//       setState(() {});
//     }
//   }

//   Future<void> _showSearchDialog() async {
//     var p = await PlacesAutocomplete.show(
//         context: context,
//         apiKey: Constants.apiKey,
//         mode: Mode.fullscreen,
//         language: "ar",
//         //region: "ar",
//         offset: 0,
//         hint: "Type here...",
//         radius: 1000,
//         types: [],
//         strictbounds: false,
//         components: [Component(Component.country, "ar")]);
//     _getLocationFromPlaceId(p.placeId);
//   }

//   Future<void> _getLocationFromPlaceId(String placeId) async {
//     GoogleMapsPlaces _places = GoogleMapsPlaces(
//       apiKey: Constants.apiKey,
//       apiHeaders: await GoogleApiHeaders().getHeaders(),
//     );

//     PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(placeId);

//     _animateCamera(LatLng(detail.result.geometry.location.lat,
//         detail.result.geometry.location.lng));
//   }

//   Future<void> _getMyLocation() async {
//     LocationData _myLocation = await LocationService().getLocation();
//     _animateCamera(LatLng(_myLocation.latitude, _myLocation.longitude));
//   }

//   Future<void> _animateCamera(LatLng _location) async {
//     final GoogleMapController controller = await _controller.future;
//     CameraPosition _cameraPosition = CameraPosition(
//       target: _location,
//       zoom: 13.00,
//     );
//     print(
//         "animating camera to (lat: ${_location.latitude}, long: ${_location.longitude}");
//     controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
//   }
// }

// class PolylineService {
//   Future<Polyline> drawPolyline(LatLng from, LatLng to) async {
//     List<LatLng> polylineCoordinates = [];

//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         Constants.apiKey,
//         PointLatLng(from.latitude, from.longitude),
//         PointLatLng(to.latitude, to.longitude));

//     result.points.forEach((PointLatLng point) {
//       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//     });
//     _calcDistance(polylineCoordinates);
//     return Polyline(
//         polylineId: PolylineId("polyline_id ${result.points.length}"),
//         color: Colors.blue,
//         points: polylineCoordinates);
//   }

//   void _calcDistance(List<LatLng> polylineCoordinates) {
//     double totalDistance = 0.0;

//     // Calculating the total distance by adding the distance
//     // between small segments
//     for (int i = 0; i < polylineCoordinates.length - 1; i++) {
//       totalDistance += _coordinateDistance(
//         polylineCoordinates[i].latitude,
//         polylineCoordinates[i].longitude,
//         polylineCoordinates[i + 1].latitude,
//         polylineCoordinates[i + 1].longitude,
//       );
//     }

//     print("distance = ${totalDistance.toStringAsFixed(2)} km");
//   }

//   double _coordinateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }
// }

// class Constants {
//   static const String apiKey = "AIzaSyDsBYFDuPmxR3AtMFz-rO8vZrM2C-UoNdo";
// }

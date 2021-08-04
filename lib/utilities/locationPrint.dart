import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';

class LocationGet extends StatefulWidget {
  const LocationGet({Key key}) : super(key: key);

  @override
  _LocationGetState createState() => _LocationGetState();
}

class _LocationGetState extends State<LocationGet> {
  List coor = [
    {17.836985, 83.698589},
    {17.885985, 83.698589},
    {17.836985, 83.612389}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Padding(
            padding: EdgeInsets.all(40.0),
            child: Text(function().toString()),
          ),
        );
      },
    ));
  }
}

function() async {
  var startLat = 17.538455;
  var startLong = 83.087737;
  var endLat = 17.934493;
  var endLong = 83.41598;
  var valstr1;
  var valstr2;
  var coor;
  var a;
  var b;
  var c;
  var d;
  var e;
  var f;
  var g;
  var h;
  List loc = [];
  // final coordinates = new Coordinates(21.10, 45.50);
  // var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  // var firstAddress = address.first.addressLine;

  for (var j = startLat; j < endLat; j += 0.01000) {
    for (var i = startLong; i < endLong; i += 0.01000) {
      valstr1 = j;
      valstr2 = i;
      coor = Coordinates(valstr1, valstr2);
      var address = await Geocoder.local.findAddressesFromCoordinates(coor);
      a = address.first.subLocality;
      b = address.first.locality;
      c = address.first.coordinates;
      d = address.first.addressLine.toLowerCase();
      e = address.first.subAdminArea;
      f = address.first.postalCode;
      g = address.first.adminArea;
      h = address.first.subThoroughfare;

      var val = {
        "locality": "$d",
        "postalCode": "$f",
        "loclity": "$b",
        "coordinates": "$c"
      };

      // loc.add(val.toString());

      log(val.toString());

      // log(a.toString());
      // log(b.toString());
      // log(c.toString());
      // log(d.toString());
      // // log(e.toString());
      // log(f.toString());
      // log(g.toString());
      // // log(h.toString());
      // log('message');

      // var s = (valstr1 + valstr2);
      // var addresses = Geocoder.local.findAddressesFromCoordinates(
      //   s,
      // );

      // print(Geocoder.local.findAddressesFromCoordinates(coordinates));
      // print('${valstr1.substring(0, 9)},${valstr2.substring(0, 9)}');

    }
  }
  // log(firstAddress);
  // return '${valstr1.substring(0, 9)},${valstr2.substring(0, 9)}';
  return '';
}

// function(List coor) {
//   // for (var e in coor) {
//   //   print(e);
//   //   return Text(e.toString());
//   // }

//   for (var i = 0; i < coor.length; i++) {
//     return Text(coor[i]);
//   }
// }

//  for (int i = 0; i <= len; i++) {
//                                     var imageData = {
//                                       'msg': _chatScreenController.imageLink[i],
//                                       'timestamp':
//                                           _chatScreenController.timestamp,
//                                       'sender': 'u',
//                                       'type': 'media'
//                                     };
//                                     String temp = jsonEncode(imageData);
//                                     await FirebaseFirestore.instance
//                                         .collection('messaging')
//                                         .doc(value)
//                                         .update({
//                                       'createdAt': DateTime.now(),
//                                       'body': FieldValue.arrayUnion([temp]),
//                                       'pmsgcount':
//                                           pread == 0 ? msgcount + 1 : 0,
//                                     });
//                                     Navigator.pop(context);
//                                   }

// getAddressofLocation(coordinates) async {
//   // Position position = await Geolocator.getCurrentPosition(
//   //     desiredAccuracy: LocationAccuracy.high);
//   // final coordinates = Coordinates(position.latitude, position.longitude);
//   var addresses =
//       await Geocoder.local.findAddressesFromCoordinates(coordinates);

//   // setState(() {
//   //   add1 = addresses.first.featureName;
//   //   add2 = addresses.first.addressLine;
//   //   add3 = addresses.first.subLocality;
//   // });
// }

// "{17.33,8322}"

var locationData = [
  {
    'locality':
        'mutyalammapalem rd, cheepurupalle east, andhra pradesh 531020, india',
    'postalCode': '531020',
    'loclity': 'Cheepurupalle East',
    'coordinates': {17.5392901, 83.0882101}
  },
];

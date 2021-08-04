import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';

class LocationGet extends StatefulWidget {
  const LocationGet({Key key}) : super(key: key);

  @override
  _LocationGetState createState() => _LocationGetState();
}

class _LocationGetState extends State<LocationGet> {
  // List coor = [
  //   {17.836985, 83.698589},
  //   {17.885985, 83.698589},
  //   {17.836985, 83.612389}
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("click"),
          onPressed: function,
        ),
      )
      //   ListView.builder(
      //   itemBuilder: (BuildContext context, int index) {
      //     return Container(
      //       child: Padding(
      //         padding: EdgeInsets.all(40.0),
      //         child: Text(function().toString()),
      //       ),
      //     );
      //   },

      // )
      ,
    );
  }
}

checkCity(target) {
  var vizagArray = [
    "Visakhapatnam",
    "visakhapatnam",
    "VISAKHAPATNAM",
    "Vizag",
    "vizag",
    "VIZAG",
    "Vishakhapatnam",
    "vishakhapatnam"
  ];
  var add = target.first;
  for (var item in vizagArray) {
    // print("<<<${add.subAdminArea}>>>");
    if (add.locality != null) {
      if (add.locality.contains(item)) {
        return true;
      }
    }
    if (add.subLocality != null) {
      if (add.subLocality.contains(item)) return true;
    }
    if (add.addressLine != null) {
      if (add.addressLine.contains(item)) return true;
    }
    if (add.subAdminArea != null) {
      if (add.subAdminArea.contains(item)) return true;
    }
    if (add.adminArea != null) {
      if (add.adminArea.contains(item)) return true;
    }
    if (add.subThoroughfare != null) {
      if (add.subThoroughfare.contains(item)) return true;
    }
  }
  return false;
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
  var k;
  var l;
  var m;
  var n;

  List loc = [];
  // final coordinates = new Coordinates(21.10, 45.50);
  // var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  // var firstAddress = address.first.addressLine;
  var prevAddress;
  int counter = 0;
  for (var j = startLat; j < endLat; j += 0.20000) {
    for (var i = startLong; i < endLong; i += 0.20000) {
      valstr1 = j;
      valstr2 = i;
      print("$valstr1 : $valstr2");
      coor = Coordinates(valstr1, valstr2);
      var address = await Geocoder.local.findAddressesFromCoordinates(coor);
      if (prevAddress == null) prevAddress = address;
      if (address.first.addressLine.toLowerCase() !=
          prevAddress.first.addressLine.toLowerCase()) {
        // print("$valstr1 : $valstr2");
        print("new address");
        a = address.first.subLocality;
        b = address.first.locality;
        c = address.first.coordinates;
        d = address.first.addressLine.toLowerCase();
        e = address.first.subAdminArea;
        f = address.first.postalCode;
        g = address.first.adminArea;
        h = address.first.subThoroughfare;
        k = address.first.featureName;
        l = address.first.thoroughfare;

        var val = {
          "subLocality": "$a",
          "locality": "$b",
          "coordinates": "$c",
          "addressLine": "$d",
          "subAdminArea": "$e",
          "postalCode": "$f",
          "adminArea": "$g",
          "subThoroughfare": "$h",
          "featureName": "$k",
          "thoroughfare": "$l",
        };
        if (checkCity(address)) {
          loc.add(val.toString());
          counter += 1;
        }

        log(val.toString());
        prevAddress = address;
      } else
        print("equall>>");

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
  if (counter == loc.length) print("locy>>> $loc");

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

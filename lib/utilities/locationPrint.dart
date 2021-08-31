import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';

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
  final startLatController = new TextEditingController(text: "17.538455");
  final endLatController = new TextEditingController(text: "17.934493");
  final startLongController = new TextEditingController(text: "83.087737");
  final endLongController = new TextEditingController(text: "83.41598");
  final offsetController = new TextEditingController(text: "0.002");
  final placeNamController = new TextEditingController(text: "visakhapatnam");
  int loopCount = 0;
  var placeGeocode;
  String getPlace;
  bool loading = false;

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

  nullRectifier(address) {
    bool isNumericUsingRegularExpression(var string) {
      if (string == null) return false;
      final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

      return numericRegex.hasMatch(string);
    }

    bool isDouble(var s) {
      if (s == null) {
        return false;
      }
      return double.tryParse(s) != null;
    }

    var posibleNulls = [
      "null",
      "Unnamed Road",
      "unnamed road",
      "unnamed",
      "Unnamed",
      "Null",
      "V8XH+5RR",
      "v8xh+5rr",
      "p755+mpx",
      "P755+MPX"
    ];
    var filteredAddress = address;
    var addressLineArray;
    addressLineArray = address['addressLine'].split(",");
    if (posibleNulls.contains(address['subLocality'])) {
      print("null>>>");
      if (!posibleNulls.contains(addressLineArray[0])) {
        filteredAddress['subLocality'] = addressLineArray[0];
      } else {
        filteredAddress['subLocality'] = addressLineArray[1];
        addressLineArray[0] = addressLineArray[1];
        filteredAddress['addressLine'] = addressLineArray.join(',');
      }
    }
    //remove null value from address
    filteredAddress.removeWhere(
        (key, value) => value == null || value == "null" || value == "Null");
    print(
        "runtype ${filteredAddress['postalCode']} ${filteredAddress['postalCode'].runtimeType}");
    if (!isNumericUsingRegularExpression(filteredAddress['postalCode'])) {
      filteredAddress.remove('postalCode');
    }
    // if(!isDouble(filteredAddress['coordinates']['latitude'])){
    //   filteredAddress.remove('coordinates');
    // }
    // if(!isDouble(filteredAddress['coordinates']['logitude'])){
    //   filteredAddress.remove('coordinates');
    // }
    return filteredAddress;
  }

  Future<dynamic> getMethod() async {
    var uri = Uri.http(API.host, "/api/stamp");
    print("url>> $uri");

    try {
      var response = await http.get(uri).timeout(Duration(seconds: 30));
      print("<>>>><${response.body}>>");
    } catch (e) {
      print("errys > $e");
    }
  }

  Future<dynamic> postMethod(String api, var body) async {
    var uri = Uri.http(API.localHost, api);
    print("api hitting....");
    print("body$uri $body");
    var bodyData = json.encode(body);
    var newdata = {"data": bodyData.toString()};
    try {
      var response = await http.post(uri, body: newdata);

      // print("response>> $response");
      // log('message');
      log(response.statusCode.toString());
      // log(jsonDecode(response.body).toString());
      var retriveData = jsonDecode(response.body);
      // log('message');
      // log(retriveData['coordinates.latitude'].toString());
      // log(retriveData['coordinates']['logitude'].toString());
      if (response.statusCode == 200) {
        log("loop again");
        setState(() {
          startLatController.text =
              retriveData['coordinates']['latitude'].toString();
          startLongController.text =
              retriveData['coordinates']['logitude'].toString();
        });
        function(
            newLat: retriveData['coordinates']['latitude'],
            newLong: retriveData['coordinates']['logitude']);
      }

      return response;
    } catch (e) {
      print("error>> $e");
    }
  }

  function({double newLat, double newLong}) async {
    print(" new lat $newLat");
    var startLat = 17.538455;
    var startLong = 83.087737;
    var endLat = 17.934493;
    var endLong = 83.41598;
    double defaultOffset = 0.02000;
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
    var prevAddress;
    int counter = 0;

    var startLatCont = double.parse(startLatController.text) ?? startLat;
    var startLongCont = double.parse(startLongController.text) ?? startLong;
    var endLatCont = double.parse(endLatController.text) ?? endLat;
    var endLongCont = double.parse(endLongController.text) ?? endLong;
    var offsetCont = double.parse(offsetController.text) > 0.00002
        ? double.parse(offsetController.text)
        : defaultOffset;
    for (var j = newLat ?? startLatCont; j < endLatCont; j += offsetCont) {
      log("value j ${j.toString()}");
      for (var i = newLong ?? startLongCont; i < endLongCont; i += offsetCont) {
        // loopCount += 1;
        valstr1 = j;
        valstr2 = i;
        // print("$valstr1 : $valstr2");
        coor = Coordinates(valstr1, valstr2);
        var address = await Geocoder.local.findAddressesFromCoordinates(coor);
        if (prevAddress == null) prevAddress = address;
        if (address.first.addressLine.toLowerCase() !=
            prevAddress.first.addressLine.toLowerCase()) {
          // print("$valstr1 : $valstr2");
          // print("new address");
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
            "coordinates": {"latitude": c.latitude, "logitude": c.longitude},
            "addressLine": "$d",
            "subAdminArea": "$e",
            "postalCode": "$f",
            "adminArea": "$g",
            "subThoroughfare": "$h",
            "featureName": "$k",
            "thoroughfare": "$l",
          };
          if (checkCity(address)) {
            loc.add(nullRectifier(val));
            log(val.toString());
            counter += 1;
            setState(() {
              loopCount = loopCount + 1;
            });
          }
          // if (loopCount % 5 == 0) {
          //   print("loopCount >> $loopCount");
          // }
          prevAddress = address;
        }

        if (counter == 40) {
          print("locy>>> $loc");

          // await getMethod();
          await postMethod("/api/geocode/newgeocode", loc);
          return;
        }
      }
    }
    if (loc.length < 40 && loc.length != 0) {
      print("remaining geocodes $loc");
      await postMethod("/api/geocode/newgeocode", loc);
      return;
    }
    // if (counter == loc.length) {
    //   print("locy>>> $loc");

    //   // await getMethod();
    //   await postMethod("/api/geocode/newgeocode", loc);
    // }
    setState(() {
      loopCount = loopCount + counter;
    });

    // log(firstAddress);
    // return '${valstr1.substring(0, 9)},${valstr2.substring(0, 9)}';
    return '';
  }

  findLocationName() async {
    var lat = double.parse(startLatController.text);
    var long = double.parse(startLongController.text);
    var coor = Coordinates(lat, long);
    var address = await Geocoder.local.findAddressesFromCoordinates(coor);
    print(address.first.locality);
    setState(() {
      getPlace =
          "${address.first.subLocality.toString()}, ${address.first.locality.toString()}";
    });
  }

  findNumberOfLocation() async {
    var startLat = 17.538455;
    var startLong = 83.087737;
    var endLat = 17.934493;
    var endLong = 83.41598;
    double defaultOffset = 0.02000;
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
    var prevAddress;

    var startLatCont = double.parse(startLatController.text) ?? startLat;
    var startLongCont = double.parse(startLongController.text) ?? startLong;
    var endLatCont = double.parse(endLatController.text) ?? endLat;
    var endLongCont = double.parse(endLongController.text) ?? endLong;
    var offsetCont = double.parse(offsetController.text) > 0.00002
        ? double.parse(offsetController.text)
        : defaultOffset;
    for (var j = startLatCont; j < endLatCont; j += offsetCont) {
      log("value j ${j.toString()}");
      for (var i = startLongCont; i < endLongCont; i += offsetCont) {
        // loopCount += 1;
        valstr1 = j;
        valstr2 = i;
        // print("$valstr1 : $valstr2");
        coor = Coordinates(valstr1, valstr2);
        var address = await Geocoder.local.findAddressesFromCoordinates(coor);
        if (prevAddress == null) prevAddress = address;
        if (address.first.addressLine.toLowerCase() !=
            prevAddress.first.addressLine.toLowerCase()) {
          // print("$valstr1 : $valstr2");
          // print("new address");
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
            "coordinates": {"latitude": c.latitude, "logitude": c.longitude},
            "addressLine": "$d",
            "subAdminArea": "$e",
            "postalCode": "$f",
            "adminArea": "$g",
            "subThoroughfare": "$h",
            "featureName": "$k",
            "thoroughfare": "$l",
          };
          if (checkCity(address)) {
            loc.add(nullRectifier(val));
            log(val.toString());
            setState(() {
              loopCount = loopCount + 1;
            });
          }

          prevAddress = address;
        }
      }
    }
  }

  forwardGeocode() async {
    final query = placeNamController.text;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    print("${first.featureName} : ${first.coordinates}");
    setState(() {
      placeGeocode = first.coordinates.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("geocode")),
      // body: MyCustomForm()
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: TextFormField(
                      controller: placeNamController,
                      decoration: InputDecoration(
                        helperText: "vizag",
                        border: UnderlineInputBorder(),
                        labelText: 'enter location to search',
                      ),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: startLatController,
                      decoration: InputDecoration(
                        helperText: "17.538455",
                        border: UnderlineInputBorder(),
                        labelText: 'starting latitude',
                      ),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: startLongController,
                      decoration: InputDecoration(
                        helperText: "83.087737",
                        border: UnderlineInputBorder(),
                        labelText: 'starting logitude',
                      ),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: endLatController,
                      decoration: InputDecoration(
                        helperText: "17.934493",
                        border: UnderlineInputBorder(),
                        labelText: 'ending latitude',
                      ),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: endLongController,
                      decoration: InputDecoration(
                        helperText: "83.41598",
                        border: UnderlineInputBorder(),
                        labelText: 'ending logitude',
                      ),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: offsetController,
                      decoration: InputDecoration(
                        helperText: "0.00002",
                        border: UnderlineInputBorder(),
                        labelText: 'offset',
                      ),
                    ),
                  ),
                  Wrap(
                    children: [
                      Text("no of loc: ${loopCount.toString()}"),
                      Text("  geocode : $placeGeocode"),
                      Text("plac : $getPlace")
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.spaceAround,
                    spacing: 3.0,
                    children: [
                      ElevatedButton(
                        child:
                            !loading ? Text("Load locations") : Text("Load..."),
                        onPressed: () async {
                          if (!loading) {
                            setState(() {
                              loading = true;
                            });
                            await function();
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                      ),
                      ElevatedButton(
                        child: !loading ? Text("no of locs") : Text("Load..."),
                        onPressed: () async {
                          if (!loading) {
                            setState(() {
                              loading = true;
                            });
                            await findNumberOfLocation();
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                      ),
                      ElevatedButton(
                        child: !loading ? Text("forward") : Text("Load..."),
                        onPressed: () async {
                          if (!loading) {
                            setState(() {
                              loading = true;
                            });
                            await forwardGeocode();
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                      ),
                      ElevatedButton(
                        child: !loading ? Text("reverse") : Text("Load..."),
                        onPressed: () async {
                          if (!loading) {
                            setState(() {
                              loading = true;
                            });
                            await findLocationName();
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              loopCount = 0;
                            });
                          },
                          child:
                              !loading ? Text("reset count") : Text("Load...")),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              startLatController.text = "17.538455";
                              startLongController.text = "83.087737";
                            });
                          },
                          child:
                              !loading ? Text("reset cord") : Text("Load..."))
                    ],
                  )
                ],
              ),
            ),
          ),
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

// function(List coor) {
//   // for (var e in coor) {
//   //   print(e);
//   //   return Text(e.toString());
//   // }

//   for (var i = 0; i < coor.length; i++) {
//     return Text(coor[i]);
//   }
// }

// function() async {
//   var startLat = 17.538455;
//   var startLong = 83.087737;
//   var endLat = 17.934493;
//   var endLong = 83.41598;
//   var valstr1;
//   var valstr2;
//   var coor;
//   var a;
//   var b;
//   var c;
//   var d;
//   var e;
//   var f;
//   var g;
//   var h;
//   List loc = [];
//   // final coordinates = new Coordinates(21.10, 45.50);
//   // var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//   // var firstAddress = address.first.addressLine;

//   for (var j = startLat; j < endLat; j += 0.01000) {
//     for (var i = startLong; i < endLong; i += 0.01000) {
//       valstr1 = j;
//       valstr2 = i;
//       coor = Coordinates(valstr1, valstr2);
//       var address = await Geocoder.local.findAddressesFromCoordinates(coor);
//       a = address.first.subLocality;
//       b = address.first.locality;
//       c = address.first.coordinates;
//       d = address.first.addressLine.toLowerCase();
//       e = address.first.subAdminArea;
//       f = address.first.postalCode;
//       g = address.first.adminArea;
//       h = address.first.subThoroughfare;

//       var val = {
//         "locality": "$d",
//         "postalCode": "$f",
//         "loclity": "$b",
//         "coordinates": "$c"
//       };

//       // loc.add(val.toString());

//       log(val.toString());

//       // log(a.toString());
//       // log(b.toString());
//       // log(c.toString());
//       // log(d.toString());
//       // // log(e.toString());
//       // log(f.toString());
//       // log(g.toString());
//       // // log(h.toString());
//       // log('message');

//       // var s = (valstr1 + valstr2);
//       // var addresses = Geocoder.local.findAddressesFromCoordinates(
//       //   s,
//       // );

//       // print(Geocoder.local.findAddressesFromCoordinates(coordinates));
//       // print('${valstr1.substring(0, 9)},${valstr2.substring(0, 9)}');

//     }
//   }
//   // log(firstAddress);
//   // return '${valstr1.substring(0, 9)},${valstr2.substring(0, 9)}';
//   return '';
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

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your username',
            ),
          ),
        ),
      ],
    );
  }
}

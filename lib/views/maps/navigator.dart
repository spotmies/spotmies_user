

import 'package:flutter/material.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/views/home/ads/maps.dart';
import 'package:spotmies/views/maps/offLine_placesModel.dart';
import 'package:spotmies/views/maps/onLine_placesSearch.dart';

class Dummy extends StatefulWidget {
  const Dummy({Key key}) : super(key: key);

  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButtonWidget(
              minWidth: 150,
              height: 50,
              bgColor: Colors.indigo[50],
              buttonName: 'offline',
              textColor: Colors.grey[900],
              borderRadius: 15.0,
              textSize: 15,
              leadingIcon: Icon(
                Icons.offline_pin,
                size: 15,
                color: Colors.grey[900],
              ),
              borderSideColor: Colors.indigo[50],
              onClick: () async {
                await places();

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OfflinePlaceSearch()));
              },
            ),
            ElevatedButtonWidget(
              minWidth: 150,
              height: 50,
              bgColor: Colors.indigo[900],
              buttonName: 'online',
              textColor: Colors.white,
              borderRadius: 15.0,
              textSize: 15,
              trailingIcon: Icon(
                Icons.book_online,
                size: 15,
                color: Colors.white,
              ),
              borderSideColor: Colors.indigo[900],
              onClick: (){
                 Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OnlinePlaceSearch()));
              },
            )
          ],
        ),
      ),
    );
  }
}

places() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var response = await Server().getMethod(API.places);
  // if (response.statusCode == 200) {
  //    var list = (json.decode(response.body) as List)
  //         .map((data) => new Places.fromJson(data))
  //         .toList();
     
  //   } else {
  //     throw Exception('Failed to load photos');
  //   }
  // prefs.setString('places', jsonEncode(response));

  //  var mpd = prefs.getString('places');
  //  log(jsonDecode(mpd));
  // Map<String,dynamic> place = jsonDecode(mpd) as Map<String, dynamic>;;
  //  log(place.toString());
}


// fetchData() async {
   
//     var response = await Server().getMethod(API.places);
//     if (response.statusCode == 200) {
//       place = (json.decode(response.body) as List)
//           .map((data) => new Places.fromJson(data))
//           .toList();
    
//     } else {
//       throw Exception('Failed to load photos');
//     }
//   }




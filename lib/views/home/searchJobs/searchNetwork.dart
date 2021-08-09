// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:spotmies/models/searchJobDataModel.dart';
// import 'package:spotmies/utilities/searchWidget.dart';

// class FilterNetworkListPage extends StatefulWidget {
//   @override
//   FilterNetworkListPageState createState() => FilterNetworkListPageState();
// }

// class FilterNetworkListPageState extends State<FilterNetworkListPage> {
//   List<Job> books = [];
//   String query = '';
//   Timer debouncer;

//   @override
//   void initState() {
//     super.initState();

//     init();
//   }

//   @override
//   void dispose() {
//     debouncer?.cancel();
//     super.dispose();
//   }

//   void debounce(
//     VoidCallback callback, {
//     Duration duration = const Duration(milliseconds: 1000),
//   }) {
//     if (debouncer != null) {
//       debouncer.cancel();
//     }

//     debouncer = Timer(duration, callback);
//   }

//   Future init() async {
//     final books = await BooksApi.getBooks(query);

//     setState(() => this.books = books);
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: Text('Search'),
//           centerTitle: true,
//         ),
//         body: Column(
//           children: <Widget>[
//             buildSearch(),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: books.length,
//                 itemBuilder: (context, index) {
//                   final book = books[index];

//                   return buildBook(book);
//                 },
//               ),
//             ),
//           ],
//         ),
//       );

//   Widget buildSearch() => SearchWidget(
//         text: query,
//         hintText: 'Title or Author Name',
//         onChanged: searchBook,
//       );

//   Future searchBook(String query) async => debounce(() async {
//         final books = await BooksApi.getBooks(query);

//         if (!mounted) return;

//         setState(() {
//           this.query = query;
//           this.books = books;
//         });
//       });

//   Widget buildBook(Job job) => ListTile(
//         leading: Image.network(
//           job.urlImage,
//           fit: BoxFit.cover,
//           width: 50,
//           height: 50,
//         ),
//         title: Text(job.job),
//         subtitle: Text(job.canDoWorks),
//       );
// }




// // import 'dart:convert';
// // import 'dart:io';

// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart';

// // class MyHomePage extends StatefulWidget {
// //   MyHomePage({Key key, this.title}) : super(key: key);

// //   final String title;

// //   @override
// //   _MyHomePageState createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyHomePage> {
// //   final _controller = TextEditingController();

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.title),
// //       ),
// //       body: Column(
// //         children: <Widget>[
// //           TextField(
// //             controller: _controller,
// //             readOnly: true,
// //             onTap: () async {
// //               // generate a new token here
// //               final sessionToken = Uuid().v4();
// //               final Suggestion result = await showSearch(
// //                 context: context,
// //                 delegate: AddressSearch(sessionToken),
// //               );
// //               // This will change the text displayed in the TextField
// //               if (result != null) {
// //                 setState(() {
// //                   _controller.text = result.description;
// //                 });
// //               }
// //             },
// //             decoration: InputDecoration(
// //               icon: Container(
// //                 margin: EdgeInsets.only(left: 20),
// //                 width: 10,
// //                 height: 10,
// //                 child: Icon(
// //                   Icons.home,
// //                   color: Colors.black,
// //                 ),
// //               ),
// //               hintText: "Enter your shipping address",
// //               border: InputBorder.none,
// //               contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }





// // //







// // class Place {
// //   String streetNumber;
// //   String street;
// //   String city;
// //   String zipCode;

// //   Place({
// //     this.streetNumber,
// //     this.street,
// //     this.city,
// //     this.zipCode,
// //   });

// //   @override
// //   String toString() {
// //     return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
// //   }
// // }

// // class Suggestion {
// //   final String placeId;
// //   final String description;

// //   Suggestion(this.placeId, this.description);

// //   @override
// //   String toString() {
// //     return 'Suggestion(description: $description, placeId: $placeId)';
// //   }
// // }

// // class PlaceApiProvider {
// //   final client = Client();

// //   PlaceApiProvider(this.sessionToken);

// //   final sessionToken;

// //   static final String androidKey = 'YOUR_API_KEY_HERE';
// //   static final String iosKey = 'YOUR_API_KEY_HERE';
// //   final apiKey = Platform.isAndroid ? androidKey : iosKey;

// //   Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
// //     final request =
// //         'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:ch&key=$apiKey&sessiontoken=$sessionToken';
// //     final response = await client.get(request);

// //     if (response.statusCode == 200) {
// //       final result = json.decode(response.body);
// //       if (result['status'] == 'OK') {
// //         // compose suggestions in a list
// //         return result['predictions']
// //             .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
// //             .toList();
// //       }
// //       if (result['status'] == 'ZERO_RESULTS') {
// //         return [];
// //       }
// //       throw Exception(result['error_message']);
// //     } else {
// //       throw Exception('Failed to fetch suggestion');
// //     }
// //   }

// //   Future<Place> getPlaceDetailFromId(String placeId) async {
// //     final request =
// //         'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
// //     final response = await client.get(request);

// //     if (response.statusCode == 200) {
// //       final result = json.decode(response.body);
// //       if (result['status'] == 'OK') {
// //         final components =
// //             result['result']['address_components'] as List<dynamic>;
// //         // build result
// //         final place = Place();
// //         components.forEach((c) {
// //           final List type = c['types'];
// //           if (type.contains('street_number')) {
// //             place.streetNumber = c['long_name'];
// //           }
// //           if (type.contains('route')) {
// //             place.street = c['long_name'];
// //           }
// //           if (type.contains('locality')) {
// //             place.city = c['long_name'];
// //           }
// //           if (type.contains('postal_code')) {
// //             place.zipCode = c['long_name'];
// //           }
// //         });
// //         return place;
// //       }
// //       throw Exception(result['error_message']);
// //     } else {
// //       throw Exception('Failed to fetch suggestion');
// //     }
// //   }
// // }
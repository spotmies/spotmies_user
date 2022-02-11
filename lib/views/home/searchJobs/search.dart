import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/models/searchJobDataModel.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/searchWidget.dart';
import 'package:spotmies/views/home/ads/adpost.dart';

class FilterLocalListPage extends StatefulWidget {
  @override
  FilterLocalListPageState createState() => FilterLocalListPageState();
}

class FilterLocalListPageState extends State<FilterLocalListPage> {
  List<dynamic>? jobs;
  String query = '';
  UniversalProvider? up;

  @override
  void initState() {
    super.initState();

    up = Provider.of<UniversalProvider>(context, listen: false);
    up?.setCurrentConstants("serviceRequest");
    // log('${up?.servicesList}');
    jobs = up?.servicesList;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              buildSearch(),
              Expanded(
                child: ListView.builder(
                  itemCount: jobs?.length,
                  itemBuilder: (context, index) {
                    final book = jobs![index];
                    // log(book.toString());
                    return buildBook(book);
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search',
        onChanged: searchBook,
      );

  Widget buildBook(job) => ListTile(
        onTap: () async {
          if (job['isMainService']) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostAd(sid: job['serviceId'])));
          } else {
            dynamic sid = await up?.getMainServiceId(job['_id']);
            log(sid['serviceId'].toString());
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostAd(sid: sid['serviceId'])));
          }
        },
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.home_repair_service),
        ),
        //  Image.network(
        //   job.urlImage,
        //   fit: BoxFit.cover,
        //   width: 50,
        //   height: 50,
        // ),
        title: Text(
          job['nameOfService'],
          style: GoogleFonts.josefinSans(
              color: Colors.grey[900], fontWeight: FontWeight.w600),
        ),
        // subtitle: RichText(
        //   text: TextSpan(children: <InlineSpan>[
        //     for (var string in dum)
        //       TextSpan(
        //         text: string,
        //         style: GoogleFonts.josefinSans(
        //             color: Colors.grey[600], fontWeight: FontWeight.w500),
        //       ),
        //   ]),
        //   // jsonDecode(job['subServices']),
        // ),
      );

  void searchBook(String query) {
    final books = up?.servicesList.where((job) {
      final titleLower = job['nameOfService'].toLowerCase();
      // final authorLower = job['subServices'].toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
      // ||
      //     authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.jobs = books;
    });
  }
}

// subserve(subjob) {
//   for (var string in subjob) return string.toString();
// }

final dum = [
  'qwerty',
  'poiuyt',
  'qwerty',
  'poiuyt',
  'qwerty',
  'poiuyt',
  'qwerty',
  'poiuyt',
  'qwerty',
  'poiuyt',
];
// final allJobs = [
//   Job(
//     id: 1,
//     job: 'Electrician',
//     canDoWorks: 'Fan,Light,Motor,Switches,etc.,',
//     urlImage:
//         'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
//   ),
//   Job(
//     id: 2,
//     job: 'Beauty',
//     canDoWorks: 'Facial,Spa,Massage,HairCut,etc.,',
//     urlImage:
//         'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
//   ),
//   Job(
//     id: 3,
//     job: 'Plumber',
//     canDoWorks: 'Motor,Water,Pipes,etc.,',
//     urlImage:
//         'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
//   ),
//   Job(
//     id: 4,
//     job: 'Chef',
//     canDoWorks: 'Indian,Chineese,Continental,etc.,',
//     urlImage:
//         'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
//   ),
//   Job(
//     id: 5,
//     job: 'Tatto',
//     canDoWorks: 'Tribal,Modern,Classic,etc.,',
//     urlImage:
//         'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
//   ),
//   Job(
//     id: 6,
//     job: 'Web App',
//     canDoWorks: 'Websites,WebApps,Blogs,etc.,',
//     urlImage:
//         'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
//   ),
//   Job(
//     id: 7,
//     job: 'Mobile App',
//     canDoWorks: 'Mobile Apps,Mobile Games,etc.,',
//     urlImage:
//         'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
//   ),
//   Job(
//     id: 8,
//     job: 'Digital Marketing',
//     canDoWorks: 'SEO,Social Media Marketing',
//     urlImage:
//         'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
//   ),
//   Job(
//     id: 9,
//     job: 'Interial Designing',
//     canDoWorks: 'Office Designs,House Designs,etc.,',
//     urlImage:
//         'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
//   ),
//   Job(
//     id: 10,
//     job: 'Event Management',
//     canDoWorks: 'Birthday Functions,Marriege Events,etc.,',
//     urlImage:
//         'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
//   ),
// ];

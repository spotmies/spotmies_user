import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotmies/models/searchJobDataModel.dart';
import 'package:spotmies/utilities/searchWidget.dart';

class FilterLocalListPage extends StatefulWidget {
  @override
  FilterLocalListPageState createState() => FilterLocalListPageState();
}

class FilterLocalListPageState extends State<FilterLocalListPage> {
  late List<Job> jobs;
  String query = '';

  @override
  void initState() {
    super.initState();

    jobs = allJobs;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              buildSearch(),
              Expanded(
                child: ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final book = jobs[index];

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

  Widget buildBook(Job job) => ListTile(
        onTap: () {
          log(job.job);
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
          job.job,
          style: GoogleFonts.josefinSans(
              color: Colors.grey[900], fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          job.canDoWorks,
          style: GoogleFonts.josefinSans(
              color: Colors.grey[600], fontWeight: FontWeight.w500),
        ),
      );

  void searchBook(String query) {
    final books = allJobs.where((job) {
      final titleLower = job.job.toLowerCase();
      final authorLower = job.canDoWorks.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.jobs = books;
    });
  }
}

final allJobs = [
  Job(
    id: 1,
    job: 'Electrician',
    canDoWorks: 'Fan,Light,Motor,Switches,etc.,',
    urlImage:
        'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
  ),
  Job(
    id: 2,
    job: 'Beauty',
    canDoWorks: 'Facial,Spa,Massage,HairCut,etc.,',
    urlImage:
        'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
  ),
  Job(
    id: 3,
    job: 'Plumber',
    canDoWorks: 'Motor,Water,Pipes,etc.,',
    urlImage:
        'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
  ),
  Job(
    id: 4,
    job: 'Chef',
    canDoWorks: 'Indian,Chineese,Continental,etc.,',
    urlImage:
        'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
  ),
  Job(
    id: 5,
    job: 'Tatto',
    canDoWorks: 'Tribal,Modern,Classic,etc.,',
    urlImage:
        'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
  ),
  Job(
    id: 6,
    job: 'Web App',
    canDoWorks: 'Websites,WebApps,Blogs,etc.,',
    urlImage:
        'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
  ),
  Job(
    id: 7,
    job: 'Mobile App',
    canDoWorks: 'Mobile Apps,Mobile Games,etc.,',
    urlImage:
        'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
  ),
  Job(
    id: 8,
    job: 'Digital Marketing',
    canDoWorks: 'SEO,Social Media Marketing',
    urlImage:
        'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
  ),
  Job(
    id: 9,
    job: 'Interial Designing',
    canDoWorks: 'Office Designs,House Designs,etc.,',
    urlImage:
        'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
  ),
  Job(
    id: 10,
    job: 'Event Management',
    canDoWorks: 'Birthday Functions,Marriege Events,etc.,',
    urlImage:
        'https://images.unsplash.com/photo-1615347497551-277d6616b959?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=692&q=80',
  ),
];

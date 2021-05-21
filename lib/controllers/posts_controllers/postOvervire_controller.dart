import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PostOverViewController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();

  List jobs = [
    'AC Service',
    'Computer',
    'TV Repair',
    'Development',
    'Tutor',
    'Beauty',
    'Photography',
    'Drivers',
    'Events',
    'Electrician',
    'Carpentor',
    'Plumber',
  ];
  List state = ['Waiting for confirmation', 'Ongoing', 'Completed'];
  List icons = [
    Icons.pending_actions,
    Icons.run_circle_rounded,
    Icons.done_all
  ];

  int currentStep = 0;
}

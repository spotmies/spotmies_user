import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/apiCalls/testController.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/utilities/snackbar.dart';

class PostsController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  final controller = TestController();
  GetOrdersProvider ordersProvider;
  List jobs = [
    'AC Service',
    'Computer',
    'TV Repair',
    'Development',
    'Tutor',
    'Beauty',
    'Photography',
    'Drivers',
    'Events'
  ];
  List state = ['Waiting for confirmation', 'Ongoing', 'Completed'];
  @override
  void initState() {
    ordersProvider = Provider.of<GetOrdersProvider>(context, listen: false);

    super.initState();
  }




  getAddressofLocation(addresses) async {
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    // final coordinates = Coordinates(position.latitude, position.longitude);

    return Text(addresses.first.locality.toString());
  }

  Future getOrderFromDB() async {
    var response = await Server().getMethod(API.getOrders);
    if(response.statusCode == 200){

    
    var ordersList = jsonDecode(response.body);
    ordersProvider.setOrdersList(ordersList);

    snackbar(context, "sync with new changes");
    }
    else{
      snackbar(context, "Something went wrong");
    }
  }
}

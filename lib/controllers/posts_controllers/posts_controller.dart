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

  orderStateText(String orderState) {
    switch (orderState) {
      case 'req':
        return 'Waiting for conformation';
        break;
      case 'noPartner':
        return 'No technicians found';
        break;
      case 'updated':
        return 'updated';
        break;
      case 'onGoing':
        return 'On Going';
        break;
      case 'completed':
        return 'Completed';
        break;
      case 'cancel':
        return 'Cancelled';
        break;
      default:
        return 'Booking done';
    }
  }

  orderStateIcon(String orderState) {
    switch (orderState) {
      case 'req':
        return Icons.pending_actions;
        break;
      case 'noPartner':
        return Icons.stop_circle;
        break;
      case 'updated':
        return Icons.update;
        break;
      case 'onGoing':
        return Icons.run_circle_rounded;
        break;
      case 'completed':
        return Icons.done_all;
        break;
      case 'cancel':
        return Icons.cancel;
        break;
      default:
        return Icons.search;
    }
  }

  getAddressofLocation(addresses) async {
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    // final coordinates = Coordinates(position.latitude, position.longitude);

    return Text(addresses.first.locality.toString());
  }

  getOrderFromDB() async {
    var response = await Server().getMethod(API.getOrders);

    var ordersList = jsonDecode(response);
    ordersProvider.setOrdersList(ordersList);

    snackbar(context, "Unable to fetch Orders please Try again");
  }
}

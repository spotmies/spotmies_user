import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/providers/chat_provider.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/views/chat/chatapp/personal_chat.dart';
import 'package:spotmies/views/maps/maps.dart';

class PostOverViewController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController problem = TextEditingController();
  late ChatProvider chatProvider;
  late GetOrdersProvider ordersProvider;
  String? title;
  int dropDownValue = 0;
  dynamic orderDetails = {};
  //date time picker
  late DateTime pickedDate;
  late TimeOfDay pickedTime;

  @override
  void initState() {
    super.initState();
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    ordersProvider = Provider.of<GetOrdersProvider>(context, listen: false);

    // getAddressofLocation();
  }

  isOrderCompleted(String money, String orderID) async {
    Map<String, String> body = {"orderState": "9", "moneyGivenByUser": money};
    dynamic response = await Server().editMethod(API.editOrder + orderID, body);
    if (response.statusCode == 200 || response.statusCode == 204) {
      snackbar(context, "Your order completed now");
      await getOrderAndUpdate(orderID);
    } else {
      snackbar(context, "Something went wrong try again later");
    }
  }

  Future<void> getOrderAndUpdate(orderID) async {
    dynamic response2 =
        await Server().getMethod(API.confirmOrder + orderID.toString());
    if (response2.statusCode == 200) {
      dynamic updatedOrder = jsonDecode(response2.body);
      ordersProvider.updateOrderById(
          ordId: updatedOrder['ordId'], orderData: updatedOrder);
    }
  }

  Widget editAttributes(String field, String ordId, job, money, schedule,
      Coordinates coordinates) {
    return InkWell(
      onTap: () {
        if (field == 'problem') {
          editDialogue(
            'problem',
            ordId,
          );
        }
        if (field == 'amount') {
          editDialogue(
            'amount',
            ordId,
          );
        }
        if (field == 'Schedule') {
          print(field);
        }
        if (field == 'location') {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Maps(),
          ));
        }
      },
      child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[100],
          child: Icon(
            Icons.edit,
            color: Colors.blue[900],
          )),
    );
  }

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

  List options = [
    {
      "name": "Close",
      "icon": Icons.cancel,
    },
    {
      "name": "Info",
      "icon": Icons.info,
    },
    {
      "name": "Re-schedule",
      "icon": Icons.refresh,
    },
    {"name": "Help", "icon": Icons.help},
  ];

  orderStateText(String orderState) {
    switch (orderState) {
      case 'req':
        return 'Waiting for conformation';

      case 'noPartner':
        return 'No technicians found';

      case 'updated':
        return 'updated';

      case 'onGoing':
        return 'On Going';

      case 'completed':
        return 'Completed';

      case 'cancel':
        return 'Cancelled';

      default:
        return 'Booking done';
    }
  }

  orderStateIcon(String orderState) {
    switch (orderState) {
      case 'req':
        return Icons.pending_actions;

      case 'noPartner':
        return Icons.stop_circle;

      case 'updated':
        return Icons.update;

      case 'onGoing':
        return Icons.run_circle_rounded;

      case 'completed':
        return Icons.done_all;

      case 'cancel':
        return Icons.cancel;

      default:
        return Icons.search;
    }
  }

  Future chatWithpatner(responseData) async {
    if (ordersProvider.orderViewLoader) return;

    String ordId = responseData['ordId'].toString();
    String pId = responseData['pId'].toString();
    List chatList = chatProvider.getChatList2();
    int index = chatList.indexWhere((element) =>
        element['ordId'].toString() == ordId &&
        element['pId'].toString() == pId);
    log("index $index");
    if (index < 0) {
      //this means there is no previous chat with this partner about this post
      //create new chat here
      log("creating new chat room $responseData");
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      var newChatObj = {
        "msgId": timestamp,
        "msgs":
            "{\"msg\":\"New Chat Created for this service\",\"type\":\"text\",\"sender\":\"bot\",\"time\":$timestamp}",
        "ordId": ordId,
        "pId": pId,
        "uId": responseData['uId'],
        "uDetails": responseData['uDetails']['_id'],
        "pDetails": responseData['pDetails']['_id'],
        "orderDetails": responseData['_id']
      };
      ordersProvider.setOrderViewLoader(true);
      dynamic response =
          await Server().postMethod(API.createNewChat, newChatObj);
      ordersProvider.setOrderViewLoader(false);
      if (response.statusCode == 200) {
        log("success ${jsonDecode(response.body)}");
        dynamic newChat = jsonDecode(response.body);
        chatProvider.addNewchat(newChat);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PersonalChat(newChat['msgId'].toString())));
      } else {
        log("req failed $response please try again later");
      }
    } else {
      //already there is a conversation about this post with this partner
      dynamic msgId = chatList[index]['msgId'];
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PersonalChat(msgId.toString())));
    }
  }

  editDialogue(
    edit,
    String ordId,
  ) {
    final hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final width = MediaQuery.of(context).size.width;
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(edit == 'problem' ? 'update issue' : 'update amount'),
            content: Container(
              width: width * 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: width * 0.03,
                        right: width * 0.03,
                        top: width * 0.03),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15)),
                    height: hight * 0.10,
                    width: width * 0.7,
                    child: TextFormField(
                      controller: problem,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Please discribe your problem';
                          }
                        }
                        return null;
                      },
                      keyboardType: edit == 'problem'
                          ? TextInputType.name
                          : TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade100)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade100)),
                        hintStyle: TextStyle(fontSize: 17),
                        hintText: edit == 'problem' ? 'Problem' : 'Amount',
                        suffixIcon: Icon(
                          Icons.error_outline_rounded,
                          color: Colors.blue[900],
                        ),
                        contentPadding: EdgeInsets.only(
                            left: hight * 0.03, top: hight * 0.04),
                      ),
                      onChanged: (value) {
                        this.title = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton.icon(
                  onPressed: () {
                    Server().editMethod(API.editOrder + '$ordId', {
                      edit == 'problem' ? 'problem' : 'money': title.toString(),
                    });
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.done_all,
                    color: Colors.blue[900],
                  ),
                  label: Text(
                    'Change',
                    style: TextStyle(color: Colors.blue[900]),
                  ))
            ],
          );
        });
  }

  pickDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
        confirmText: 'SET DATE',
        context: context,
        initialDate: pickedDate.millisecondsSinceEpoch <
                DateTime.now().millisecondsSinceEpoch
            ? DateTime.now()
            : pickedDate,
        firstDate: DateTime(DateTime.now().year - 0, DateTime.now().month - 0,
            DateTime.now().day - 0),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      // setState(() {
      pickedDate = date;
      print(pickedDate.millisecondsSinceEpoch);
      // });
    }
  }

  picktime(BuildContext context) async {
    TimeOfDay? t = await showTimePicker(
      context: context,
      initialTime: pickedTime,
    );
    if (t != null) {
      // setState(() {
      pickedTime = t;
      // });
    }
  }

  getDateAndTime() {
    DateTime pickedDateTime = new DateTime(pickedDate.year, pickedDate.month,
        pickedDate.day, pickedTime.hour, pickedTime.minute);

    return pickedDateTime.millisecondsSinceEpoch.toString();
  }

  static const dummyLocation = {"lat": 0.00, "log": 0.00};
  rescheduleServiceOrCancel(orderState, orderId,
      {isReschedule = true,
      Map<String, double> updatedCoordinate = dummyLocation,
      dynamic updatedAddress,
      String action = "UPDATE_SCHEDULE"}) async {
    Map<String, dynamic> body = {
      "schedule": getDateAndTime(),
      "orderState": orderState > 6 ? "7" : "2"
    };
    Map<String, String> cancelBody = {"orderState": "3"};
    Map<String, dynamic> updateLocationBody = {
      "loc.0": updatedCoordinate['lat'].toString(),
      "loc.1": updatedCoordinate['log'].toString(),
      "address": jsonEncode(updatedAddress).toString()
    };
    log("new loc $updateLocationBody");

    Map<String, dynamic> getBody() {
      switch (action) {
        case "UPDATE_SCHEDULE":
          return body;
        case "UPDATE_LOCATION":
          return updateLocationBody;
        case "CANCEL_ORDER":
          return cancelBody;

        default:
          return body;
      }
    }

    ordersProvider.setOrderViewLoader(true);
    dynamic response = await updateOrder(body: getBody(), ordId: orderId);
    ordersProvider.setOrderViewLoader(false);
    if (response != null) {
      ordersProvider.setOrderViewLoader(true);
      await getOrderAndUpdate(orderId);
      ordersProvider.setOrderViewLoader(false);
    }
  }

  cancelOrder(ordId) async {
    Map<String, String> body = {"orderState": "3"};
    await updateOrder(body: body, ordId: ordId);
  }

  submitReview(int rating, String comment) async {
    log(rating.toString());
    log(comment);
    String mappedRating = (rating * 20).toString();
    // log(orderDetails.toString());
    Map<String, String> body = {
      "rating": mappedRating,
      "pId": orderDetails['pId'].toString(),
      "uId": orderDetails['uId'].toString(),
      "ordId": orderDetails['ordId'].toString(),
      "pDetails": orderDetails['pDetails']['_id'].toString(),
      "uDetails": orderDetails['uDetails']['_id'].toString(),
      "orderDetails": orderDetails['_id'].toString(),
      "createdAt": DateTime.now().millisecondsSinceEpoch.toString(),
      "description": comment
    };
    //  log("body $body");
    dynamic newbody = orderDetails;
    newbody['orderState'] = 10;
    ordersProvider.updateOrderById(ordId: newbody['ordId'], orderData: newbody);
    bool resp = await feedbackOrder(body: body);
    if (resp) {
      Map<String, String> body = {"orderState": "10"};
      dynamic resp2 =
          await updateOrder(body: body, ordId: orderDetails['ordId']);
      if (resp2 != null) {
        snackbar(context, "Thank you for your feedback");
      } else {
        newbody['orderState'] = 9;
        ordersProvider.updateOrderById(
            ordId: newbody['ordId'], orderData: newbody);
        snackbar(context, "Something went wrong");
      }
    } else {
      newbody['orderState'] = 9;
      ordersProvider.updateOrderById(
          ordId: newbody['ordId'], orderData: newbody);
      snackbar(context, "Something went wrong");
    }
  }

  // getAddressofLocation(Set<double> coordinates) async {
  //   var addresses =
  //       await Geocoder.local.findAddressesFromCoordinates(coordinates);

  //   print(addresses.first.subLocality);

  // setState(() {
  //   add1 = addresses.first.featureName;
  //   add2 = addresses.first.addressLine;
  //   add3 = addresses.first.subLocality;
  // });
  //}

  // pickDate(BuildContext context) async {
  //   DateTime date = await showDatePicker(
  //       confirmText: 'SET DATE',
  //       context: context,
  //       initialDate: pickedDate,
  //       firstDate: DateTime(DateTime.now().year - 0, DateTime.now().month - 0,
  //           DateTime.now().day - 0),
  //       lastDate: DateTime(DateTime.now().year + 1));
  //   if (date != null) {
  //     setState(() {
  //       pickedDate = date;
  //       print(pickedDate.millisecondsSinceEpoch);
  //     });
  //   }
  // }

  // picktime(BuildContext context) async {
  //   TimeOfDay t = await showTimePicker(
  //     context: context,
  //     initialTime: pickedTime,
  //   );
  //   if (t != null) {
  //     setState(() {
  //       pickedTime = t;
  //     });
  //   }
  // }

  List state = ['Waiting for confirmation', 'Ongoing', 'Completed'];
  List icons = [
    Icons.pending_actions,
    Icons.run_circle_rounded,
    Icons.done_all
  ];

  int currentStep = 0;
}

updateOrder({body, ordId}) async {
  log("update content $body");
  print(body);
  dynamic response =
      await Server().editMethod(API.editOrder + ordId.toString(), body);
  if (response.statusCode == 200 || response.statusCode == 204) {
    return jsonDecode(response.body);
  }
  return null;
}

Future<bool> feedbackOrder({body}) async {
  dynamic response = await Server().postMethod(API.serviceFeedBack, body);
  if (response.statusCode == 200 || response.statusCode == 204) {
    return true;
  }
  return false;
}

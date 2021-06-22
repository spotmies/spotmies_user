import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/views/home/ads/maps.dart';

class PostOverViewController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController problem = TextEditingController();
  String title;
  int dropDownValue = 0;

  @override
  void initState() {
    super.initState();
    // getAddressofLocation();
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
            builder: (context) => Maps(
              ordId: ordId,
            ),
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
    'development',
    'tutor',
    'beauty',
    'photography',
    'drivers',
    'events',
    'Electrician',
    'Carpentor',
    'Plumber',
  ];

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
                        if (value.isEmpty) {
                          return 'Please discribe your problem';
                        }
                        return null;
                      },
                      keyboardType: edit == 'problem'
                          ? TextInputType.name
                          : TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey[100])),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey[100])),
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

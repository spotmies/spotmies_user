import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/login_controller/stepperPersonalInfo_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/providers/timer_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/reusable_widgets/progress_waiter.dart';

class StepperPersonalInfo extends StatefulWidget {
  @override
  _StepperPersonalInfoState createState() => _StepperPersonalInfoState();
}

class _StepperPersonalInfoState extends StateMVC<StepperPersonalInfo> {
  StepperPersonal _stepperPersonalInfo;
  _StepperPersonalInfoState() : super(StepperPersonal()) {
    this._stepperPersonalInfo = controller;
  }
  TimeProvider timerProvider;
  @override
  void initState() {
    timerProvider = Provider.of<TimeProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      key: _stepperPersonalInfo.scaffoldkey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Create account',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[50],
      body: Consumer<TimeProvider>(builder: (context, data, child) {
        return Theme(
          data: ThemeData(primaryColor: Colors.blue[900]),
          child: Stack(children: [
            Stepper(
                type: StepperType.horizontal,
                currentStep: _stepperPersonalInfo.currentStep,
                onStepTapped: (int step) =>
                    setState(() => _stepperPersonalInfo.currentStep = step),
                controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: width(context) * 0.35,
                          child: ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.navigate_before),
                                Text('Back'),
                              ],
                            ),
                            onPressed: onStepCancel,
                            style: ButtonStyle(
                              backgroundColor: _stepperPersonalInfo
                                          .currentStep >
                                      0
                                  ? MaterialStateProperty.all(Colors.blue[900])
                                  : MaterialStateProperty.all(Colors.white),
                            ),
                          ),
                        ),
                        _stepperPersonalInfo.currentStep ==
                                2 // this is the last step
                            ? Container(
                                width: width(context) * 0.35,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    CircularProgressIndicator();
                                    var resp =
                                        await _stepperPersonalInfo.step3();
                                    log("resp $resp");
                                    // await Navigator.pushAndRemoveUntil(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => GoogleNavBar()),
                                    //     (route) => false);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Finish'),
                                      Icon(Icons.navigate_next),
                                    ],
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blue[900]),
                                  ),
                                  //color: Colors.green,
                                ),
                              )
                            : Container(
                                width: width(context) * 0.35,
                                child: ElevatedButton(
                                  onPressed: onStepContinue,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Next'),
                                      Icon(Icons.navigate_next),
                                    ],
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blue[900]),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  );
                },
                onStepContinue: _stepperPersonalInfo.currentStep == 0
                    ? () => setState(() => _stepperPersonalInfo.step1())
                    : _stepperPersonalInfo.currentStep == 1
                        ? () => setState(() => _stepperPersonalInfo.step2())
                        : _stepperPersonalInfo.currentStep == 2
                            ? () => setState(() => _stepperPersonalInfo.step3())
                            : null,
                onStepCancel: _stepperPersonalInfo.currentStep > 0
                    ? () =>
                        setState(() => _stepperPersonalInfo.currentStep -= 1)
                    : null,
                steps: <Step>[
                  Step(
                    title: Text('Step1'),
                    subtitle: Text('Terms'),
                    content: step1(),
                    isActive: _stepperPersonalInfo.currentStep >= 0,
                    state: _stepperPersonalInfo.currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: Text('Step 2'),
                    subtitle: Text('Profile'),
                    content: Form(
                      key: _stepperPersonalInfo.formkey,
                      child: step2(),
                    ),
                    isActive: _stepperPersonalInfo.currentStep >= 1,
                    state: _stepperPersonalInfo.currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: Text('Step 3'),
                    subtitle: Text('Photo'),
                    content: step3(),
                    isActive: _stepperPersonalInfo.currentStep >= 2,
                    state: _stepperPersonalInfo.currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ]),
            ProgressWaiter(contextt: context, loaderState: data.getLoader)
          ]),
        );
      }),
    );
  }

  Widget step1() {
  
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          height: height(context) * 0.75,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('terms')
                  .doc('eXiU3vxjO7qeVObTqvmQ')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                var document = snapshot.data;
                return ListView(
                    controller: _stepperPersonalInfo.scrollController,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1. ' + document['1'],
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '2.' + document['2'],
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '3.' + document['3'],
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '4.' + document['4'],
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '5.' + document['5'],
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '6.' + document['6'],
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '7.' + document['7'],
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '8.' + document['8'],
                            style: TextStyle(fontSize: 20),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  activeColor: Colors.white,
                                  checkColor: Colors.lightGreen,
                                  value: _stepperPersonalInfo.accept,
                                  onChanged: (bool value) {
                                    setState(
                                      () {
                                        _stepperPersonalInfo.accept = value;
                                        if (_stepperPersonalInfo.accept ==
                                            true) {
                                          _stepperPersonalInfo.tca = 'accepted';
                                        }
                                      },
                                    );
                                  }),
                              Flexible(
                                child: Text(
                                  'I agree to accept the terms and Conditions',
                                  maxLines: 4,
                                  style: TextStyle(fontSize: width(context) * 0.035),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]);
              }),
        ),
      ],
    );
  }

  Widget step2() {
   
    return Column(
      children: [
        Container(
          height: height(context) * 0.75,
          child: ListView(
            children: [
              Container(
                // padding: EdgeInsets.all(10),
                height: height(context) * 0.1,
                width: width(context) * 1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  onSaved: (item) =>
                      _stepperPersonalInfo.stepperPersonalModel.name,
                  keyboardType: TextInputType.name,
                  controller: _stepperPersonalInfo.nameTf,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 1, color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 1, color: Colors.white)),
                    hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                    hintText: 'Name',
                    suffixIcon: Icon(Icons.person),
                    //border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                    if (value.length < 5)
                      return 'name should be greater than 4 letters';
                    return null;
                  },
                  onChanged: (value) {
                    this._stepperPersonalInfo.name = value;
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                //padding: EdgeInsets.all(10),
                height: height(context) * 0.1,
                width: width(context) * 1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  onSaved: (item) =>
                      _stepperPersonalInfo.stepperPersonalModel.email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 1, color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 1, color: Colors.white)),
                    hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                    hintText: 'Email(Optional)',
                    suffixIcon: Icon(Icons.email),
                    //border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                  ),
                  validator: (value) {
                    if (value.length > 1 && !value.contains('@')) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                  controller: _stepperPersonalInfo.emailTf,
                  onChanged: (value) {
                    this._stepperPersonalInfo.email = value ?? "";
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                //padding: EdgeInsets.all(10),
                height: height(context) * 0.1,
                width: width(context) * 1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  maxLength: 10,
                  onSaved: (item) =>
                      _stepperPersonalInfo.stepperPersonalModel.altnumber,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    // labelText: "optional",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 1, color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 1, color: Colors.white)),
                    hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                    hintText: 'Alternative Mobile (optional)',
                    suffixIcon: Icon(Icons.dialpad),
                    //border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                    counterText: "",
                  ),
                  validator: (value) {
                    if (value.length == 10 && int.parse(value) < 5000000000) {
                      return 'Please Enter Valid Mobile Number';
                    } else if (value.length > 0 && value.length < 10) {
                      return 'Please Enter Valid Mobile Number';
                    }
                    return null;
                  },
                  controller: _stepperPersonalInfo.altnumberTf,
                  onChanged: (value) {
                    this._stepperPersonalInfo.altnumber = value ?? "";
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget step3() {
    return Column(
      children: [
        Container(
          height: height(context) * 0.75,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Profile Picture',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  // border: Border.all()
                ),
                child: CircleAvatar(
                  child: Center(
                    child: _stepperPersonalInfo.profilepic == null
                        ? Icon(
                            Icons.person,
                            color: Colors.blueGrey,
                            size: 200,
                          )
                        : Container(
                            height: height(context) * 0.27,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundImage:
                                  FileImage(_stepperPersonalInfo.profilepic),
                              radius: 100,
                            ),
                          ),
                  ),
                  radius: 30,
                  backgroundColor: Colors.grey[100],
                ),
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                // border: Border.all()
              ),
              child: TextButton(
                  onPressed: () {
                    _stepperPersonalInfo.profilePic();
                  },
                  // icon: Icon(Icons.select_all),
                  child: Text(
                    'Choose Image',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  )),
              // child: FlatButton(color:Colors.blue[700], onPressed: (){}, child: Text('Choose image')),
            ),
            SizedBox(
              height: 65,
            ),
            if (_stepperPersonalInfo.profilepic == null)
              TextButton(
                  onPressed: () {
                    _stepperPersonalInfo.step3();
                  },
                  child: Text('Skip',
                      style: TextStyle(fontSize: 20, color: Colors.black)))
          ]),
        )
      ],
    );
  }
}

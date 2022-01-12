import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/login_controller/stepperPersonalInfo_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/providers/timer_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/reusable_widgets/progress_waiter.dart';

class StepperPersonalInfo extends StatefulWidget {
  @override
  _StepperPersonalInfoState createState() => _StepperPersonalInfoState();
}

class _StepperPersonalInfoState extends StateMVC<StepperPersonalInfo> {
  StepperPersonal _stepperPersonalInfo;
  UniversalProvider up;

  _StepperPersonalInfoState() : super(StepperPersonal()) {
    this._stepperPersonalInfo = controller;
  }
  TimeProvider timerProvider;
  @override
  void initState() {
    timerProvider = Provider.of<TimeProvider>(context, listen: false);
    up = Provider.of<UniversalProvider>(context, listen: false);
    up.setCurrentConstants("signup");
    _stepperPersonalInfo.termsAndConditions =
        up.getValue("terms_and_conditions") ??
            _stepperPersonalInfo.offlineTermsAndConditions;
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
                controlsBuilder:
                    (BuildContext context, ControlsDetails controlsDetails) {
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
                            onPressed: () {
                              controlsDetails.onStepCancel();
                            },
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
                                  onPressed: () {
                                    controlsDetails.onStepContinue();
                                  },
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
                    content: step1(_stepperPersonalInfo.termsAndConditions),
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

  Widget step1(List termsAndConditions) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          height: height(context) * 0.75,
          child: termsAndConditions.length != 0
              ? Container(
                  height: height(context) * 0.7,
                  child: ListView.builder(
                      controller: _stepperPersonalInfo.scrollController,
                      itemCount: termsAndConditions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            TextWidget(
                              text: "${index + 1}.  " +
                                  termsAndConditions[index].toString(),
                              size: width(context) * 0.06,
                              flow: TextOverflow.visible,
                            ),
                            if (index != 7)
                              Divider(
                                color: Colors.grey[400],
                                indent: width(context) * 0.1,
                                endIndent: width(context) * 0.1,
                              ),
                            if (index == termsAndConditions.length - 1)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                      activeColor: Colors.teal,
                                      checkColor: Colors.white,
                                      value: _stepperPersonalInfo.accept,
                                      shape: CircleBorder(),
                                      onChanged: (bool value) {
                                        _stepperPersonalInfo.accept = value;
                                        if (_stepperPersonalInfo.accept ==
                                            true) {
                                          _stepperPersonalInfo.tca = 'accepted';
                                        }
                                        _stepperPersonalInfo.refresh();
                                      }),
                                  Text(
                                    'I agree to accept the terms and Conditions',
                                    style: TextStyle(
                                        fontSize: width(context) * 0.03),
                                  ),
                                ],
                              ),
                          ],
                        );
                      }),
                )
              : CircularProgressIndicator(),
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

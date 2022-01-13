import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:spotmies/controllers/posts_controllers/postOvervire_controller.dart';

class PostOverView extends StatefulWidget {
  final String value;
  PostOverView({required this.value});
  @override
  _PostOverViewState createState() => _PostOverViewState(value);
}

class _PostOverViewState extends StateMVC<PostOverView> {
  late PostOverViewController _stepperPersonalInfo;
  _PostOverViewState(this.value) : super(PostOverViewController()) {
    this._stepperPersonalInfo = controller as PostOverViewController;
  }
  String value;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ad Details'),
        backgroundColor: Colors.blue[800],
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('adpost')
              .doc(value)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            var document = snapshot.data;
            return ListView(children: [
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                height: _hight * 0.06,
                width: _width * 1,
                child: Text('Order ID - ' + document?['orderid']),
              ),
              Divider(
                // height: 1,
                thickness: 1,
                color: Colors.grey[300],
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: _hight * 0.2,
                width: _width * 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: _width * 0.5,
                      child: Text(
                        document?['problem'] == null
                            ? 'null'
                            : document?['problem'],
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      width: _width * 0.35,
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          boxShadow: [
                            BoxShadow(blurRadius: 2, color: Colors.black)
                          ],
                          borderRadius: BorderRadius.circular(0)),
                      child: Image.network(
                          'https://c.ndtvimg.com/2020-12/5biqo2oo_prabhas_625x300_02_December_20.jpg'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      '₹' + (document?['money'] ?? "").toString(),
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey[300],
              ),
              Container(
                height: _hight * 0.45,
                child: Stepper(
                    type: StepperType.vertical,
                    currentStep: _stepperPersonalInfo.currentStep,
                    onStepTapped: (int step) =>
                        setState(() => _stepperPersonalInfo.currentStep = step),
                    controlsBuilder:
                        (BuildContext context, ControlsDetails details) =>
                            Container(),
                    steps: <Step>[
                      Step(
                        title: Text('Ordered'),
                        content: Text(
                          'Waiting to confirm order',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        //  Image.asset(
                        //   "Images/160x160_Flutter.png",
                        //   width: 100,
                        //   height: 100,
                        // ),
                        isActive: document?['orderstate'] >= 0,
                        state: document?['orderstate'] >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Confirmed'),
                        content: Column(
                          children: [
                            Text('Order ongoing',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Conformed by technician',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey)),
                          ],
                        ),
                        isActive: document?['orderstate'] >= 1,
                        state: document?['orderstate'] >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Completed'),
                        content: Text('Order Completed',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        isActive: document?['orderstate'] >= 2,
                        state: document?['orderstate'] >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ]),
              ),
              SizedBox(
                height: _hight * 0.02,
              ),
              Center(
                child: document?['orderstate'] == 2
                    ? Container(
                        width: _width * 0.25,
                        height: _hight * 0.06,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible:
                                          true, // set to false if you want to force a rating
                                      builder: (context) {
                                        return RatingDialog(
                                          icon: const FlutterLogo(
                                            size: 100,
                                          ), // set your own image/icon widget
                                          title: "The Rating Dialog",
                                          description:
                                              "Tap a star to set your rating. Add more description here if you want.",
                                          submitButton: "SUBMIT",
                                          alternativeButton:
                                              "Contact us instead?", // optional
                                          positiveComment:
                                              "We are so happy to hear :)", // optional
                                          negativeComment:
                                              "We're sad to hear :(", // optional
                                          accentColor:
                                              Colors.blue[800], // optional
                                          onSubmitPressed: (int rating) {
                                            print(
                                                "onSubmitPressed: rating = $rating");
                                          },
                                          onAlternativePressed: () {
                                            print(
                                                "onAlternativePressed: do something");
                                          },
                                        );
                                      });
                                },
                                child: Text(
                                  'Rating',
                                  style: TextStyle(color: Colors.grey[900]),
                                ))
                          ],
                        ),
                      )
                    : Container(
                        child: Text('order on progress'),
                      ),
              )
            ]);
          }),
    );
  }
}

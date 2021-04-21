import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class PostOverView extends StatefulWidget {
  final String value;
  PostOverView({this.value});
  @override
  _PostOverViewState createState() => _PostOverViewState(value);
}

class _PostOverViewState extends State<PostOverView> {
  String value;
  _PostOverViewState(this.value);
  int _currentStep = 0;

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
        title: Text('Details'),
        backgroundColor: Colors.blue[800],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .collection('adpost')
              .doc(value)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            var document = snapshot.data;
            List<String> images = List.from(document['media']);
            return ListView(children: [
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                height: _hight * 0.06,
                width: _width * 1,
                child: Text('Order ID - ' + document['orderid']),
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
                        document['problem'] == null
                            ? 'null'
                            : document['problem'],
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
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.zero,
                                  contentPadding: EdgeInsets.zero,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  actions: [
                                    Container(
                                        height: _hight * 0.35,
                                        width: _width * 1,
                                        child: CarouselSlider.builder(
                                          itemCount: images.length,
                                          itemBuilder: (ctx, index, realIdx) {
                                            return Container(
                                                child: Image.network(
                                                    images[index].substring(
                                                        0,
                                                        images[index].length -
                                                            1)));
                                          },
                                          options: CarouselOptions(
                                            autoPlayInterval:
                                                Duration(seconds: 3),
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 800),
                                            autoPlay: true,
                                            aspectRatio: 2.0,
                                            enlargeCenterPage: true,
                                          ),
                                        ))
                                  ],
                                );
                              });
                        },
                        child: Image.network(images.first),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      '₹' + document['money'].toString(),
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey[300],
              ),
              Container(
                height: _hight * 0.40,
                child: Theme(
                  data: ThemeData(primaryColor: Colors.blue[800]),
                  child: Stepper(
                      type: StepperType.vertical,
                      currentStep: _currentStep,
                      onStepTapped: (int step) =>
                          setState(() => _currentStep = step),
                      controlsBuilder: (BuildContext context,
                              {VoidCallback onStepContinue,
                              VoidCallback onStepCancel}) =>
                          Container(),
                      steps: <Step>[
                        Step(
                          title: Text('Ordered'),
                          content: Text(
                            'Waiting to confirm order',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          isActive: document['orderstate'] >= 0,
                          state: document['orderstate'] >= 0
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: new Text('Confirmed'),
                          content: Column(
                            children: [
                              Text('Order ongoing',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Conformed by technician',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey)),
                            ],
                          ),
                          isActive: document['orderstate'] >= 1,
                          state: document['orderstate'] >= 1
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: new Text('Completed'),
                          content: Text('Order Completed',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          isActive: document['orderstate'] >= 2,
                          state: document['orderstate'] >= 2
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                      ]),
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: _hight * 0.07,
              ),
              Center(
                child: document['orderstate'] == 2
                    ? Container(
                        width: _width * 0.25,
                        height: _hight * 0.06,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300])),
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
                                          icon: Icon(
                                            Icons.rate_review,
                                            size: 100,
                                            color: Colors.blue[800],
                                          ),
                                          // const FlutterLogo(
                                          //   size: 100,
                                          // ), // set your own image/icon widget
                                          title: "Rate Your Technician!",
                                          description:
                                              "Express Your Experience By Tapping \nOn Stars",
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

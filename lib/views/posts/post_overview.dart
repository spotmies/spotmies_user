import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:spotmies/controllers/posts_controllers/postOvervire_controller.dart';

class PostOverView extends StatefulWidget {
  final String value;
  PostOverView({this.value});
  @override
  _PostOverViewState createState() => _PostOverViewState(value);
}

class _PostOverViewState extends StateMVC<PostOverView> {
  PostOverViewController _postOverViewController;
  _PostOverViewState(this.value) : super(PostOverViewController()) {
    this._postOverViewController = controller;
  }
  String value;
  // _PostOverViewState(this.value);
  // int _currentStep = 0;

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
      // appBar: AppBar(
      //   title: Text('Details'),
      //   backgroundColor: Colors.blue[800],
      // ),
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

            return CustomScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverAppBar(
                    backgroundColor: Colors.blue[900],
                    stretch: true,
                    pinned: true,
                    snap: false,
                    floating: true,
                    expandedHeight: _hight * 0.5,
                    flexibleSpace: FlexibleSpaceBar(
                        stretchModes: <StretchMode>[
                          StretchMode.zoomBackground,
                          StretchMode.fadeTitle,
                        ],
                        title: Text(
                          _postOverViewController.jobs
                              .elementAt(document['job']),
                        ),
                        background: Container(
                          width: _width * 1,
                          color: Colors.black,
                          child: GestureDetector(
                              onTap: () {
                                imageslider(images, _hight, _width);
                              },
                              child: Image.network(
                                images.first,
                                fit: BoxFit.cover,
                              )),
                        ))),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                    padding: EdgeInsets.only(
                        left: _width * 0.08, top: _width * 0.03),
                    height: _hight * 0.07,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Orderid:',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold)),
                        Text(document['orderid']),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 4,
                    color: Colors.grey[200],
                  ),
                  Container(
                    child: Theme(
                      data: ThemeData(primaryColor: Colors.blue[900]),
                      child: Stepper(
                          type: StepperType.vertical,
                          currentStep: _postOverViewController.currentStep,
                          onStepTapped: (int step) => setState(
                              () => _postOverViewController.currentStep = step),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
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
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              isActive: document['orderstate'] >= 2,
                              state: document['orderstate'] >= 2
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                          ]),
                    ),
                  ),
                  Divider(
                    thickness: 4,
                    color: Colors.grey[200],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: _width * 0.09),
                    height: _hight * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Problem:',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold)),
                        Flexible(
                          child: Text(
                            document['problem'],
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 4,
                    color: Colors.grey[200],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: _width * 0.09),
                    height: _hight * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amount quoted:',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold)),
                        Text('₹' + document['money'].toString(),
                            style: TextStyle(
                              color: Colors.grey[700],
                            )),
                        // Text(document['orderid']),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 4,
                    color: Colors.grey[200],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: _width * 0.09),
                    height: _hight * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Schedule:',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold)),
                        Text(
                            document['scheduledate'] +
                                '@' +
                                document['scheduletime'],
                            style: TextStyle(
                              color: Colors.grey[700],
                            ))
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 4,
                    color: Colors.grey[200],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: _width * 0.09),
                    height: _hight * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Service location:',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold)),
                        Text(document['location.add1'],
                            style: TextStyle(
                              color: Colors.grey[700],
                            ))
                      ],
                    ),
                  ),
                  document['orderstate'] == 2
                      ? Container(
                          color: Colors.blue[900],
                          child: IconButton(
                              onPressed: () {
                                rating();
                              },
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Rate',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: _width * 0.05),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                                ],
                              )),
                        )
                      : Container(
                          color: Colors.blue[900],
                          child: IconButton(
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Complete',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              onPressed: () {}),
                        ),
                ]))
              ],
            );
          }),
    );
  }

  rating() {
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
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
            description: "Express Your Experience By Tapping \nOn Stars",
            submitButton: "SUBMIT",
            alternativeButton: "Contact us instead?", // optional
            positiveComment: "We are so happy to hear :)", // optional
            negativeComment: "We're sad to hear :(", // optional
            accentColor: Colors.blue[800], // optional
            onSubmitPressed: (int rating) {
              print("onSubmitPressed: rating = $rating");
            },
            onAlternativePressed: () {
              print("onAlternativePressed: do something");
            },
          );
        });
  }

  imageslider(List<String> images, double hight, double width) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            actions: [
              Container(
                  height: hight * 0.35,
                  width: width * 1,
                  child: CarouselSlider.builder(
                    itemCount: images.length,
                    itemBuilder: (ctx, index, realIdx) {
                      return Container(
                          child: Image.network(images[index]
                              .substring(0, images[index].length - 1)));
                    },
                    options: CarouselOptions(
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    ),
                  ))
            ],
          );
        });
  }
}

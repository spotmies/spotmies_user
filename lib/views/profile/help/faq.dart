import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/profile_controllers/profile_controller.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/views/reusable_widgets/queryBS.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class FAQ extends StatefulWidget {
  final ProfileController controller;
  FAQ(this.controller);
  @override
  _FAQState createState() => _FAQState();
}

UniversalProvider up;
GlobalKey exKey = GlobalKey();

class _FAQState extends State<FAQ> {
  @override
  void initState() {
    up = Provider.of<UniversalProvider>(context, listen: false);
    if (up.faqList.length < 1) up.fetchFAQfromDB();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey[900],
            )),
        title: TextWid(
          text: 'Frequently Asked Questions',
          size: width(context) * 0.055,
          weight: FontWeight.w600,
        ),
      ),
      body: Consumer<UniversalProvider>(builder: (context, data, child) {
        log(data.faqList.toString());

        List faq = data.faqList;
        if (faq.length < 1)
          return Center(
            child: CircularProgressIndicator(),
          );

        return ListView.builder(
            itemCount: faq.length,
            itemBuilder: (context, index) {
              var body = faq[index]['body'];
              return Column(
                children: [
                  SizedBox(
                    height: height(context) * 0.02,
                  ),
                  Container(
                    width: width(context) * 0.95,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: ExpansionTile(
                        backgroundColor: Colors.white,
                        collapsedBackgroundColor: Colors.white,
                        textColor: Colors.indigo[900],
                        iconColor: Colors.indigo[900],
                        collapsedIconColor: Colors.grey[900],
                        collapsedTextColor: Colors.grey[900],
                        title: TextWid(
                          text: faq[index]['title'],
                          size: width(context) * 0.05,
                          weight: FontWeight.w500,
                          flow: TextOverflow.visible,
                        ),
                        subtitle: TextWid(
                          text: faq[index]['description'],
                          size: width(context) * 0.03,
                          weight: FontWeight.w500,
                          flow: TextOverflow.visible,
                        ),
                        children: [
                          Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: Container(
                              height: body.length <= 2
                                  ? height(context) * 0.25
                                  : body.length * (height(context) * 0.09),
                              child: ListView.builder(
                                  itemCount: body.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: ExpansionTile(
                                        // key: exKey,
                                        backgroundColor: Colors.white,
                                        collapsedBackgroundColor: Colors.white,
                                        leading: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.help),
                                          ],
                                        ),
                                        // expandedAlignment: Alignment.center,
                                        textColor: Colors.indigo[900],
                                        iconColor: Colors.indigo[900],
                                        collapsedIconColor: Colors.indigo[900],
                                        collapsedTextColor: Colors.indigo[900],
                                        title: TextWid(
                                          text: body[index]['question'],
                                          size: width(context) * 0.05,
                                          weight: FontWeight.w500,
                                          flow: TextOverflow.visible,
                                          color: Colors.indigo[900],
                                        ),

                                        children: [
                                          Container(
                                            // alignment: Alignment.centerRight,
                                            width: width(context) * 0.6,
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: TextWid(
                                              text: body[index]['answer'],
                                              flow: TextOverflow.visible,
                                              weight: FontWeight.w500,
                                              color: Colors.grey[700],
                                              lSpace: 0.4,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            });
      }),
      floatingActionButton: Container(
        padding: EdgeInsets.all(5),
        child: ElevatedButtonWidget(
          bgColor: Colors.indigo[900],
          minWidth: width(context) * 0.6,
          height: height(context) * 0.06,
          textColor: Colors.white,
          buttonName: 'Rise Query',
          textSize: width(context) * 0.05,
          textStyle: FontWeight.w600,
          borderRadius: 10.0,
          trailingIcon: Icon(Icons.question_answer),
          borderSideColor: Colors.indigo[900],
          onClick: () {
            String pD = up.user["_id"].toString();
            log(pD);
            newQueryBS(context, onSubmit: (String output) {
              widget.controller.submitQuery(output, pD, context);
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

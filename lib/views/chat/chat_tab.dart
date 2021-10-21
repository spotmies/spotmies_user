import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/chat/chatapp/chat_list.dart';
import 'package:spotmies/views/chat/response.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var name = 'Response';
  var list = [
    Center(
      child: Responsee(),
    ),
    Center(
      child: ChatList(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: height(context) * 0.0,
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(height(context) * 0.09),
              child: Container(
              
                child: TabBar(
                    unselectedLabelColor: Colors.grey[700],
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.indigo[900],
                    onTap: (tab) {
                      setState(() {
                        name = (tab == 0) ? 'Responses' : 'Chat';
                      });
                    },
                    tabs: [
                      Tab(
                        icon: Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(Icons.workspaces_filled),
                                SizedBox(
                                  width: width(context) * 0.02,
                                ),
                                Text(
                                  'Responses',
                                  style: GoogleFonts.josefinSans(
                                      color: Colors.indigo[900],
                                      fontSize: width(context) * 0.04,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                        ),
                      ),
                      Tab(
                        icon: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(Icons.mark_chat_read),
                              SizedBox(
                                width: width(context) * 0.02,
                              ),
                              Text(
                                'Chat',
                                style: GoogleFonts.josefinSans(
                                    color: Colors.indigo[900],
                                    fontSize: width(context) * 0.04,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          body: TabBarView(children: list),
        ));
  }
}

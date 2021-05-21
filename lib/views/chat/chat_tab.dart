import 'package:flutter/material.dart';
import 'package:spotmies/views/chat/chatapp/chat_page.dart';
import 'package:spotmies/views/chat/response.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var list = [
    Center(
      child: Responsee(),
    ),
    Center(
      child: ChatHome(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Responses',
                style: TextStyle(
                    color: Colors.grey.shade800, fontWeight: FontWeight.bold)),
            actions: [
             
              Icon(Icons.person,color: Colors.grey[800],)
            ],
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(_hight * 0.09),
              child: Container(
                height: _hight*0.06,
                padding: EdgeInsets.only(left:0,right: 0,bottom: 5),
                child: TabBar(
                    unselectedLabelColor: Colors.grey[700],
                    
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 0,
                    indicator: BoxDecoration(
                       
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue[900]),
                    tabs: [
                      Tab(
                        icon: Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.workspaces_filled),
                                SizedBox(
                                  width: _width * 0.02,
                                ),
                                Text(
                                  'Quotes',
                                ),
                              ]),
                        ),
                      ),
                      Tab(
                        icon: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.mark_chat_read),
                              SizedBox(
                                width: _width * 0.02,
                              ),
                              Text(
                                'Chat',
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/providers/chat_provider.dart';
import 'package:spotmies/providers/responses_provider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/chat/chatapp/chat_list.dart';
import 'package:spotmies/views/chat/response.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late ResponsesProvider responseProvider;
  late UniversalProvider universalProvider;
  late ChatProvider chatProvider;
  String name = 'Response';
  int initialTabIndex = 0;
  List<Center> list = [
    Center(
      child: Responsee(),
    ),
    Center(
      child: ChatList(),
    ),
  ];

  void initState() {
    universalProvider = Provider.of<UniversalProvider>(context, listen: false);

    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    responseProvider = Provider.of<ResponsesProvider>(context, listen: false);
    universalProvider.setCurrentConstants("chatScreen");
    setTabIndex();
    super.initState();
  }

  void setTabIndex() {
    if (responseProvider.responsesList.length < 1) {
      setState(() {
        initialTabIndex = 1;
      });
    } else if (chatProvider.chatList.length < 1) {
      setState(() {
        initialTabIndex = 0;
      });
    } else {
      if (responseProvider.responsesList[0]['join'] >
          chatProvider.chatList[0]['lastModified']) {
        setState(() {
          initialTabIndex = 0;
        });
      } else {
        setState(() {
          initialTabIndex = 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: initialTabIndex,
        length: 2,
        child: Scaffold(
          backgroundColor: SpotmiesTheme.background,
          appBar: AppBar(
            toolbarHeight: height(context) * 0.07,
            backgroundColor: SpotmiesTheme.background,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(10),
                child: Container(
                  child: TabBar(
                      unselectedLabelColor: SpotmiesTheme.secondary,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: SpotmiesTheme.onBackground,
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
                                    // universalProvider.getText("response_tab"),
                                    tr('response'),
                                    style: GoogleFonts.josefinSans(
                                        color: SpotmiesTheme.onBackground,
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
                                  // universalProvider.getText("chat_tab"),
                                  tr('chat'),
                                  style: GoogleFonts.josefinSans(
                                      color: SpotmiesTheme.onBackground,
                                      fontSize: width(context) * 0.04,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                )),
          ),
          body: TabBarView(children: list),
        ));
  }
}

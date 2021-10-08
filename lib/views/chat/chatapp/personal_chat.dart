import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/chat_controllers/chat_controller.dart';
import 'package:spotmies/providers/chat_provider.dart';
import 'package:spotmies/providers/responses_provider.dart';
import 'package:spotmies/utilities/constants.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/views/chat/chatapp/partner_details.dart';
import 'package:spotmies/views/internet_calling/calling.dart';
import 'package:spotmies/views/reusable_widgets/bottom_options_menu.dart';
import 'package:spotmies/views/reusable_widgets/chat_input_field.dart';
import 'package:spotmies/views/reusable_widgets/date_formates.dart';
import 'package:spotmies/views/reusable_widgets/profile_pic.dart';
import 'package:spotmies/views/reusable_widgets/progress_waiter.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalChat extends StatefulWidget {
  final String msgId;
  PersonalChat(this.msgId);
  @override
  _PersonalChatState createState() => _PersonalChatState();
}

class _PersonalChatState extends StateMVC<PersonalChat> {
  ChatController _chatController;

  _PersonalChatState() : super(ChatController()) {
    this._chatController = controller;
  }
  ChatProvider chatProvider;
  ResponsesProvider responseProvider;

  ScrollController _scrollController = ScrollController();

  int msgCount = 20;
  void scrollToBottom() {
    Timer(
        Duration(milliseconds: 200),
        () => _scrollController
            .jumpTo(_scrollController.position.minScrollExtent));
  }

  @override
  void initState() {
    super.initState();
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    responseProvider = Provider.of<ResponsesProvider>(context, listen: false);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // log("at top >>>");
        chatProvider.setMsgCount(chatProvider.getMsgCount() + 20);
      }
      if (_scrollController.position.pixels < 40) {
        // log('disable float >>>>>>>>>>>>');
        if (chatProvider.getFloat()) chatProvider.setFloat(false);
      } else if (_scrollController.position.pixels > 40) {
        if (!chatProvider.getFloat()) {
          chatProvider.setFloat(true);
          // log('en float >>>>>>>>>>>>');
        }
      }
    });
  }

  sendMessageHandler(value, {sender: "user", action: ""}) {
    _chatController.sendMessageHandler(widget.msgId, value,
        sender: sender, action: action);
  }

  // disableChat() {
  //   print("disable chat");
  //   _chatController.chatStreamSocket(_chatController.targetChat,
  //       typeOfAction: "disable");
  // }

  // deleteChat() {
  //   print("delete chat");
  //   _chatController.chatStreamSocket(_chatController.targetChat,
  //       typeOfAction: "delete");
  //   Navigator.pop(context, false);
  // }

  revealMyProfile(bool state) {
    print("reveal profile $state");
    sendMessageHandler(state ? "user shared profile" : "user disabled Profile",
        sender: "bot", action: state ? "enableProfile" : "disableProfile");
    _chatController.revealProfile(_chatController.targetChat,
        revealProfile: state);
  }

  isMyProfileRevealedFunc() {
    log("revela true  ${_chatController.orderDetails['revealProfileTo']}");
    if (_chatController.orderDetails['revealProfileTo']
        .contains(_chatController.targetChat['pId'])) {
      log("revela true  ${_chatController.orderDetails['revealProfileTo']}");
      return true;
    }
    log("revela true");
    return false;
  }

  List options = [
    {
      "name": "view order",
      "icon": Icons.remove_red_eye,
    },
    {
      "name": "Reveal My profile",
      "icon": Icons.share,
    },
    {
      "name": "Disable chat",
      "icon": Icons.block,
    },
    {
      "name": "Delete chat",
      "icon": Icons.delete_forever,
    },
  ];

  acceptRejectPartner(responseType) {
    dynamic checkThisResponse = responseProvider.getResponseByordIdAndPid(
        pId: _chatController.targetChat['pId'],
        ordId: _chatController.targetChat['ordId']);
    if (checkThisResponse == null) {
      snackbar(
          context, "Your already Accept or Reject this partner for the order");
      return;
    }
    responseProvider.addNewResponsesQueue({
      "pId": _chatController.targetChat['pId'],
      "ordId": _chatController.targetChat['ordId'],
      "responseType": responseType == "accept" ? "accept" : "reject"
    });
    _chatController.sendMessageHandler(widget.msgId,
        "${_chatController.userDetails['name']} $responseType the order",
        sender: "bot",
        action: responseType == "accept" ? "acceptOrder" : "rejectOrder");
  }

  typeofChat(type, message, sender, double hight, double width,
      ChatController chatController, BuildContext context) {
    String isLink = message.toString();
    // bool isPlaying = false;

    if ((isLink.contains('http') ||
            isLink.contains('https') ||
            isLink.contains('.com')) &&
        type == 'text') {
      return TextButton(
          onPressed: () {
            launch(message);
          },
          child: TextWid(
              text: message,
              weight: FontWeight.w600,
              color: Colors.indigo,
              decoration: TextDecoration.underline));
    } else {
      switch (type) {
        case 'text':
          return TextWid(
            text: toBeginningOfSentenceCase(message),
            maxlines: 200,
            lSpace: 1.5,
            color: messageColorTheme(sender)[1],
            weight: sender == "partner" ? FontWeight.w600 : FontWeight.w600,
          );
          break;
        case 'img':
          return InkWell(
              onTap: () {
                snackbar(context, "Media player not found");
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => ImageViewer(imageLink: message)));
              },
              child: Container(
                  height: width * 0.55,
                  width: width * 0.55,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(message), fit: BoxFit.cover))));

          break;
        case 'video':
          return TextButton(
              onPressed: () {
                snackbar(context, "Media player not found");
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => Video(videoLink: message)));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.slow_motion_video,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  TextWid(
                      text: 'Play Video',
                      weight: FontWeight.w600,
                      color: Colors.indigo,
                      decoration: TextDecoration.underline),
                ],
              ));
          break;
        case 'audio':
          return TextButton(
              onPressed: () {
                snackbar(context, "Media player not found");
                // playAudio(context, hight, width, message);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.audiotrack,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  TextWid(
                      text: 'Play Audio',
                      weight: FontWeight.w600,
                      color: Colors.indigo,
                      decoration: TextDecoration.underline),
                ],
              ));
        case "call":
          return TextWid(
            text: sender == "user" ? "OutGoing Call" : "Incoming Call",
            maxlines: 200,
            lSpace: 1.5,
            color: sender == "user" ? Colors.grey[800] : Colors.grey[900],
            weight: sender == "user" ? FontWeight.w600 : FontWeight.w600,
          );
          break;
        default:
          return TextWid(
            text: message,
          );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    log("======== render chat screen =============");
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Consumer<ChatProvider>(builder: (context, data, child) {
      _chatController.currentMsgId = widget.msgId;
      _chatController.chatList = data.getChatList2();
      _chatController.targetChat =
          _chatController.getTargetChat(_chatController.chatList, widget.msgId);
      _chatController.userDetails = _chatController.targetChat['uDetails'];
      _chatController.partner = _chatController.targetChat['pDetails'];
      _chatController.orderDetails = _chatController.targetChat['orderDetails'];
      // bool showConfirmation =
      //     _chatController.targetChat['orderDetails']['ordState'] == "req" ? true : false;
      bool showConfirmation =
          _chatController.targetChat['orderDetails']['orderState'] < 7
              ? true
              : false;

      List messages = _chatController.targetChat['msgs'];
      return Stack(
        children: [
          Scaffold(
              key: _chatController.scaffoldkey,
              appBar: _buildAppBar(context, _hight, _width,
                  showConfirmation: showConfirmation, onClickYes: () {
                acceptRejectPartner("accept");
              }, onClickNo: () {
                acceptRejectPartner("reject");
              }),
              body: Container(
                child: Column(children: [
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          reverse: true,
                          controller: _scrollController,
                          itemCount: data.getMsgCount() < messages.length
                              ? data.getMsgCount()
                              : messages.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map rawMsgData = jsonDecode(
                                messages[(messages.length - 1) - index]);
                            // Map rawMsgDataprev = rawMsgData;

                            Map rawMsgDataprev;
                            if (index == messages.length - 1) {
                              rawMsgDataprev = rawMsgData;
                            } else {
                              rawMsgDataprev = jsonDecode(messages[
                                  (messages.length - 1) - (index + 1)]);
                            }

                            String message = rawMsgData['msg'];
                            String sender = rawMsgData['sender'];
                            String type = rawMsgData['type'];

                            return Container(
                              padding: EdgeInsets.only(
                                  left: sender != "user" ? 10 : 0,
                                  bottom: 5,
                                  right: sender != "user" ? 0 : 10),
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: _chatController.dateCompare(
                                                rawMsgData['time'],
                                                rawMsgDataprev['time']) !=
                                            "false" ||
                                        index == messages.length - 1,
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(top: 30, bottom: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[900],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.only(
                                                right: 20,
                                                left: 20,
                                                top: 7,
                                                bottom: 7),
                                            alignment: Alignment.center,
                                            child: TextWid(
                                              text: index == messages.length - 1
                                                  ? _chatController.getDate(
                                                      rawMsgData['time'])
                                                  : _chatController.dateCompare(
                                                      rawMsgData['time'],
                                                      rawMsgDataprev['time']),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: sender == "user"
                                        ? MainAxisAlignment.end
                                        : sender == "partner"
                                            ? MainAxisAlignment.start
                                            : MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            constraints: BoxConstraints(
                                                minHeight: _hight * 0.05,
                                                minWidth: 30,
                                                maxWidth: _width * 0.50),
                                            decoration: BoxDecoration(
                                                color: messageColorTheme(
                                                    sender.toString())[0],
                                                border: Border.all(
                                                    color: Colors.blueGrey[500],
                                                    width: 0.3),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(
                                                            sender != "user"
                                                                ? 15
                                                                : 0),
                                                    bottomLeft: Radius.circular(
                                                        sender == "user"
                                                            ? 15
                                                            : 0))),
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      top: 10,
                                                      right: 10),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: typeofChat(
                                                      type,
                                                      message,
                                                      sender,
                                                      _hight,
                                                      _width,
                                                      _chatController,
                                                      context),
                                                ),
                                                // Container(
                                                //     padding: EdgeInsets.only(
                                                //         left: 10,
                                                //         top: 10,
                                                //         right: 10),
                                                //     alignment:
                                                //         Alignment.centerLeft,
                                                //     child: type == "text" ||
                                                //             type == "call"
                                                //         ? TextWid(
                                                //             text:
                                                //                 toBeginningOfSentenceCase(
                                                //                     message),
                                                //             maxlines: 200,
                                                //             lSpace: 1.5,
                                                //             color: sender ==
                                                //                     "user"
                                                //                 ? Colors.white
                                                //                 : Colors
                                                //                     .grey[900],
                                                //           )
                                                //         : type != "audio"
                                                //             ? Image.network(
                                                //                 message)
                                                //             : type != "video"
                                                //                 ? Text('audio')
                                                //                 : Text(
                                                //                     'video')),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 10, top: 5),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: TextWid(
                                                    text: getTime(
                                                        rawMsgData['time']),
                                                    size: _width * 0.03,
                                                    color: sender == "user"
                                                        ? Colors.grey[50]
                                                        : Colors.grey[500],
                                                    weight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //

                                          Visibility(
                                            visible:
                                                index == 0 && sender == "user",
                                            child: readReciept(
                                                _width,
                                                _chatController
                                                    .targetChat['uState']),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                  _chatController.targetChat['cBuild'] == 1
                      ? chatInputField(sendMessageHandler, context,
                          controller: _chatController)
                      : Container(
                          child: TextWid(text: "You can't Message any More"),
                        )
                ]),
              ),
              // }),
              floatingActionButton: Container(
                height: _hight * 0.2,
                padding: EdgeInsets.only(bottom: _hight * 0.1),
                child: Consumer<ChatProvider>(
                  builder: (context, data, child) {
                    return data.getFloat()
                        ? FloatingActionButton(
                            elevation: 0,
                            mini: true,
                            backgroundColor: Colors.white,
                            onPressed: () {
                              scrollToBottom();

                              // _scrollController
                              //     .jumpTo(_scrollController.position.maxScrollExtent);
                            },
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.blue[900],
                              size: _width * 0.07,
                            ),
                          )
                        : Container();
                  },
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat),
          ProgressWaiter(
            contextt: context,
            loaderState: data.personalChatLoader,
            loadingName: data.loaderText,
          )
        ],
      );
    });
  }

  Container readReciept(double _width, status) {
    getIcon() {
      switch (status) {
        case 0:
          return Icons.watch_later;
        case 1:
          return Icons.done;
        case 2:
        case 3:
          return Icons.done_all;

          break;
        default:
          return Icons.done;
      }
    }

    return Container(
        padding: EdgeInsets.only(right: 5),
        alignment: Alignment.centerRight,
        child: Icon(
          getIcon(),
          // Icons.done,
          // Icons.done_all,
          // Icons.watch_later,
          color: status == 3 ? Colors.blue : Colors.grey[400],
          size: _width * 0.05,
        ));
  }

  Widget _buildAppBar(BuildContext context, double hight, double width,
      {showConfirmation: false, onClickYes, onClickNo}) {
    return AppBar(
      toolbarHeight: showConfirmation ? hight * 0.13 : hight * 0.08,
      elevation: 2,
      backgroundColor: Colors.grey[50],
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
      bottom: PreferredSize(
          child: showConfirmation
              ? Container(
                  color: Colors.grey[200],
                  padding:
                      EdgeInsets.only(bottom: width * 0.01, top: width * 0.01),
                  // height: hight * 0.04,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: width * 0.45,
                        child: TextWid(
                          text: "Would you like to give order to this partner",
                          maxlines: 3,
                          size: width * 0.035,
                        ),
                      ),
                      ElevatedButtonWidget(
                        height: hight * 0.04,
                        minWidth: width * 0.22,
                        bgColor: Colors.white,
                        borderSideColor: Colors.grey[200],
                        borderRadius: 10.0,
                        buttonName: 'No',
                        onClick: onClickNo,
                        textSize: width * 0.04,
                        leadingIcon: Icon(
                          Icons.cancel_outlined,
                          color: Colors.grey[900],
                          size: width * 0.045,
                        ),
                      ),
                      ElevatedButtonWidget(
                        height: hight * 0.04,
                        minWidth: width * 0.22,
                        bgColor: Colors.white,
                        borderSideColor: Colors.grey,
                        borderRadius: 10.0,
                        buttonName: 'Yes',
                        onClick: onClickYes,
                        textSize: width * 0.04,
                        leadingIcon: Icon(
                          Icons.check_circle_outline,
                          color: Colors.grey[900],
                          size: width * 0.045,
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
          preferredSize: Size.fromHeight(4.0)),
      actions: [
        IconButton(
          onPressed: () {
            calling(context);
          },
          icon: Icon(
            Icons.phone,
            color: Colors.grey[900],
          ),
        ),
        IconButton(
            padding: EdgeInsets.only(bottom: 0),
            icon: Icon(
              Icons.more_vert,
              color: Colors.grey[900],
            ),
            onPressed: () {
              bottomOptionsMenu(
                context,
                options: options,
                menuTitle: "More options",
                option2Click: null,
                // option3Click: disableChat,
                // option4Click: deleteChat
              );
            })
      ],
      title: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PartnerDetails(
                  profileDetails: _chatController.partner,
                  chatDetails: _chatController.targetChat,
                  msgId: _chatController.targetChat['msgId'].toString(),
                  isMyProfileRevealed: isMyProfileRevealedFunc(),
                  revealMyProfile: (state) {
                    revealMyProfile(state);
                  },
                  onTapPhone: () {
                    calling(context);
                  })));
        },
        child: Row(
          children: [
            ProfilePic(
              name: _chatController.partner['name'],
              profile: _chatController.partner['partnerPic'],
              status: false,
              bgColor: Colors.blueGrey[600],
              size: width * 0.045,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: TextWid(
              text: _chatController.partner['name'] ?? "Spotmies User",
              size: width * 0.058,
              weight: FontWeight.w600,
            )),
          ],
        ),
      ),
    );
  }

  void calling(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MyCalling(
              msgId: widget.msgId,
              ordId: _chatController.targetChat['ordId'],
              uId: FirebaseAuth.instance.currentUser.uid,
              pId: _chatController.targetChat['pId'],
              isIncoming: false,
              name: _chatController.partner['name'],
              profile: _chatController.partner['partnerPic'],
              partnerDeviceToken:
                  _chatController.partner['partnerDeviceToken'].toString(),
            )));
  }
}

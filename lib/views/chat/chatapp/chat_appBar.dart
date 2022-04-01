
//   import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:spotmies/controllers/chat_controllers/chat_controller.dart';
// import 'package:spotmies/providers/chat_provider.dart';
// import 'package:spotmies/providers/theme_provider.dart';
// import 'package:spotmies/providers/userDetailsProvider.dart';
// import 'package:spotmies/utilities/constants.dart';
// import 'package:spotmies/utilities/elevatedButtonWidget.dart';
// import 'package:spotmies/views/chat/chatapp/partner_details.dart';
// import 'package:spotmies/views/internet_calling/calling.dart';
// import 'package:spotmies/views/reusable_widgets/bottom_options_menu.dart';
// import 'package:spotmies/views/reusable_widgets/profile_pic.dart';
// import 'package:spotmies/views/reusable_widgets/text_wid.dart';
// import 'package:url_launcher/url_launcher.dart';

// PreferredSizeWidget buildAppBar(
//       BuildContext context, ChatController? chatController,ChatProvider chatProvider,UserDetailsProvider? profileProvider,double hight, double width,
//       {showConfirmation: false, onClickYes, onClickNo}) {
//         List options = [
//     {
//       "name": "view order",
//       "icon": Icons.remove_red_eye,
//     },
//     {
//       "name": "Reveal My profile",
//       "icon": Icons.share,
//     },
//     {
//       "name": "Disable chat",
//       "icon": Icons.block,
//     },
//     {
//       "name": "Delete chat",
//       "icon": Icons.delete_forever,
//     },
//   ];
//     return AppBar(
//       toolbarHeight: showConfirmation ? hight * 0.13 : hight * 0.08,
//       elevation: 2,
//       backgroundColor: SpotmiesTheme.background,
//       leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context, false);
//           },
//           icon: Icon(
//             Icons.arrow_back,
//             color: SpotmiesTheme.onBackground,
//           )),
//       bottom: PreferredSize(
//           child: showConfirmation
//               ? Container(
//                   color: SpotmiesTheme.background,
//                   padding:
//                       EdgeInsets.only(bottom: width * 0.01, top: width * 0.01),
//                   // height: hight * 0.04,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Container(
//                         width: width * 0.42,
//                         child: TextWid(
//                           text: "Would you like to give order to this partner",
//                           maxlines: 3,
//                           size: width * 0.03,
//                         ),
//                       ),
//                       ElevatedButtonWidget(
//                         height: hight * 0.04,
//                         minWidth: width * 0.22,
//                         bgColor: Colors.white,
//                         borderSideColor: Colors.grey[200],
//                         borderRadius: 10.0,
//                         buttonName: 'No',
//                         onClick: onClickNo,
//                         textSize: width * 0.035,
//                         leadingIcon: Icon(
//                           Icons.clear,
//                           color: Colors.grey[900],
//                           size: width * 0.045,
//                         ),
//                       ),
//                       ElevatedButtonWidget(
//                         height: hight * 0.04,
//                         minWidth: width * 0.22,
//                         bgColor: Colors.white,
//                         borderSideColor: Colors.grey,
//                         borderRadius: 10.0,
//                         buttonName: 'Yes',
//                         onClick: onClickYes,
//                         textSize: width * 0.035,
//                         leadingIcon: Icon(
//                           Icons.check_circle_outline,
//                           color: Colors.grey[900],
//                           size: width * 0.045,
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               : Container(),
//           preferredSize: Size.fromHeight(4.0)),
//       actions: [
//         IconButton(
//           onPressed: () {
//             calling(context, chatController);
//           },
//           icon: Icon(
//             Icons.phone,
//             color: SpotmiesTheme.onBackground,
//           ),
//         ),
//         IconButton(
//             padding: EdgeInsets.only(bottom: 0),
//             icon: Icon(
//               Icons.more_vert,
//               color: SpotmiesTheme.onBackground,
//             ),
//             onPressed: () {
//               bottomOptionsMenu(
//                 context,
//                 options: options,
//                 menuTitle: "More options",
//                 option2Click: null,
//                 // option3Click: disableChat,
//                 // option4Click: deleteChat
//               );
//             })
//       ],
//       title: InkWell(
//         onTap: () {
//           Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => PartnerDetails(
//                   profileDetails: chatController!.partner,
//                   chatDetails: chatController.targetChat,
//                   msgId: chatController.targetChat['msgId'].toString(),
//                   isMyProfileRevealed: isMyProfileRevealedFunc(chatController),
//                   revealMyProfile: (state) {
//                     revealMyProfile(context, state, chatController,chatProvider,profileProvider);
//                   },
//                   onTapPhone: () {
//                     calling(context, chatController);
//                   })));
//         },
//         child: Row(
//           children: [
//             ProfilePic(
//               name: chatController?.partner['name'] ??
//                   chatController?.defaultName,
//               profile: chatController?.partner['partnerPic'] ?? "",
//               status: false,
//               bgColor: SpotmiesTheme.onBackground,
//               size: width * 0.045,
//             ),
//             SizedBox(
//               width: 8,
//             ),
//             Expanded(
//                 child: TextWid(
//               text: chatController?.partner['name'] ??
//                   chatController?.defaultName,
//               size: width * 0.058,
//               weight: FontWeight.w600,
//               color: SpotmiesTheme.onBackground,
//             )),
//           ],
//         ),
//       ),
//     );
//   }

//   void calling(BuildContext context,ChatController? chatController) {
//     bottomOptionsMenu(context, options: Constants.bottomSheetOptionsForCalling,
//         option1Click: () {
//       launch("tel://${chatController?.partner['phNum']}");
//     }, option2Click: () {
//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => MyCalling(
//                 msgId: chatController?.currentMsgId,
//                 ordId: chatController?.targetChat['ordId'],
//                 uId: FirebaseAuth.instance.currentUser?.uid,
//                 pId: chatController?.targetChat['pId'],
//                 isIncoming: false,
//                 name: chatController?.partner['name'],
//                 profile: chatController?.partner['partnerPic'],
//                 partnerDeviceToken:
//                     chatController?.partner['partnerDeviceToken'].toString(),
//               )));
//     });
//   }



// revealMyProfile(BuildContext context, bool state,ChatController? chatController,ChatProvider chatProvider,UserDetailsProvider? profileProvider) {
//   if (chatController?.targetChat['isNormalChat']) {
//     /* ---------------- Implement reveal profile for normal chat here ---------------- */
//     return;
//   }
//   print("reveal profile $state");
//   sendMessageHandler(context,state ? "user shared profile" : "user disabled Profile",chatController,chatProvider,profileProvider,
//       sender: "bot", action: state ? "enableProfile" : "disableProfile");
//   chatController?.revealProfile(
//       chatController.targetChat, context, chatProvider,
//       revealProfile: state);
// }

// isMyProfileRevealedFunc(ChatController? chatController) {
//   if (chatController?.targetChat['isNormalChat']) return false;
//   log("revela true  ${chatController?.orderDetails['revealProfileTo']}");
//   if (chatController?.orderDetails['revealProfileTo']
//       .contains(chatController.targetChat['pId'])) {
//     log("revela true  ${chatController?.orderDetails['revealProfileTo']}");
//     return true;
//   }
//   log("revela true");
//   return false;
// }


// sendMessageHandler(BuildContext context, value,ChatController? chatController,ChatProvider chatProvider, UserDetailsProvider? profileProvider,{sender: "user", action: ""}) {
//   if (chatController!.isNewChat) {
//     dynamic userDetails = profileProvider?.getUser;
//     return chatController.createNewChat(
//         context,
//         widget.pId!,
//         widget.pDetails!,
//         userDetails['uId'],
//         userDetails['_id'],
//         value,
//         chatProvider,
//         widget.normalChat);
//   }
//   chatController.sendMessageHandler(chatController.currentMsgId, value,
//       context, chatProvider, profileProvider,
//       sender: sender, action: action);
// }

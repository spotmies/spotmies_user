import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:flutter_incall/flutter_incall.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:provider/provider.dart';
import 'package:spotmies/providers/chat_provider.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/views/call_ui/audioCallWithImage/components/body.dart';
import 'package:spotmies/views/internet_calling/signaling.dart';
import 'package:spotmies/views/reusable_widgets/incall.dart';

class MyCalling extends StatefulWidget {
  final String? msgId;
  final dynamic ordId;
  final dynamic uId;
  final dynamic pId;
  final bool isIncoming;
  final dynamic roomId;
  final String? name;
  final String? profile;
  final String? partnerDeviceToken;
  MyCalling(
      {this.msgId,
      required this.pId,
      required this.uId,
      required this.ordId,
      required this.isIncoming,
      this.roomId,
      this.name,
      this.profile,
      this.partnerDeviceToken});
  @override
  _MyCallingState createState() => _MyCallingState();
}

class _MyCallingState extends State<MyCalling> {
  IncallManager incallManager = new IncallManager();
  late ChatProvider chatProvider;
  late UserDetailsProvider _userProvider;
  Signaling signaling = Signaling();
  late RTCVideoRenderer _localRenderer;
  late RTCVideoRenderer _remoteRenderer;
  late String roomId;
  bool timerFlag = true;
  bool callDisconnectFlag = true;
  TextEditingController textEditingController = TextEditingController(text: '');

  Future<void> createRoomId() async {
    await signaling.openUserMedia(_localRenderer, _remoteRenderer, context);
    roomId = await signaling.createRoom(_remoteRenderer);
    chatProvider.setAcceptCall(false);
    log("room is is $roomId");
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, String> msgData = {
      'msg': roomId.toString(),
      'time': timestamp,
      'sender': 'user',
      'type': "call"
    };
    Map<String, dynamic> target = {
      'uId': widget.uId,
      'pId': widget.pId,
      'msgId': widget.msgId ?? "",
      'ordId': widget.ordId,
      'type': 'call',
      'roomId': roomId.toString(),
      'incomingName': _userProvider.getUser['name'],
      'incomingProfile': _userProvider.getUser['pic'],
      'deviceToken': [widget.partnerDeviceToken]
    };
    Map<String, Object> sendPayload = {
      "object": jsonEncode(msgData),
      "target": target,
      "socketName": "sendNewMessageCallback"
    };
    chatProvider.addnewMessage(sendPayload);
    chatProvider.setSendMessage(sendPayload);
    setState(() {});
  }

  Future<void> rejectCall() async {
    log('call rejected');
    chatProvider.resetDuration();
    chatProvider.setAcceptCall(true);
    chatProvider.resetCallInitTimeout();
    chatProvider.setStopTimer();
    chatProvider.setTerminateCall(true);
  }

  Future<void> handUpCall() async {
    chatProvider.setCallStatus(0);
    log("===== handUp call =======");
    await signaling.hangUp(_localRenderer);
    chatProvider.setAcceptCall(true);
    chatProvider.resetCallInitTimeout();
    chatProvider.resetDuration();
    chatProvider.setTerminateCall(true);
  }

  Future<void> joinOnRoom() async {
    await signaling.openUserMedia(_localRenderer, _remoteRenderer, context);
    log("joing call////");
    signaling.joinRoom(
      widget.roomId,
      _remoteRenderer,
    );
    chatProvider.setAcceptCall(false);
  }

  @override
  void initState() {
    log("call initstate >>>>>>>>>>>>>");
    _localRenderer = RTCVideoRenderer();
    _remoteRenderer = RTCVideoRenderer();
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    _userProvider = Provider.of<UserDetailsProvider>(context, listen: false);

    _localRenderer.initialize();
    _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });
    // incallManager.start(
    //     media: MediaType.AUDIO, auto: false, ringback: '_DEFAULT_');
    signaling.openUserMedia(_localRenderer, _remoteRenderer, context);
    if (!widget.isIncoming) {
      incallManager.enableProximitySensor(true);
      incallManager.turnScreenOff();
      incallManager.setMicrophoneMute(false);
      createRoomId();
    } else {
      incallManager.startRingtone(RingtoneUriType.DEFAULT, 'default', 30);
      incallManager.setSpeakerphoneOn(true);
    }
    chatProvider.addListener(() {
      int callState = chatProvider.getCallStatus;
      if (callState == 3 && timerFlag) {
        timerFlag = false;
        chatProvider.startCallDuration();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    log("====== disporse =======");
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    incallManager.enableProximitySensor(false);
    incallManager.turnScreenOn();
    incallManager.setMicrophoneMute(true);
    incallManager.stopRingtone();
    //  chatProvider.setAcceptCall(true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("=========== Render calling ==============");
    return Consumer<ChatProvider>(builder: (context, data, child) {
      if (data.callTimeout == 0) rejectCall();
      // Map pDetails = data.getPdetailsByMsgId(widget.msgId);
      return CallingUi(
        isInComingScreen: widget.isIncoming,
        onHangUp: handUpCall,
        onAccept: () {
          incallManager.stopRingback();
          incallManager.stopRingtone();
          incallManager.enableProximitySensor(true);
          incallManager.turnScreenOff();
          incallManager.setMicrophoneMute(false);
          joinOnRoom();
        },
        onMic: (bool state) {
          log("mic is $state");
          incallManager.setMicrophoneMute(state);
          // log("enabling proxmity");
          // incallManager.turnScreenOff();
          // incallManager.enableProximitySensor(true);
        },
        onReject: () {
          incallManager.enableProximitySensor(false);
          rejectCall();
        },
        onSpeaker: (bool state) {
          log("spelaer is $state");
          incallManager.setSpeakerphoneOn(state);
        },
        name: widget.name ?? "unknown",
        image: widget.profile ?? "",
      );
    });
  }
}

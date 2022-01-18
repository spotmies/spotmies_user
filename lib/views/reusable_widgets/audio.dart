import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:spotmies/controllers/home_controllers/ad_controll.dart';
import 'package:spotmies/utilities/textWidget.dart';

Future audioRecoder(
    BuildContext context, double hight, double width, dynamic adController,
    {String from = "adpost"}) {
  return showModalBottomSheet(
      context: context,
      elevation: 22,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: hight * 0.25,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: FeatureButtonsView(
                      adController: adController,
                      from: from,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      });
}

class FeatureButtonsView extends StatefulWidget {
  final Function? onUploadComplete;
  final dynamic adController;
  final Function? sendCallBack;
  final String? message;
  final String? msgId;
  final String from;
  const FeatureButtonsView(
      {Key? key,
      this.onUploadComplete,
      this.adController,
      this.sendCallBack,
      this.message,
      this.msgId,
      this.from = "adpost"})
      : super(key: key);
  @override
  _FeatureButtonsViewState createState() => _FeatureButtonsViewState();
}

class _FeatureButtonsViewState extends State<FeatureButtonsView> {
  late bool _isPlaying;
  late bool _isUploading;
  late bool _isRecorded;
  late bool _isRecording;

  late AudioPlayer _audioPlayer;
  late String _filePath;

  late FlutterAudioRecorder2 _audioRecorder;

  @override
  void initState() {
    super.initState();
    _isPlaying = false;
    _isUploading = false;
    _isRecorded = false;
    _isRecording = false;
    _audioPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    return Center(
      child: _isRecorded
          ? _isUploading
              ? Container(
                  height: hight * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.indigo[100],
                          color: Colors.indigo[900],
                        ),
                      ),
                      TextWidget(text: 'Sending...'),
                    ],
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  height: hight * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.replay),
                        onPressed: _onRecordAgainButtonPressed,
                      ),
                      IconButton(
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_circle,
                          size: hight * 0.05,
                        ),
                        onPressed: () {
                          _onPlayButtonPressed(widget.message ?? "");
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.done),
                        onPressed: () {
                          switch (widget.from) {
                            case "adpost":
                              widget.adController?.serviceImages
                                  ?.add(File(_filePath));
                              widget.adController?.serviceImagesStrings
                                  ?.add(_filePath);
                              break;
                            case "personalChat":
                              widget.adController
                                  ?.uploadAudioFiles(File(_filePath));
                              // widget.adController.serviceImages
                              //     .add(File(_filePath));
                              break;
                            default:
                              log("please add from");
                              break;
                          }

                          setState(() {});
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                )
          : widget.message == null
              ? Container(
                  height: hight * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextWidget(
                          text: _isRecording
                              ? 'Recording...'
                              : 'Start Recording'),
                      IconButton(
                        icon: _isRecording
                            ? Icon(
                                Icons.pause,
                                size: hight * 0.05,
                              )
                            : Icon(
                                Icons.mic,
                                size: hight * 0.05,
                              ),
                        onPressed: _onRecordButtonPressed,
                      ),
                    ],
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  height: hight * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_circle,
                          size: hight * 0.05,
                        ),
                        onPressed: () {
                          _onPlayButtonPressed(widget.message ?? "");
                        },
                      ),
                      TextWidget(
                        text: _isPlaying
                            ? '    Stop Playing....'
                            : '    Start Playing....',
                      ),
                    ],
                  ),
                ),
    );
  }

  void _onRecordAgainButtonPressed() {
    setState(() {
      _isRecorded = false;
    });
  }

  Future<void> _onRecordButtonPressed() async {
    if (_isRecording) {
      _audioRecorder.stop();
      _isRecording = false;
      _isRecorded = true;
    } else {
      _isRecorded = false;
      _isRecording = true;

      await _startRecording();
    }
    setState(() {});
  }

  void _onPlayButtonPressed(String message) {
    if (!_isPlaying) {
      _isPlaying = true;

      _audioPlayer.play(message == null ? _filePath : message, isLocal: true);
      _audioPlayer.onPlayerCompletion.listen((duration) {
        setState(() {
          _isPlaying = false;
        });
      });
    } else {
      _audioPlayer.pause();
      _isPlaying = false;
    }
    setState(() {});
  }

  Future<void> _startRecording() async {
    final bool? hasRecordingPermission =
        await FlutterAudioRecorder2.hasPermissions;

    if (hasRecordingPermission ?? false) {
      Directory directory = await getApplicationDocumentsDirectory();
      String filepath = directory.path +
          '/' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          '.aac';
      _audioRecorder =
          FlutterAudioRecorder2(filepath, audioFormat: AudioFormat.AAC);
      await _audioRecorder.initialized;
      _audioRecorder.start();
      _filePath = filepath;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(child: Text('Please enable recording permission'))));
    }
  }
}






//Future _onUploadComplete() async {
// FirebaseStorage firebaseStorage = FirebaseStorage.instance;
// ListResult listResult =
//     await firebaseStorage.ref().child('upload-voice-firebase').list();
// setState(() {
// var references = listResult.items;
// chatController.refresh();
//});
//}

// class HomeView extends StatefulWidget {
//   @override
//   _HomeViewState createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   List<Reference> references = [];

//   @override
//   void initState() {
//     super.initState();
//     _onUploadComplete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             Expanded(
//               flex: 4,
//               child: references.isEmpty
//                   ? Center(
//                       child: Text('No File uploaded yet'),
//                     )
//                   : CloudRecordListView(
//                       references: references,
//                     ),
//             ),
//             Expanded(
//               flex: 2,
//               child: FeatureButtonsView(
//                 onUploadComplete: _onUploadComplete,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _onUploadComplete() async {
//     FirebaseStorage firebaseStorage = FirebaseStorage.instance;
//     ListResult listResult =
//         await firebaseStorage.ref().child('upload-voice-firebase').list();
//     setState(() {
//       references = listResult.items;
//     });
//   }
// }

// class CloudRecordListView extends StatefulWidget {
//   final List<Reference> references;
//   const CloudRecordListView({
//     Key key,
//     @required this.references,
//   }) : super(key: key);

//   @override
//   _CloudRecordListViewState createState() => _CloudRecordListViewState();
// }

// class _CloudRecordListViewState extends State<CloudRecordListView> {
//   bool isPlaying;
//   `  ` audioPlayer;
//   int selectedIndex;

//   @override
//   void initState() {
//     super.initState();
//     isPlaying = false;
//     audioPlayer = AudioPlayer();
//     selectedIndex = -1;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: widget.references.length,
//       reverse: true,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           title: Text(widget.references.elementAt(index).name),
//           trailing: IconButton(
//             icon: selectedIndex == index
//                 ? Icon(Icons.pause)
//                 : Icon(Icons.play_arrow),
//             onPressed: () => _onListTileButtonPressed(index),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _onListTileButtonPressed(int index) async {
//     setState(() {
//       selectedIndex = index;
//     });
//     audioPlayer.play(await widget.references.elementAt(index).getDownloadURL(),
//         isLocal: false);

//     audioPlayer.onPlayerCompletion.listen((duration) {
//       setState(() {
//         selectedIndex = -1;
//       });
//     });
//   }
// }













// Future _onFileUploadButtonPressed() async {
  //   FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  //   setState(() {
  //     widget.chatController.uploading;
  //   });
  //   try {
  //     await firebaseStorage
  //         .ref('upload-voice-firebase')
  //         .child(
  //             _filePath.substring(_filePath.lastIndexOf('/'), _filePath.length))
  //         .putFile(File(_filePath));
  //     widget.onUploadComplete();
  //   } catch (error) {
  //     print('Error occured while uplaoding to Firebase ${error.toString()}');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error occured while uplaoding'),
  //       ),
  //     );
  //   } finally {
  //     setState(() {
  //       widget.chatController.uploading;
  //     });
  //   }
  // }







// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';
// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:spotmies_partner/controllers/chat_controller.dart';
// import 'package:spotmies_partner/reusable_widgets/elevatedButtonWidget.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:intl/intl.dart' show DateFormat;
// import 'package:path/path.dart' as path;



// class AudioRecorder extends StatefulWidget {
//   const AudioRecorder({ Key key}) : super(key: key);

//   @override
//   _AudioRecorderState createState() => _AudioRecorderState();
// }

// class _AudioRecorderState extends State<AudioRecorder> {
//    FlutterSoundRecorder _myRecorder;
//   final audioPlayer = AssetsAudioPlayer();
//   String filePath;
//   bool _play = false;
//   String _recorderTxt = '00:00:00';

//   @override
//   void initState() {
//     super.initState();
//     startIt();
//   }

//   void startIt() async {
//     filePath = '/sdcard/Download/temp.wav';
//     _myRecorder = FlutterSoundRecorder();

//     await _myRecorder.openAudioSession(
//         focus: AudioFocus.requestFocusAndStopOthers,
//         category: SessionCategory.playAndRecord,
//         mode: SessionMode.modeDefault,
//         device: AudioDevice.speaker);
//     await _myRecorder.setSubscriptionDuration(Duration(milliseconds: 10));
//     await initializeDateFormatting();

//     await Permission.microphone.request();
//     await Permission.storage.request();
//     await Permission.manageExternalStorage.request();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               height: 400.0,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Color.fromARGB(255, 2, 199, 226), Color.fromARGB(255, 6, 75, 210)],
//                 ),
//                 borderRadius: BorderRadius.vertical(
//                   bottom: Radius.elliptical(MediaQuery.of(context).size.width, 100.0),
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   _recorderTxt,
//                   style: TextStyle(fontSize: 70),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 buildElevatedButton(
//                   icon: Icons.mic,
//                   iconColor: Colors.red,
//                   f: record,
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 buildElevatedButton(
//                   icon: Icons.stop,
//                   iconColor: Colors.black,
//                   f: stopRecord,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 buildElevatedButton(
//                   icon: Icons.play_arrow,
//                   iconColor: Colors.black,
//                   f: startPlaying,
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 buildElevatedButton(
//                   icon: Icons.stop,
//                   iconColor: Colors.black,
//                   f: stopPlaying,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 elevation: 10.0,
//               ),
//               onPressed: () {
//                 setState(() {
//                   _play = !_play;
//                 });
//                 if (_play) startPlaying();
//                 if (!_play) stopPlaying();
//               },
//               icon: _play
//                   ? Icon(
//                       Icons.stop,
//                     )
//                   : Icon(Icons.play_arrow),
//               label: _play
//                   ? Text(
//                       "Stop Playing",
//                       style: TextStyle(
//                         fontSize: 25,
//                       ),
//                     )
//                   : Text(
//                       "Start Playing",
//                       style: TextStyle(
//                         fontSize: 25,
//                       ),
//                     ),
//             ),
//           ],
//         ),
//       );
//   }
//   ElevatedButton buildElevatedButton({IconData icon, Color iconColor, Function f}) {
//     return ElevatedButton.icon(
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.all(5.0),
//         side: BorderSide(
//           color: Colors.orange,
//           width: 3.0,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         primary: Colors.white,
//         elevation: 10.0,
//       ),
//       onPressed: f,
//       icon: Icon(
//         icon,
//         color: iconColor,
//         size: 35.0,
//       ),
//       label: Text(''),
//     );
//   }

//   Future<void> record() async {
//     Directory dir = Directory(path.dirname(filePath));
//     if (!dir.existsSync()) {
//       dir.createSync();
//     }
//     _myRecorder.openAudioSession();
//     await _myRecorder.startRecorder(
//       toFile: filePath,
//       codec: Codec.pcm16WAV,
//     );

//     StreamSubscription _recorderSubscription = _myRecorder.onProgress.listen((e) {
//       var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds, isUtc: true);
//       var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);

//       setState(() {
//         _recorderTxt = txt.substring(0, 8);
//       });
//     });
//     _recorderSubscription.cancel();
//   }

//   Future<String> stopRecord() async {
//     _myRecorder.closeAudioSession();
//     return await _myRecorder.stopRecorder();
//   }

//   Future<void> startPlaying() async {
//     audioPlayer.open(
//       Audio.file(filePath),
//       autoStart: true,
//       showNotification: true,
//     );
//   }

//   Future<void> stopPlaying() async {
//     audioPlayer.stop();
//   }
// }





// // final pathToSaveAudio = DateTime.now().millisecondsSinceEpoch.toString();

// // class SoundRecorder {
// //   FlutterSoundRecorder audioRecorder;
// //   bool isRecordedInitied = false;
// //   bool get isRecording => audioRecorder.isRecording;

// //   Future init() async {
// //     audioRecorder = FlutterSoundRecorder();
// //     final status = await Permission.microphone.request();
// //     if (status != PermissionStatus.granted) {
// //       log('Not permitted');
// //     }
// //     await audioRecorder.openAudioSession();
// //      isRecordedInitied = true;
// //     return audioRecorder.recorderState;
   
// //   }

// //   Future dispose() async {
// //     if (!isRecordedInitied) return;
// //     audioRecorder.closeAudioSession();
// //     audioRecorder = null;
// //     isRecordedInitied = false;
// //   }

// //   Future startRecord() async {
// //     if (!isRecordedInitied) return;
// //     await audioRecorder.startRecorder(toFile: pathToSaveAudio);
    
// //     return audioRecorder.recorderState;
// //   }

// //   Future stopRecord() async {
// //     if (!isRecordedInitied) return;
// //     await audioRecorder.stopRecorder();
   
// //     return audioRecorder.recorderState;
// //   }

// //   Future toggleRecording() async {
// //     if (audioRecorder.isStopped) {
// //       await startRecord();
// //     } else {
// //       await stopRecord();
// //     }
// //   }
// // }

// // Future audioRecoder(BuildContext context, double hight, double width,
// //     SoundRecorder recorder, ChatController chatController) {
// //   final isRecording = recorder.isRecording;
// //   final icon = isRecording ? Icons.stop : Icons.mic;
// //   final text = isRecording ? 'Stop' : 'Start';
// //   final color = isRecording ? Colors.white : Colors.black;
// //   final textColor = isRecording ? Colors.black : Colors.white;
// //   return showModalBottomSheet(
// //       context: context,
// //       elevation: 22,
// //       isScrollControlled: true,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.vertical(
// //           top: Radius.circular(20),
// //         ),
// //       ),
// //       builder: (BuildContext context) {
// //         return Container(
// //           height: hight * 0.5,
// //           child: Column(
// //             children: [
// //               Row(
// //                 children: [
// //                   ElevatedButtonWidget(
// //                     onClick: () async {
// //                       var isRecording = await SoundRecorder().toggleRecording();
// //                       // log(isRecording.toString());
// //                       //     .catchError((e) {
// //                       //   log(e);
// //                       // });
// //                       chatController.refresh();
// //                     },
// //                     buttonName: text,
// //                     leadingIcon: Icon(icon),
// //                     minWidth: width * 0.35,
// //                     height: hight * 0.06,
// //                     bgColor: color,
// //                     textColor: textColor,
// //                   ),
// //                 ],
// //               )
// //             ],
// //           ),
// //         );
// //       });
// // }

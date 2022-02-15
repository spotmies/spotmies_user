import 'package:flutter/material.dart';

class Constants {
  static var jobCategories = [
    "Ac/Refrigirator Service",
    "Computer/Laptop Service",
    "Tv Repair",
    "Development",
    "Tutor",
    "Beauty",
    "Photographer",
    "Driver",
    "Events",
    "Electrician",
    "Carpenter",
    "Plumber",
    "Interior Design",
    "Design",
    "CC Tv Installation",
    "Catering",
  ];

  static var jobCategoriesSmall = [
    "Ac/Fridge Service",
    "Computer Service",
    "Tv Repair",
    "Development",
    "Tutor",
    "Beauty",
    "Photographer",
    "Driver",
    "Events",
    "Electrician",
    "Carpenter",
    "Plumber",
    "Interior Design",
    "Design",
    "CC Tv Installation",
    "Catering",
  ];
  static List<Map<String, Object>> bottomSheetOptionsForCalling = [
    {"name": "Normal call", "icon": Icons.phone},
    {"name": "Spotmies call", "icon": Icons.wifi_calling_3},
  ];
}

orderStateString({ordState = 0}) {
  int orderState =
      ordState.runtimeType == String ? int.parse(ordState) : ordState;
  switch (orderState) {
    case 0:
      return "Service Request by You";
    case 1:
      return "There is no partner available for this Service please try again later";
    case 2:
      return "You updated your Service updated";
    case 3:
      return "Service cancelled by You";
    case 4:
      return "Service cancelled by Partner";
    case 5:
      return "Something went wrong";
    case 6:
      return "There is not value for this string";
    case 7:
      return "Service reshedule by the You";
    case 8:
      return "Service is Ongoing";
    case 9:
      return "Service completed";
    case 10:
      return "Order completed";

    default:
      return "Something went wrong";
  }
}

orderStateIcon({ordState = 0}) {
  int orderState =
      ordState.runtimeType == String ? int.parse(ordState) : ordState;
  switch (orderState) {
    case 0:
      return Icons.pending_actions;

    case 1:
      return Icons.stop_circle;

    case 2:
      return Icons.update;

    case 8:
      return Icons.run_circle_rounded;

    case 9:
    case 10:
      return Icons.verified_rounded;

    case 3:
      return Icons.cancel;

    default:
      return Icons.search;
  }
}

checkFileType(String target) {
  List<String> imageFormats = ["jpg", "png", "jpeg"];
  List<String> videoFormats = ["mp4", "mvc"];
  List<String> audioFormats = ["aac", "mp3"];

  List mediaArray = [imageFormats, videoFormats, audioFormats];
  for (int i = 0; i < mediaArray.length; i++) {
    for (int j = 0; j < mediaArray[i].length; j++) {
      if (target.contains(mediaArray[i][j])) {
        if (i == 0)
          return "image";
        else if (i == 1)
          return "video";
        else
          return "audio";
      }
    }
  }
  return "undefined";
}

messageColorTheme(String sender) {
  switch (sender) {
    case "user":
      return [
        Colors.blueGrey[500],
        Colors.grey[50]
      ]; //background is index - 0 && text color is index - 1

    case "partner":
      return [Colors.white, Colors.grey[800]];

    case "bot":
      return [Colors.grey[50], Colors.grey[900]];
    default:
      return [Colors.grey[900], Colors.grey[50]];
  }
}

typeofLastMessage(String type, String lastMessage, String data) {
  if (data != 'icon') {
    switch (type) {
      case 'text':
        return lastMessage;

      case 'img':
        return 'Image File';

      case 'video':
        return 'Video File';

      case 'audio':
        return 'Audio File';

      case "call":
        return "call";
      default:
        return 'Unknown';
    }
  } else {
    switch (type) {
      case 'text':
        return Icons.textsms;

      case 'img':
        return Icons.image;

      case 'video':
        return Icons.slow_motion_video;

      case 'audio':
        return Icons.mic;
      case 'call':
        return Icons.call;
      default:
        return Icons.connect_without_contact;
    }
  }
}

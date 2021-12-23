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
      break;
    case 1:
      return Icons.stop_circle;
      break;
    case 2:
      return Icons.update;
      break;
    case 8:
      return Icons.run_circle_rounded;
      break;
    case 9:
    case 10:
      return Icons.verified_rounded;
      break;
    case 3:
      return Icons.cancel;
      break;
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
      return [Colors.grey[900], Colors.grey[50]];
    default:
      return [Colors.grey[900], Colors.grey[50]];
      break;
  }
}

typeofLastMessage(String type, String lastMessage, String data) {
  if (data != 'icon') {
    switch (type) {
      case 'text':
        return lastMessage;
        break;
      case 'img':
        return 'Image File';
        break;
      case 'video':
        return 'Video File';
        break;
      case 'audio':
        return 'Audio File';
        break;
      case "call":
        return "call";
      default:
        return 'Unknown';
    }
  } else {
    switch (type) {
      case 'text':
        return Icons.textsms;
        break;
      case 'img':
        return Icons.image;
        break;
      case 'video':
        return Icons.slow_motion_video;
        break;
      case 'audio':
        return Icons.mic;
        break;
      case 'call':
        return Icons.call;
      default:
        return Icons.connect_without_contact;
    }
  }
}

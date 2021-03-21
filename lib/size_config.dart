import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  //var format = formatDate(DateTime(1989, 02, 21), [yyyy, '-', mm, '-', dd]);
  //var format =   DateFormat('HH:mm a');
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = formatDate(date, [HH, ':', mm]);// format.format(date);
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + ' Gün';
    } else {
      time = diff.inDays.toString() + ' Gün';
    }
  } else {
    if (diff.inDays == 7) {
      time = (diff.inDays / 7).floor().toString() + ' Hafta';
    } else {
      time = (diff.inDays / 7).floor().toString() + ' Hafta';
    }
  }

  return time;
}

String readDateTime(DateTime dateTime) {
  var now = DateTime.now();
  //var format = DateFormat('HH:mm');
  var diff = now.difference(dateTime);
  var time = '';

  if (dateTime.day != now.day && dateTime.day+1 == now.day) {
    time = "Dün " + formatDate(dateTime, [HH, ':', mm]);
  } else if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = formatDate(dateTime, [HH, ':', mm]);
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + ' Gün';
    } else {
      time = diff.inDays.toString() + ' Gün';
    }
  }
  //else {
  //   if (diff.inDays == 7) {
  //     time = (diff.inDays / 7).floor().toString() + ' Hafta';
  //   } else {

  //     time = (diff.inDays / 7).floor().toString() + ' Hafta';
  //   }
  // }

  return time;
}

import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import 'package:otsappmobile/constants.dart';

class NotificationService {
  NotificationService._();

  factory NotificationService() => _instance;

  static final NotificationService _instance = NotificationService._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;
  Client client = Client();

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(
          onMessage: (Map<String, dynamic> response) async {
        print("onMessage: $response");
      }, onLaunch: (Map<String, dynamic> response) async {
        print("onLaunch: $response");
      }, onResume: (Map<String, dynamic> response) async {
        print("onResume: $response");
      });

      sNotifToken = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $sNotifToken");

      _initialized = true;
    }
  }

  pushNotification(String token, String title, String message,
      {String imageUrl}) async {
    Data nData = Data(body: message, title: title);
    Notification nNotif = Notification(body: message, title: title);
    if (imageUrl != null) nNotif.image = imageUrl;
    NotificationModel model =
        NotificationModel(data: nData, notification: nNotif, to: token);
    await client.post(
      "https://fcm.googleapis.com/fcm/send",
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "key=" + fcmServerKey
      },
      body: (notificationModelToJson(model)),
    );
  }
}

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.to,
    this.notification,
    this.data,
  });

  String to;
  Notification notification;
  Data data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        to: json["to"],
        notification: Notification.fromJson(json["notification"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "to": to,
        "notification": notification.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.body,
    this.title,
  });

  String body;
  String title;
  String clickAction = "FLUTTER_NOTIFICATION_CLICK";

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        body: json["body"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "title": title,
        "click_action": clickAction,
      };
}

class Notification {
  Notification({this.body, this.title, this.image});

  String body;
  String title;
  String image;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
      body: json["body"], title: json["title"], image: json["image"]);

  Map<String, dynamic> toJson() => {
        "body": body,
        "title": title,
        "image": image,
        "color":"#FF7643",
      };
}

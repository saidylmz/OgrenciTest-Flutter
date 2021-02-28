import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/components/bottom_navigation_bar.dart';
import 'package:otsappmobile/constants.dart';
import 'package:otsappmobile/controllers/MessageController.dart';
import 'package:otsappmobile/services/firestore_service.dart';

import 'components/body.dart';

List<dynamic> friendList = [];

class MessageScreen extends StatefulWidget {
  static String routeName = "/messages";

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends StateMVC<MessageScreen> {
  _MessageScreenState() : super(MessageController()) {
    _controller = controller;
  }
  MessageController _controller;

  @override
  void initState() {
    FirestoreService().saveUserIsNotExist("Sercan", "https://i.stack.imgur.com/l60Hf.png");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mesajlarım"),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: kPrimaryColor),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Yeni",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        body: Body(controller: _controller),
        bottomNavigationBar: BottomNavigatonBar(
          activeIndex: 3,
        ));
  }
}

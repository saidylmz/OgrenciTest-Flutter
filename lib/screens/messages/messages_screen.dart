import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/components/bottom_navigation_bar.dart';
import 'package:otsappmobile/controllers/MessagesController.dart';

import 'components/body.dart';

class MessagesScreen extends StatefulWidget {
  static String routeName = "/messages";

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends StateMVC<MessagesScreen> {
  _MessagesScreenState() : super(MessagesController()) {
    _controller = controller;
  }
  MessagesController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mesajlarım"),
        centerTitle: true,
      ),
      body: Body(controller: _controller),
       bottomNavigationBar: BottomNavigatonBar(
        activeIndex: 3,
      )
    );
  }
}

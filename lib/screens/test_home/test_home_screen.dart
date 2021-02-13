import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/controllers/TestHomeController.dart';
import '../../components/bottom_navigation_bar.dart';

import 'components/body.dart';

class TestHomeScreen extends StatefulWidget {
  static String routeName = "/testhome";

  @override
  _TestHomeScreenState createState() => _TestHomeScreenState();
}

class _TestHomeScreenState extends StateMVC<TestHomeScreen> {
  _TestHomeScreenState() : super(TestHomeController()) {
    _controller = controller;
  }
  TestHomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Testlerim"),
        centerTitle: true,
      ),
      body: Body(controller: _controller),
      bottomNavigationBar: BottomNavigatonBar(
        activeIndex: 2,
      ),
    );
  }
}

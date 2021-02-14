import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/controllers/HomeController.dart';

import '../../components/bottom_navigation_bar.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends StateMVC<HomeScreen> {
  _HomeScreenState() : super(HomeController()) {
    _controller = controller;
  }
  HomeController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(controller: _controller),
      bottomNavigationBar: BottomNavigatonBar(
        activeIndex: 0,
      ),
    );
  }
}

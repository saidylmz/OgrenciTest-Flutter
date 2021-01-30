import 'package:flutter/material.dart';
import 'package:otsappmobile/components/bottom_navigation_bar.dart';

import 'components/body.dart';

class TestHomeScreen extends StatelessWidget {
  static String routeName = "/testhome";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Testlerim"),
        centerTitle: true,
      ),
      body: Body(),
      bottomNavigationBar: BottomNavigatonBar(
        activeIndex: 2,
      ),
    );
  }
}

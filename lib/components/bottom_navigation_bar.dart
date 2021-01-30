import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:otsappmobile/screens/test_home/test_home_screen.dart';

import '../constants.dart';

class BottomNavigatonBar extends StatelessWidget {
  const BottomNavigatonBar({
    Key key, this.activeIndex,
  }) : super(key: key);
  final int activeIndex;
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      backgroundColor: kPrimaryColor,
      color: kPrimaryLightColor,
      activeColor: Colors.red[900],
      style: TabStyle.fixedCircle,
      items: [
        TabItem(icon: Icons.home_outlined, activeIcon: Icons.home),
        TabItem(icon: Icons.queue_sharp),
        TabItem(icon: Icons.post_add_outlined, activeIcon: Icons.post_add),
        TabItem(activeIcon: Icons.mail, icon: Icons.mail_outline_outlined),
        TabItem(activeIcon: Icons.person, icon: Icons.person_outlined),
      ],
      onTap: (index) {
        switch (index) {
          case 2:
            Navigator.pushNamed(context, TestHomeScreen.routeName);
            break;
          default:
        }
      },
      initialActiveIndex: activeIndex,
    );
  }
}

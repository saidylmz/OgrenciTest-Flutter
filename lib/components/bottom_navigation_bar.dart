import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:otsappmobile/screens/home/home_screen.dart';
import 'package:otsappmobile/screens/message/message_screen.dart';
import 'package:otsappmobile/screens/profile/profile_screen.dart';
import 'package:otsappmobile/screens/scoreboard/scoreboard_screen.dart';
import '../screens/test_home/test_home_screen.dart';

import '../constants.dart';

class BottomNavigatonBar extends StatelessWidget {
  const BottomNavigatonBar({
    Key key,
    this.activeIndex,
  }) : super(key: key);
  final int activeIndex;
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      initialActiveIndex: activeIndex,
      backgroundColor: kPrimaryColor,
      color: kPrimaryLightColor,
      activeColor: Colors.red[900],
      onTabNotify: (value) {
        if (value == activeIndex) return false;
        switch (value) {
          case 0:
            Navigator.pushNamed(context, HomeScreen.routeName);
            break;
          case 1:
            Navigator.pushNamed(context, ScoreBoardScreen.routeName);
            break;
          case 2:
            Navigator.pushNamed(context, TestHomeScreen.routeName);
            break;
          case 3:
            Navigator.pushNamed(context, MessageScreen.routeName);
            break;
          case 4:
            Navigator.pushNamed(context, ProfileScreen.routeName);
            break;
        }
        return false;
      },
      style: TabStyle.fixedCircle,
      items: [
        TabItem(icon: Icons.home_outlined, activeIcon: Icons.home),
        TabItem(icon: Image.asset("assets/images/trophywhite.png", color: kPrimaryLightColor,), activeIcon: Image.asset("assets/images/trophyblack.png", color: Colors.red[900],)),
        TabItem(icon: Icons.post_add_outlined, activeIcon: Icons.post_add),
        TabItem(activeIcon: Icons.mail, icon: Icons.mail_outline_outlined),
        TabItem(activeIcon: Icons.person, icon: Icons.person_outlined),
      ],
    );
  }
}

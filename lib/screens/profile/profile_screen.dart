import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/components/bottom_navigation_bar.dart';
import 'package:otsappmobile/constants.dart';
import 'package:otsappmobile/controllers/ProfileController.dart';
import 'package:otsappmobile/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/body.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends StateMVC<ProfileScreen> {
  _ProfileScreenState() : super(ProfileController()) {
    _controller = controller;
  }
  ProfileController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: GestureDetector(
              onTap: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("email");
                prefs.remove('password');
                sToken = "";
                sUserID = 0;
                sExpiration = DateTime.now();
                sUser = null;
                Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
              },
              child: Icon(Icons.logout),
            ),
          ),
        ],
        title: Text(
          "Profil",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      bottomNavigationBar: BottomNavigatonBar(activeIndex: 4),
      body: Body(controller: _controller),
    );
  }
}

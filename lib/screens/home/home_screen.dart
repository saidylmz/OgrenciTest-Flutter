import 'package:flutter/material.dart';
import 'package:otsappmobile/components/bottom_navigation_bar.dart';
import 'package:otsappmobile/components/default_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Anasayfa"),
        centerTitle: true,
      ),
      body: DefaultButton(
        text: "Temizle",
        press: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove("email");
          prefs.remove("password");
        },
      ),
      bottomNavigationBar: BottomNavigatonBar(
        activeIndex: 0,
      ),
    );
  }
}

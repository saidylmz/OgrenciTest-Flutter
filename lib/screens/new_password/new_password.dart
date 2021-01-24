import 'package:flutter/material.dart';

import 'components/body.dart';

class NewPasswordScreen extends StatelessWidget {
  static String routeName = "/newpassword";
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Şifre"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controllers/NewPasswordController.dart';

import 'components/body.dart';

class NewPasswordScreen extends StatefulWidget {
  static String routeName = "/newpassword";

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends StateMVC<NewPasswordScreen> {
  _NewPasswordScreenState() : super(NewPasswordController()) {
    _controller = controller;
  }
  NewPasswordController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Şifre"),
        centerTitle: true,
      ),
      body: Body(controller: _controller),
    );
  }
}

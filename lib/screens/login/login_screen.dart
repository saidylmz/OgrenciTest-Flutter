import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controllers/LoginController.dart';

import 'components/body.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends StateMVC<LoginScreen> {
   _LoginScreenState() : super(LoginController()) {
    _controller = controller;
  }
  LoginController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş"),
        centerTitle: true,
      ),
      body: Body(controller: _controller),
    );
  }
}

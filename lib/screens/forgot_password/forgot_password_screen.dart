import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controllers/ForgotPasswordController.dart';

import 'components/body.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String routeName = "/forgotpassword"; 

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends StateMVC<ForgotPasswordScreen> {
  _ForgotPasswordScreenState() : super(ForgotPasswordController()) {
    _controller = controller;
  }
  ForgotPasswordController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Şifremi Unuttum"), centerTitle: true),
      body: Body(controller: _controller),
    );
  }
}

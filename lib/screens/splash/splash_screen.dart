import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../screens/splash/components/body.dart';
import '../../size_config.dart';
import '../../controllers/SplashController.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends StateMVC<SplashScreen> {
  _SplashScreenState() : super(SplashController()) {
    _controller = controller;
  }
  SplashController _controller;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(
       SystemUiOverlayStyle(
         statusBarColor: Colors.transparent,
         statusBarIconBrightness: Brightness.dark
      )
  );
    return Scaffold(
      body: Body(controller: _controller),
    );
  }
}
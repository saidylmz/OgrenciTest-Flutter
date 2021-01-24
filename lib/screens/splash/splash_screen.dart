import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otsappmobile/screens/splash/components/body.dart';
import 'package:otsappmobile/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
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
      body: Body(),
    );
  }
}
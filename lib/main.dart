import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/routes.dart';
import 'package:otsappmobile/screens/splash/splash_screen.dart';

import 'constants.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends AppMVC {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppName,
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}



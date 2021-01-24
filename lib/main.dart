import 'package:flutter/material.dart';
import 'package:otsappmobile/routes.dart';
import 'package:otsappmobile/screens/splash/splash_screen.dart';

import 'constants.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppName,
      theme: theme(),
      //home: SplashScreen(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}



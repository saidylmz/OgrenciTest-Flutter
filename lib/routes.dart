import 'package:flutter/widgets.dart';
import 'package:otsappmobile/screens/forgot_password/forgot_password_screen.dart';
import 'package:otsappmobile/screens/home/home_screen.dart';
import 'package:otsappmobile/screens/login/login_screen.dart';
import 'package:otsappmobile/screens/new_password/new_password.dart';
import 'package:otsappmobile/screens/splash/splash_screen.dart';
import 'package:otsappmobile/screens/test_detail/test_detail_screen.dart';
import 'package:otsappmobile/screens/test_home/test_home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  NewPasswordScreen.routeName: (context) => NewPasswordScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  TestHomeScreen.routeName: (context) => TestHomeScreen(),
  TestDetailScreen.routeName: (context) => TestDetailScreen(),
};
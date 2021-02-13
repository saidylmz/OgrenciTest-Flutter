import 'package:flutter/widgets.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/new_password/new_password.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/test_detail/test_detail_screen.dart';
import 'screens/test_home/test_home_screen.dart';
import 'screens/test_question/test_question_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  NewPasswordScreen.routeName: (context) => NewPasswordScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  TestHomeScreen.routeName: (context) => TestHomeScreen(),
  TestDetailScreen.routeName: (context) => TestDetailScreen(),
  TestQuestionScreen.routeName: (context) => TestQuestionScreen(),
};
import 'package:flutter/widgets.dart';
import 'package:otsappmobile/screens/message/message_screen.dart';
import 'package:otsappmobile/screens/message_detail/message_detail_screen.dart';
import 'package:otsappmobile/screens/scoreboard/scoreboard_screen.dart';
import 'package:otsappmobile/screens/test_answers/test_answers_screen.dart';
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
  TestAnswersScreen.routeName: (context) => TestAnswersScreen(),
  MessageScreen.routeName: (context) => MessageScreen(),
  MessageDetailScreen.routeName: (context) => MessageDetailScreen(),
  ScoreBoardScreen.routeName: (context) => ScoreBoardScreen(),
};
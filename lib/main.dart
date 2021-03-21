import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/routes.dart';
import 'package:otsappmobile/screens/splash/splash_screen.dart';
import 'package:otsappmobile/services/notification_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'constants.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService().init();
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr', 'TR'), // include country code too
      ],
    );
  }
}

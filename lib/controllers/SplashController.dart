import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/screens/splash/splash_screen.dart';
import '../models/login_model.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class SplashController extends ControllerMVC {
  SplashController([StateMVC state]) : super(state) {
    if (sExpiration == null || sExpiration.isBefore(DateTime.now()))
      _stateLogin().then((value) {
        stateLogin = value;
      });
  }

  Future<int> _stateLogin() async => await autoLogin();

  int stateLogin = 0, currentPage = 0;

  List<Map<String, String>> splashData = [
    {
      "text":
          "Test istatistiklerini görebileceğin ana sayfa ekranı.",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
          "Çözdüğün ve çözmeni bekleyen testlerin listesi. Günlük, haftalık, toplam soru istatistiği.",
      "image": "assets/images/splash_2.png"
    },
    {
      "text":
          "Test Çözüm Ekranı",
      "image": "assets/images/splash_3.png"
    },
    {
      "text":
          "Soru sorabileceğin, sohbet edebileceğin canlı sohbet sistemi.",
      "image": "assets/images/splash_4.png"
    },
  ];

  String getSplashData(int index, String name) => splashData[index][name];

  void changePage(int newPage) => setState(() => currentPage = newPage);

  checkConnection(BuildContext context, bool redirect) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty || result[0].rawAddress.isEmpty) {
        stateLogin = 3;
        AwesomeDialog(
          context: context,
          title: "İnternet Bağlantısı",
          dialogType: DialogType.ERROR,
          desc: "İnternet bağlantısı başarısız. Lütfen kontrol ediniz.",
          btnOkText: "Tamam",
          btnOkOnPress: () {},
        )..show();
      } else if (redirect) {
        Navigator.pushNamedAndRemoveUntil(
            context, SplashScreen.routeName, (route) => false);
      }
    } on SocketException catch (_) {
      stateLogin = 3;
      AwesomeDialog(
          context: context,
          title: "İnternet Bağlantısı",
          dialogType: DialogType.ERROR,
          desc: "İnternet bağlantısı başarısız. Lütfen kontrol ediniz.",
          btnOkText: "Tamam",
          btnOkOnPress: () {},
        )..show();
    }
  }
}

Future<int> autoLogin() async {
  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _sprefs;
  String email = (prefs.getString('email'));
  String password = (prefs.getString('password'));

  if (email != null &&
      email.isNotEmpty &&
      password != null &&
      password.isNotEmpty) {
    LoginModel loginModel = await AuthService().login(email, password);
    if (loginModel.error.isEmpty) {
      sToken = loginModel.token;
      sUserID = loginModel.userId;
      sExpiration = loginModel.expiration;
      sUser = await UserService().getUserById(sUserID);
      return 2;
    }
  }
  return 1;
}

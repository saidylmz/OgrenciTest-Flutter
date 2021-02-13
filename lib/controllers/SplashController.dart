import 'package:mvc_pattern/mvc_pattern.dart';
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
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "image": "assets/images/splash_2.png"
    },
    {
      "text":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "image": "assets/images/splash_3.png"
    },
  ];

  String getSplashData(int index, String name) => splashData[index][name];

  void changePage(int newPage) => setState(() => currentPage = newPage);
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

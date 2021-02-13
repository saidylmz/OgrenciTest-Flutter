import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import '../models/login_model.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class LoginController extends ControllerMVC {
  LoginController([StateMVC state]) : super(state);

  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];
  final formKey = GlobalKey<FormState>();

  void setRemember(bool value) => setState(() => remember = value);

  void addError(String error) => setState(() => errors.add(error));
  void removeError(String error) => setState(() => errors.remove(error));

  Future<bool> pressedLogin() async {
    setState(() {
      errors.removeRange(0, errors.length);
    });
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      LoginModel loginModel = await AuthService().login(email, password);
      if (loginModel.error.isNotEmpty && !errors.contains(loginModel.error)) {
        setState(() {
          errors.add(loginModel.error);
        });
      } else if (loginModel.error.isEmpty) {
        if (remember) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', email);
          prefs.setString('password', password);
        }
        sToken = loginModel.token;
        sUserID = loginModel.userId;
        sExpiration = loginModel.expiration;
        sUser = await UserService().getUserById(sUserID);
        return true;
      }
    }
    return false;
  }

  // Future<int> _stateLogin() async => await autoLogin();

  // int stateLogin = 0, currentPage = 0;

  // List<Map<String, String>> splashData = [
  //   {
  //     "text":
  //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  //     "image": "assets/images/splash_1.png"
  //   },
  //   {
  //     "text":
  //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  //     "image": "assets/images/splash_2.png"
  //   },
  //   {
  //     "text":
  //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  //     "image": "assets/images/splash_3.png"
  //   },
  // ];

  // String getSplashData(int index, String name) => splashData[index][name];

  // void changePage(int newPage) => setState(() => currentPage = newPage);
}

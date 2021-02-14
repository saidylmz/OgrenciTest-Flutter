import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/models/user_statistic_model.dart';
import 'package:otsappmobile/services/user_service.dart';

class HomeController extends ControllerMVC {
  HomeController([StateMVC state]) : super(state) {
    UserService().getUserStatistic().then((value) => setState(() => userStatistic = value));
  }
  UserStatisticModel userStatistic;
}

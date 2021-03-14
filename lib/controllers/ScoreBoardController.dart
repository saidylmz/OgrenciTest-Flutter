import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:otsappmobile/models/scoreboard_model.dart';

class ScoreBoardController extends ControllerMVC {

  ScoreBoardController([StateMVC state]) : super(state);

  ScoreBoardModel scoreBoardData;
  TabController tabController;
}

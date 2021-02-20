import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/models/test_answer.dart';
import 'package:otsappmobile/models/test_question_model.dart';

class TestAnswersController extends ControllerMVC {

  TestAnswersController([StateMVC state]) : super(state);

  int currentQuestion = 1;
  PageController pageController = PageController();
  List<TestQuestionModel> questions;
  List<TestAnswerModel> answers;
  int testId;
  String title = "Cevaplar";
  GlobalKey topBar = GlobalKey(), bottomBar = GlobalKey();

  updateCurrentQuestion(int value) {
    currentQuestion += value;
    // ignore: invalid_use_of_protected_member
    topBar.currentState.setState(() {});
    // ignore: invalid_use_of_protected_member
    bottomBar.currentState.setState(() {});
  }

}

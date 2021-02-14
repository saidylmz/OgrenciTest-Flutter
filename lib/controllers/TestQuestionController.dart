import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/models/test_answer.dart';
import 'package:otsappmobile/models/test_question_model.dart';
import 'package:otsappmobile/services/test_service.dart';

import '../constants.dart';

class TestQuestionController extends ControllerMVC {
  TestQuestionController([StateMVC state]) : super(state);

  List<TestQuestionModel> questions;
  int testId;
  int testQuestionCount;
  int currentQuestion = 1;
  String name;
  List<String> answers;
  List<int> questionIds;
  PageController pageController = PageController();
  GlobalKey topBar = GlobalKey(), bottomBar = GlobalKey();

  saveTestQuestions() {
    TestService().addTestAnswers(
      List<TestAnswerModel>.generate(
        testQuestionCount,
        (index) => TestAnswerModel(
          answer: answers[index],
          createdAt: DateTime.now(),
          testQuestionId: questionIds[index],
          userId: sUserID,
          testId: testId,
        ),
      ),
    );
  }

  updateCurrentQuestion(int value) {
    currentQuestion += value;
    // ignore: invalid_use_of_protected_member
    topBar.currentState.setState(() {});
    // ignore: invalid_use_of_protected_member
    bottomBar.currentState.setState(() {});
  }

  setAnswer(int index, String answer) {
    answers[index] = answer;
  }
}

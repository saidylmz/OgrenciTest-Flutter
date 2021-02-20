import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/controllers/TestAnswersController.dart';
import '../../models/test_question_screen_model.dart';

import 'components/body.dart';

class TestAnswersScreen extends StatefulWidget {
  static String routeName = "/testanswers";
  @override
  _TestAnswersScreenState createState() => _TestAnswersScreenState();
}

class _TestAnswersScreenState extends StateMVC<TestAnswersScreen> {
  _TestAnswersScreenState() : super(TestAnswersController()) {
    _controller = controller;
  }
  TestAnswersController _controller;

  @override
  Widget build(BuildContext context) {
    var model =
        ModalRoute.of(context).settings.arguments as TestQuestionScreenModel;
    _controller.testId = model.testId;
    _controller.title = model.name;
    return Scaffold(
      appBar: AppBar(
        title: Text(_controller.title),
        centerTitle: true,
      ),
      body: Body(controller: _controller),
    );
  }
}

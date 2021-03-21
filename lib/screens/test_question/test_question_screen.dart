import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/controllers/TestQuestionController.dart';
import '../../models/test_question_screen_model.dart';
import '../../screens/test_question/components/body.dart';

class TestQuestionScreen extends StatefulWidget {
  static String routeName = "/testquestion";

  @override
  _TestQuestionScreenState createState() => _TestQuestionScreenState();
}

class _TestQuestionScreenState extends StateMVC<TestQuestionScreen> {
  _TestQuestionScreenState() : super(TestQuestionController()) {
    _controller = controller;
  }
  TestQuestionController _controller;
  @override
  Widget build(BuildContext context) {
    var model =
        ModalRoute.of(context).settings.arguments as TestQuestionScreenModel;
    _controller.name = model.name;
    _controller.testId = model.testId;
    _controller.testTime = model.testTime;
    return WillPopScope(
          onWillPop: () { return null; },
          child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(_controller.name),
          automaticallyImplyLeading: false,
        ),
        body: Body(controller: _controller),
      ),
    );
  }
}

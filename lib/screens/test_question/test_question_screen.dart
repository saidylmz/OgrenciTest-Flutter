import 'package:flutter/material.dart';
import 'package:otsappmobile/models/test_question_screen_model.dart';
import 'package:otsappmobile/screens/test_question/components/body.dart';

class TestQuestionScreen extends StatelessWidget {
  static String routeName = "/testquestion";
  @override
  Widget build(BuildContext context) {
    var model =
        ModalRoute.of(context).settings.arguments as TestQuestionScreenModel;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(model.name),
        automaticallyImplyLeading: false,
      ),
      body: Body(testId: model.testId),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:otsappmobile/controllers/TestAnswersController.dart';
import 'package:otsappmobile/models/test_question_model.dart';
import 'package:otsappmobile/services/test_service.dart';

import '../../../size_config.dart';
import 'question_answer_body.dart';
import 'question_answer_bottom_bar.dart';
import 'question_answer_top_bar.dart';

class Body extends StatelessWidget {
  final TestAnswersController controller;

  const Body({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TestService()
        .getTestUserAnswers(controller.testId)
        .then((value) => controller.answers = value);
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: FutureBuilder(
        future: TestService().getTestQuestions(controller.testId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var testQs = snapshot.data as List<TestQuestionModel>;
            controller.questions = testQs;
            return Column(
              children: [
                QuestionAnswerTopBar(
                  key: controller.topBar,
                  controller: controller,
                ),
                QuestionAnswerBody(controller: controller),
                SizedBox(height: getProportionateScreenHeight(20)),
                QuestionAnswerBottomBar(
                  key: controller.bottomBar,
                  controller: controller,
                ),
              ],
            );
          } else
            return Center(child: Image.asset("assets/images/spinner.gif"));
        },
      ),
    );
  }
}

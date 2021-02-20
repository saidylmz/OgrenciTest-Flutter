import 'package:flutter/material.dart';
import 'package:otsappmobile/controllers/TestQuestionController.dart';

import '../../../models/test_question_model.dart';
import '../../../screens/test_question/components/question_body.dart';
import '../../../services/test_service.dart';
import '../../../size_config.dart';
import 'question_bottom_bar.dart';
import 'question_top_bar.dart';

TestQuestionController _controller;

class Body extends StatefulWidget {
  const Body({Key key, this.controller}) : super(key: key);

  final TestQuestionController controller;

  @override
  _BodyState createState() {
    _controller = controller;
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(15)),
      child: FutureBuilder(
        future: TestService().getTestQuestions(_controller.testId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var testQs = snapshot.data as List<TestQuestionModel>;
            _controller.answers = List.filled(_controller.questions.length, "");
            _controller.questionIds = List();
            testQs.forEach((element) {
              _controller.questionIds.add(element.id);
            });
            _controller.questions = testQs;
            return Column(
              children: [
                QuestionTopBar(
                  key: _controller.topBar,
                  controller: _controller,
                ),
                QuestionBody(
                  controller: _controller,
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                QuestionBottomBar(
                  key: _controller.bottomBar,
                  controller: _controller,
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

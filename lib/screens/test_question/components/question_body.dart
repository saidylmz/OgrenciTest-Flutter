import 'package:flutter/material.dart';
import 'package:otsappmobile/models/test_question_model.dart';
import 'package:otsappmobile/screens/test_question/components/question_card.dart';

class QuestionBody extends StatefulWidget {
  const QuestionBody({
    Key key,
    this.questions, this.pageController, @required this.answers, @required this.press,
  }) : super(key: key);
  final List<TestQuestionModel> questions;
  final List<String> answers;
  final PageController pageController;
final ValueChanged<QBodyParameters> press;
  @override
  _QuestionBodyState createState() => _QuestionBodyState();
}

class _QuestionBodyState extends State<QuestionBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: widget.pageController,
        physics: NeverScrollableScrollPhysics(),
        // onPageChanged: (index) {
        //   setState(() {
        //     currentQuestion = index + 1;
        //   });
        // },
        itemCount: widget.questions.length,
        itemBuilder: (context, index) => SingleChildScrollView(
          child: QuestionCard(
            question: widget.questions[index],
            selectedAnswer: widget.answers[index],
            press: (value) {
              widget.press(QBodyParameters(value,index));
            },
          ),
        ),
      ),
    );
  }
}

class QBodyParameters{
  String value;
  int index;
  QBodyParameters(this.value,this.index);
}

import 'package:flutter/material.dart';
import 'package:otsappmobile/controllers/TestAnswersController.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class QuestionAnswerBottomBar extends StatefulWidget {
  const QuestionAnswerBottomBar({
    Key key,
    this.controller,
  }) : super(key: key);

  final TestAnswersController controller;

  @override
  _QuestionAnswerBottomBarState createState() =>
      _QuestionAnswerBottomBarState();
}

class _QuestionAnswerBottomBarState extends State<QuestionAnswerBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (widget.controller.currentQuestion > 1)
          FlatButton(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(25)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.grey,
            onPressed: () {
              widget.controller.pageController.previousPage(
                  duration: Duration(milliseconds: 250), curve: Curves.ease);
              if (widget.controller.currentQuestion > 1)
                widget.controller.updateCurrentQuestion(-1);
            },
            child: Text(
              "Önceki Soru",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                color: Colors.white,
              ),
            ),
          ),
        if (widget.controller.currentQuestion <
            widget.controller.questions.length)
          FlatButton(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(25)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: kPrimaryColor,
            onPressed: () {
              widget.controller.pageController.nextPage(
                  duration: Duration(milliseconds: 250), curve: Curves.ease);
              widget.controller.updateCurrentQuestion(1);
            },
            child: Text(
              "Sonraki Soru",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}

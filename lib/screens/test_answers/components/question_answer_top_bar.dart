import 'package:flutter/material.dart';
import 'package:otsappmobile/controllers/TestAnswersController.dart';

import '../../../size_config.dart';
import '../../../constants.dart';

class QuestionAnswerTopBar extends StatefulWidget {
  const QuestionAnswerTopBar({
    Key key,
    this.controller,
  }) : super(key: key);
  final TestAnswersController controller;
  @override
  _QuestionAnswerTopBarState createState() => _QuestionAnswerTopBarState();
}

class _QuestionAnswerTopBarState extends State<QuestionAnswerTopBar> {
  @override
  Widget build(BuildContext context) {
    int correctCount = 0, wrongCount = 0, emptyCount = 0;
    for (var i = 0; i < widget.controller.questions.length; i++) {
      if (widget.controller.answers[i].answer.isEmpty)
        emptyCount++;
      else if (widget.controller.questions[i].correctAnswer ==
          widget.controller.answers[i].answer)
        correctCount++;
      else
        wrongCount++;
    }
    return Container(
      child: Column(
        children: [
          Text(
            "Test Sonuçları",
            style: TextStyle(fontSize: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              Text(correctCount.toString()),
              SizedBox(width: 10),
              Icon(
                Icons.dangerous,
                color: Colors.red,
              ),
              Text(wrongCount.toString()),
              SizedBox(width: 10),
              Icon(
                Icons.help_outlined,
                color: Colors.blue,
              ),
              Text(emptyCount.toString()),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                    text: "Cevabınız: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    children: [
                      TextSpan(
                        text: (widget
                                .controller
                                .answers[widget.controller.currentQuestion - 1]
                                .answer
                                .isEmpty
                            ? "Boş"
                            : widget
                                        .controller
                                        .answers[
                                            widget.controller.currentQuestion -
                                                1]
                                        .answer ==
                                    widget
                                        .controller
                                        .questions[
                                            widget.controller.currentQuestion -
                                                1]
                                        .correctAnswer
                                ? "Doğru"
                                : "Yanlış"),
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      ),
                    ]),
              ),
              RichText(
                text: TextSpan(
                    text:
                        "Soru " + widget.controller.currentQuestion.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    children: [
                      TextSpan(
                        text:
                            "/" + widget.controller.questions.length.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ]),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Divider(thickness: 2),
          SizedBox(height: getProportionateScreenHeight(20)),
        ],
      ),
    );
  }
}

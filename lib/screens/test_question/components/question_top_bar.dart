
import 'package:flutter/material.dart';
import 'package:otsappmobile/controllers/TestQuestionController.dart';

import '../../../size_config.dart';
import 'progress_bar.dart';

class QuestionTopBar extends StatefulWidget {
  const QuestionTopBar({ 
    Key key, this.controller,
  }) : super(key: key); 
  final TestQuestionController controller;
  @override
  _QuestionTopBarState createState() => _QuestionTopBarState();
}

class _QuestionTopBarState extends State<QuestionTopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ProgressBar(
            minute: 120,
            timeout: widget.controller.saveTestQuestions,
            testId: widget.controller.testId,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Soru " + widget.controller.currentQuestion.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  "/" + widget.controller.testQuestionCount.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
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

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:otsappmobile/controllers/TestAnswersController.dart';
import 'package:otsappmobile/size_config.dart';

import 'option_answer.dart';

class QuestionAnswerBody extends StatefulWidget {
  const QuestionAnswerBody({
    Key key,
    this.controller,
  }) : super(key: key);
  final TestAnswersController controller;
  @override
  _QuestionAnswerBodyState createState() => _QuestionAnswerBodyState();
}

class _QuestionAnswerBodyState extends State<QuestionAnswerBody> {
  var optionNames = ["A", "B", "C", "D", "E"];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: widget.controller.pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.controller.questions.length,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Html(data: widget.controller.questions[index].questionBody),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      for (var i = 0; i < optionNames.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(top:3, bottom: 3),
                          child: OptionAnswer(
                            text: widget.controller.questions[index]
                                .toJson()["Question" + optionNames[i]],
                            name: optionNames[i],
                            index: index,
                            controller: widget.controller,
                            press: null,
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

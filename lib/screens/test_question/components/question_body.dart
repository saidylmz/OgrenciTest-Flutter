import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:otsappmobile/controllers/TestQuestionController.dart';
import 'option.dart';

class QuestionBody extends StatefulWidget {
  const QuestionBody({
    Key key,
    this.controller,
  }) : super(key: key);
  final TestQuestionController controller;
  @override
  _QuestionBodyState createState() => _QuestionBodyState();
}

class _QuestionBodyState extends State<QuestionBody> {
  var optionNames = ["A", "B", "C", "D", "E"];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: widget.controller.pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.controller.questions.length,
        itemBuilder: (context, index) {
          var optKeys = List.generate(optionNames.length, (index) => GlobalKey());
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
                        Option(
                          key: optKeys[i],
                          text: widget.controller.questions[index]
                              .toJson()["Question" + optionNames[i]],
                          name: optionNames[i],
                          index: index,
                          controller: widget.controller,
                          press: () {
                            widget.controller.setAnswer(index, optionNames[i]);
                            for (var item in optKeys) {
                              item.currentState.setState(() {});
                            }
                          },
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

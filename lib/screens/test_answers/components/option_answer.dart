
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:otsappmobile/controllers/TestAnswersController.dart';

import '../../../constants.dart';

class OptionAnswer extends StatefulWidget {
  const OptionAnswer({
    Key key,
    @required this.text,
    @required this.index,
    @required this.controller,
    @required this.name,
    this.press,
  }) : super(key: key);
  final String text;
  final int index;
  final String name;
  final TestAnswersController controller;
  final VoidCallback press;
  @override
  _OptionAnswerState createState() => _OptionAnswerState();
}

class _OptionAnswerState extends State<OptionAnswer> {
  @override
  Widget build(BuildContext context) {
    bool isAnswerEqual = widget.controller.answers[widget.index].answer == widget.name;
    bool isOptionCorrect = widget.name == widget.controller.questions[widget.index].correctAnswer;
    return FlatButton(
      color: isOptionCorrect ? Colors.green : isAnswerEqual ? kPrimaryColor : Colors.transparent,
      shape: RoundedRectangleBorder(
        side:
            BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(50),
      ),
      onPressed: () {
        widget.press();
      },
      child: Container(
        child: Html(
          data: "<b>" + widget.name + ")</b> " + widget.text,
          style: {
            "html": Style(color: isOptionCorrect ? Colors.black : isAnswerEqual ? Colors.white : Colors.black),
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:otsappmobile/models/test_question_model.dart';

import '../../../constants.dart';

String selected = "";

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    Key key,
    // it means we have to pass this
    @required this.question,
    @required this.press,
    this.selectedAnswer,
  }) : super(key: key);

  final TestQuestionModel question;
  final ValueChanged<String> press;
  final String selectedAnswer;

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    List<String> qOptions = ["A", "B", "C", "D", "E"];
    List<GlobalKey<_OptionState>> options =
        List.filled(qOptions.length, GlobalKey());
    for (var i = 0; i < qOptions.length; i++) {
      options[i] = GlobalKey();
    }
    return Column(
      children: [
        Html(data: widget.question.questionBody),
        SizedBox(height: 20 / 2),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              for (var i = 0; i < qOptions.length; i++)
                Option(
                  key: options[i],
                  text: widget.question.toJson()["Question"+qOptions[i]],
                  index: qOptions[i],
                  selectedIndex: widget.selectedAnswer,
                  press: () {
                    for (var q = 0; q < qOptions.length; q++) {
                      options[q].currentState.changeSelected(qOptions[i]);
                    }
                    widget.press(qOptions[i]);
                  },
                ),
            ],
          ),
        )
      ],
    );
  }
}

class Option extends StatefulWidget {
  const Option({
    Key key,
    @required this.text,
    @required this.index,
    @required this.press,
    @required this.selectedIndex
  }) : super(key: key);
  final String text;
  final String index;
  final VoidCallback press;
  final String selectedIndex;
  @override
  _OptionState createState() => _OptionState();
}

class _OptionState extends State<Option> {
  bool selected;
  @override
  Widget build(BuildContext context) {
    selected ??= widget.selectedIndex == widget.index;
    return FlatButton(
      color: selected ? kPrimaryColor : Colors.transparent,
      shape: RoundedRectangleBorder(
        side:
            BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(50),
      ),
      onPressed: () {
        setState(() {
          selected = true;
        });
        widget.press();
      },
      child: Container(
        child: Html(
          data: "<b>" + widget.index + ")</b> " + widget.text,
          style: {
            "html": Style(color: selected ? Colors.white : Colors.black),
          },
        ),
      ),
    );
  }

  changeSelected(String selectedIndex) {
    setState(() {
      selected = widget.index == selectedIndex;
    });
  }
}

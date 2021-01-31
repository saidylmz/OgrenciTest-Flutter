import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:otsappmobile/models/test_question_model.dart';
import 'package:otsappmobile/screens/test_question/components/option.dart';

import '../../../constants.dart';

String selected = "";

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    Key key,
    // it means we have to pass this
    @required this.question,
  }) : super(key: key);

  final TestQuestionModel question;

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    List<GlobalKey<_OptionState>> options = List.filled(5, GlobalKey());
    for (var i = 0; i < 5; i++) {
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
              // FlatButton(
              //   color: selected == "A" ? kPrimaryColor : Colors.transparent,
              //   shape: RoundedRectangleBorder(
              //     side: BorderSide(
              //         color: Colors.grey, width: 1, style: BorderStyle.solid),
              //     borderRadius: BorderRadius.circular(50),
              //   ),
              //   onPressed: () {
              //     setState(() {
              //       selected = "A";
              //     });
              //   },
              //   child: Container(
              //     child: Html(
              //       data: "<b>A)</b> " + widget.question.questionA,
              //     ),
              //   ),
              // ),
              // FlatButton(
              //   color: selected == "B" ? kPrimaryColor : Colors.transparent,
              //   shape: RoundedRectangleBorder(
              //     side: BorderSide(
              //         color: Colors.grey, width: 1, style: BorderStyle.solid),
              //     borderRadius: BorderRadius.circular(50),
              //   ),
              //   onPressed: () {
              //     setState(() {
              //       selected = "B";
              //     });
              //   },
              //   child: Container(
              //       child: Html(
              //     data: "<b>B)</b> " + widget.question.questionA,
              //   )),
              // ),
              // FlatButton(
              //   color: selected == "C" ? kPrimaryColor : Colors.transparent,
              //   shape: RoundedRectangleBorder(
              //     side: BorderSide(
              //         color: Colors.grey, width: 1, style: BorderStyle.solid),
              //     borderRadius: BorderRadius.circular(50),
              //   ),
              //   onPressed: () {
              //     setState(() {
              //       selected = "C";
              //     });
              //   },
              //   child: Container(
              //       child: Html(
              //     data: "<b>C)</b> " + widget.question.questionA,
              //   )),
              // ),
              // FlatButton(
              //   color: selected == "D" ? kPrimaryColor : Colors.transparent,
              //   shape: RoundedRectangleBorder(
              //     side: BorderSide(
              //         color: Colors.grey, width: 1, style: BorderStyle.solid),
              //     borderRadius: BorderRadius.circular(50),
              //   ),
              //   onPressed: () {
              //     setState(() {
              //       selected = "D";
              //     });
              //   },
              //   child: Container(
              //       child: Html(
              //     data: "<b>D)</b> " + widget.question.questionA,
              //   )),
              // ),
              // FlatButton(
              //   color: selected == "E" ? kPrimaryColor : Colors.transparent,
              //   shape: RoundedRectangleBorder(
              //     side: BorderSide(
              //         color: Colors.grey, width: 1, style: BorderStyle.solid),
              //     borderRadius: BorderRadius.circular(50),
              //   ),
              //   onPressed: () {
              //     setState(() {
              //       selected = "E";
              //     });
              //   },
              //   child: Container(
              //       child: Html(
              //     data: "<b>E)</b> " + widget.question.questionA,
              //   )),
              // ),
              Option(
                key: options[0],
                text: widget.question.questionA,
                index: "A",
                press: () {
                  for (var i = 0; i < 5; i++) {
                    options[i].currentState.changeSelected("A");
                  }
                },
              ),
              Option(
                key: options[1],
                text: widget.question.questionB,
                index: "B",
                press: () {
                  for (var i = 0; i < 5; i++) {
                    options[i].currentState.changeSelected("B");
                  }
                },
              ),
              Option(
                key: options[2],
                text: widget.question.questionC,
                index: "C",
                press: () {
                  for (var i = 0; i < 5; i++) {
                    options[i].currentState.changeSelected("C");
                  }
                },
              ),
              Option(
                key: options[3],
                text: widget.question.questionD,
                index: "D",
                press: () {
                  for (var i = 0; i < 5; i++) {
                    options[i].currentState.changeSelected("D");
                  }
                },
              ),
              if (widget.question.questionE.isNotEmpty)
                Option(
                  key: options[4],
                  text: widget.question.questionE,
                  index: "E",
                  press: () {
                  for (var i = 0; i < 5; i++) {
                    options[i].currentState.changeSelected("E");
                  }
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
  }) : super(key: key);
  final String text;
  final String index;
  final VoidCallback press;
  @override
  _OptionState createState() => _OptionState();
}

class _OptionState extends State<Option> {
  bool selected;
  @override
  Widget build(BuildContext context) {
    selected ??= false;
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
      )),
    );
  }

  changeSelected(String selectedIndex) {
    setState(() {
      selected = widget.index == selectedIndex;
    });
  }
}

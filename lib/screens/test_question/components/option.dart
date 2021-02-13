
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:otsappmobile/controllers/TestQuestionController.dart';

import '../../../constants.dart';

class Option extends StatefulWidget {
  const Option({
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
  final TestQuestionController controller;
  final VoidCallback press;
  @override
  _OptionState createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    bool selected = widget.controller.answers[widget.index] == widget.name;

    return FlatButton(
      color: selected ? kPrimaryColor : Colors.transparent,
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
            "html": Style(color: selected ? Colors.white : Colors.black),
          },
        ),
      ),
    );
  }
}

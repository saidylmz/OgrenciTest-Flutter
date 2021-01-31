import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:otsappmobile/constants.dart';

bool selected = false;

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

  changeSelected(String selectedIndex) => selected = widget.index == selectedIndex;
}


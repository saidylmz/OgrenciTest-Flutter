
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class TestDetailTitleDesc extends StatelessWidget {
  const TestDetailTitleDesc({
    Key key,
    this.title,
    this.desc,
  }) : super(key: key);

  final String title, desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Container(
          width: getProportionateScreenWidth(180),
          child: Text(
            desc,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}

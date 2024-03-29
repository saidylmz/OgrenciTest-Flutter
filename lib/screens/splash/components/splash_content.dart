import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Spacer(),
      Text(
        AppName,
        style: TextStyle(
          fontSize: getProportionateScreenWidth(25),
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        text,
        textAlign: TextAlign.center,
      ),
      Spacer(flex: 2),
      Image.asset(
        image,
        height: getProportionateScreenHeight(500)
      )
    ]);
  }
}

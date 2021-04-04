import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../controllers/SplashController.dart';
import '../../../screens/home/home_screen.dart';
import '../../../screens/login/login_screen.dart';
import '../../../size_config.dart';

import '../components/splash_content.dart';
import '../../../components/default_button.dart';

SplashController _controller;

class Body extends StatefulWidget {
  final SplashController controller;
  const Body({Key key, this.controller}) : super(key: key);
  @override
  _BodyState createState() {
    _controller = controller;
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: PageView.builder(
                onPageChanged: (value) {
                  _controller.changePage(value);
                },
                itemCount: _controller.splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: _controller.getSplashData(index, "image"),
                  text: _controller.getSplashData(index, "text"),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: Column(
                  children: [
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_controller.splashData.length,
                          (index) => buildDot(index: index)),
                    ),
                    Spacer(flex: 1),
                    DefaultButton(
                      text: "Geç",
                      press: () {
                        if (_controller.stateLogin == 1)
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.routeName, (r) => false);
                        else if (_controller.stateLogin == 2)
                          Navigator.pushNamedAndRemoveUntil(
                              context, HomeScreen.routeName, (r) => false);
                        else if (_controller.stateLogin == 3) {
                          _controller.checkConnection(context,true);
                        }
                      },
                    ),
                    Spacer()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: _controller.currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: _controller.currentPage == index
              ? kPrimaryColor
              : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}

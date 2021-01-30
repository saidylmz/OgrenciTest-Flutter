import 'package:flutter/material.dart';
import 'package:otsappmobile/constants.dart';
import 'package:otsappmobile/models/login_model.dart';
import 'package:otsappmobile/screens/home/home_screen.dart';
import 'package:otsappmobile/screens/login/login_screen.dart';
import 'package:otsappmobile/services/auth_service.dart';
import 'package:otsappmobile/services/user_service.dart';
import 'package:otsappmobile/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0, state = 0;
  List<Map<String, String>> splashData = [
    {
      "text":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "image": "assets/images/splash_2.png"
    },
    {
      "text":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "image": "assets/images/splash_3.png"
    },
  ];

  Future<Null> getData() async {
    Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _sprefs;
    String email = (prefs.getString('email'));
    String password = (prefs.getString('password'));

    if (email != null &&
        email.isNotEmpty &&
        password != null &&
        password.isNotEmpty) {
      LoginModel loginModel = await AuthService().login(email, password);
      if (loginModel.error.isEmpty) {
        setState(()  {
          sToken = loginModel.token;
          sUserID = loginModel.userId;
          sExpiration = loginModel.expiration;
          state = 2;
        });
        sUser = await UserService().getUserById(sUserID);
      } else {
        setState(() {
          state = 1;
        });
      }
    } else {
      setState(() {
        state = 1;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (sExpiration == null || sExpiration.isBefore(DateTime.now())) getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]["text"],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: Column(
                  children: [
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          splashData.length, (index) => buildDot(index: index)),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Geç",
                      press: () {
                        if (state == 1)
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        else if (state == 2)
                          Navigator.pushNamed(context, HomeScreen.routeName);
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
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}

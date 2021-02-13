import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../screens/forgot_password/forgot_password_screen.dart';
import '../../../screens/home/home_screen.dart';
import '../../../size_config.dart';
import '../../../controllers/LoginController.dart';

LoginController _controller;

class Body extends StatefulWidget {
  final LoginController controller;

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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(25)),
            Text(
              "Hoşgeldiniz",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Text(
              "Mail adresiniz ve şifreniz ile giriş yapabilirsiniz.\nKaydınız yoksa öğretmeniniz veya müdürünüz ile iletişime geçiniz.",
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: getProportionateScreenHeight(70)),
            LoginForm()
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends StateMVC<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _controller.formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          Row(
            children: [
              Checkbox(
                value: _controller.remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  _controller.setRemember(value);
                },
              ),
              Text("Beni Hatırla"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Şifremi Unuttum",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: _controller.errors),
          SizedBox(height: getProportionateScreenHeight(50)),
          DefaultButton(
            text: "Giriş Yap",
            press: () async {
              bool res = await _controller.pressedLogin();
              if (res)
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.routeName, (r) => false);
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => _controller.password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && _controller.errors.contains(kPassNullError)) {
          _controller.removeError(kPassNullError);
        }
        return _controller.errors.length == 0 ? null : "";
      },
      validator: (value) {
        if (value.isEmpty && !_controller.errors.contains(kPassNullError)) {
          _controller.addError(kPassNullError);
        }
        return _controller.errors.length == 0 ? null : "";
      },
      decoration: InputDecoration(
        labelText: "Şifre",
        hintText: "Şifreniz",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: getProportionateScreenWidth(18),
        ),
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => _controller.email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && _controller.errors.contains(kEmailNullError)) {
          _controller.removeError(kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value) &&
            _controller.errors.contains(kInvalidEmailError)) {
          _controller.removeError(kInvalidEmailError);
        }
        return _controller.errors.length == 0 ? null : "";
      },
      validator: (value) {
        if (value.isEmpty && !_controller.errors.contains(kEmailNullError)) {
          _controller.addError(kEmailNullError);
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !_controller.errors.contains(kInvalidEmailError)) {
          _controller.addError(kInvalidEmailError);
        }

        return _controller.errors.length == 0 ? null : "";
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Email adresiniz",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: getProportionateScreenWidth(18),
        ),
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}

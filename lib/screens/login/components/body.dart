import 'package:flutter/material.dart';
import 'package:otsappmobile/components/custom_suffix_icon.dart';
import 'package:otsappmobile/components/default_button.dart';
import 'package:otsappmobile/components/form_error.dart';
import 'package:otsappmobile/constants.dart';
import 'package:otsappmobile/models/login_model.dart';
import 'package:otsappmobile/screens/forgot_password/forgot_password_screen.dart';
import 'package:otsappmobile/screens/home/home_screen.dart';
import 'package:otsappmobile/services/auth_service.dart';
import 'package:otsappmobile/services/user_service.dart';
import 'package:otsappmobile/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatelessWidget {
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

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
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
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(50)),
          DefaultButton(
            text: "Giriş Yap",
            press: () async {
              setState(() {
                errors.removeRange(0, errors.length);
              });
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                LoginModel loginModel =
                    await AuthService().login(email, password);
                if (loginModel.error.isNotEmpty &&
                    !errors.contains(loginModel.error)) {
                  setState(() {
                    errors.add(loginModel.error);
                  });
                } else if (loginModel.error.isEmpty) {
                  if (remember) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('email', email);
                    prefs.setString('password', password);
                  }
                  setState(() {
                    sToken = loginModel.token;
                    sUserID = loginModel.userId;
                    sExpiration = loginModel.expiration;
                  });
                  sUser = await UserService().getUserById(sUserID);
                  Navigator.pushNamed(context, HomeScreen.routeName);
                }
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        }
        if (errors.length == 0)
          return null;
        else
          return "";
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
        }
        if (errors.length == 0)
          return null;
        else
          return "";
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
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
        if (errors.length == 0)
          return null;
        else
          return "";
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
          });
        }
        if (errors.length == 0)
          return null;
        else
          return "";
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

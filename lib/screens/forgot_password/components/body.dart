import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otsappmobile/controllers/ForgotPasswordController.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../models/new_password_model.dart';
import '../../../screens/new_password/new_password.dart';
import '../../../size_config.dart';
import '../../../constants.dart';
import '../../../services/user_service.dart';

ForgotPasswordController _controller;

class Body extends StatelessWidget {
  final ForgotPasswordController controller;

  const Body({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller = controller;
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(30)),
            Text(
              "Şifremi Unuttum",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Lütfen kayıtlı mail adresinizi yazınız.\nŞifrenizi değiştirebilmeniz için kod gönderilecektir.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: getProportionateScreenHeight(100)),
            ForgotPassForm()
          ],
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _controller.formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => _controller.email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty &&
                  _controller.errors.contains(kEmailNullError)) {
                _controller.removeError(kEmailNullError);
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  _controller.errors.contains(kInvalidEmailError)) {
                _controller.removeError(kInvalidEmailError);
              }
              return _controller.errors.length == 0 ? null : "";
            },
            validator: (value) {
              if (value.isEmpty &&
                  !_controller.errors.contains(kEmailNullError)) {
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
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          if (_controller.codeSended)
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              maxLength: 5,
              onSaved: (value) {
                _controller.code = value;
              },
              decoration: InputDecoration(
                labelText: "Doğrulama Kodu",
                hintText: "Mail adresinize gelen doğrulama kodu",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(18),
                ),
                suffixIcon: CustomSuffixIcon(
                    svgIcon: "assets/icons/Check mark rounde.svg"),
              ),
            ),
          SizedBox(height: getProportionateScreenHeight(10)),
          FormError(errors: _controller.errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: _controller.buttonText,
            press: () async {
              if (!_controller.codeSended) {
                if (_controller.formKey.currentState.validate()) {
                  _controller.formKey.currentState.save();
                  String result =
                      await UserService().sendPasswordCode(_controller.email);

                  if (result.isNotEmpty) {
                    setState(() {
                      _controller.buttonText = "Kodu Doğrula";
                    });
                    _controller.codeSended = true;
                    _controller.getCode = result;
                  }
                } else {
                  _controller.codeSended = false;
                  setState(() {
                    _controller.buttonText = "Gönder";
                  });
                }
              } else {
                _controller.formKey.currentState.save();
                if (_controller.code != null && _controller.code.isNotEmpty) {
                  _controller.removeError(kPassCodeNullError);
                  if (_controller.code == _controller.getCode &&
                      _controller.getCode != null &&
                      _controller.getCode.isNotEmpty) {
                    Navigator.pushNamed(context, NewPasswordScreen.routeName,
                        arguments: NewPasswordModel(true, _controller.email));
                  } else {
                    if (!_controller.errors.contains(kPassCodeValidError)) {
                      _controller.addError(kPassCodeValidError);
                    }
                  }
                } else {
                  if (!_controller.errors.contains(kPassCodeNullError)) {
                    _controller.addError(kPassCodeNullError);
                  }
                }
              }
            },
          )
        ],
      ),
    );
  }
}

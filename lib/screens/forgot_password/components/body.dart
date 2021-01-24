import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otsappmobile/components/custom_suffix_icon.dart';
import 'package:otsappmobile/components/default_button.dart';
import 'package:otsappmobile/components/form_error.dart';
import 'package:otsappmobile/screens/new_password/new_password.dart';
import 'package:otsappmobile/size_config.dart';

import '../../../constants.dart';
import '../../../services/user_service.dart';
import '../../../models/new_password_model.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String email, buttonText = "Gönder", code = "", getCode;
  bool codeSended = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
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
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          if (codeSended)
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              maxLength: 5,
              onChanged: (value) {
                setState(() {
                  code = value;
                });
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
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: buttonText,
            press: () async {
              
              if (!codeSended) {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  String result = await UserService().sendPasswordCode(email);
                  
                  if (result.isNotEmpty) {
                    setState(() {
                      codeSended = true;
                      buttonText = "Kodu Doğrula";
                      getCode = result;
                    });
                  }
                } else {
                  setState(() {
                    codeSended = false;
                    buttonText = "Gönder";
                  });
                }
              } else {
                if (code != null && code.isNotEmpty) {
                  errors.remove(kPassCodeNullError);
                  if (code == getCode && getCode != null && getCode.isNotEmpty) {
                    Navigator.pushNamed(context, NewPasswordScreen.routeName,
                        arguments: NewPasswordModel(true, email));
                  } else {
                    setState(() {
                      if (!errors.contains(kPassCodeValidError)) {
                        errors.add(kPassCodeValidError);
                      }
                    });
                  }
                } else {
                  setState(() {
                    if (!errors.contains(kPassCodeNullError)) {
                      errors.add(kPassCodeNullError);
                    }
                  });
                }
              }
            },
          )
        ],
      ),
    );
  }
}

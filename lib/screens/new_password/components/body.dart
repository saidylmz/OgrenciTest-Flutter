import 'package:flutter/material.dart';
import 'package:otsappmobile/components/custom_suffix_icon.dart';
import 'package:otsappmobile/components/default_button.dart';
import 'package:otsappmobile/components/form_error.dart';
import 'package:otsappmobile/screens/login/login_screen.dart';
import 'package:otsappmobile/size_config.dart';

import '../../../constants.dart';
import '../../../models/new_password_model.dart';
import '../../../services/user_service.dart';

NewPasswordModel model;

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    model = ModalRoute.of(context).settings.arguments as NewPasswordModel;
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(30)),
            Text(
              "Yeni Şifre",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: getProportionateScreenHeight(100)),
            NewPassForm()
          ],
        ),
      ),
    );
  }
}

class NewPassForm extends StatefulWidget {
  @override
  _NewPassFormState createState() => _NewPassFormState();
}

class _NewPassFormState extends State<NewPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String oldPass, newPass, confirmPass;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (!model.isCoded)
            TextFormField(
              obscureText: true,
              onSaved: (newValue) => oldPass = newValue,
              onChanged: (value) {
                if (value.isNotEmpty && errors.contains(kOldPassNullError)) {
                  setState(() {
                    errors.remove(kOldPassNullError);
                  });
                }
                if (errors.length == 0)
                  return null;
                else
                  return "";
              },
              validator: (value) {
                if (value.isEmpty && !errors.contains(kOldPassNullError)) {
                  setState(() {
                    errors.add(kOldPassNullError);
                  });
                }
                if (errors.length == 0)
                  return null;
                else
                  return "";
              },
              decoration: InputDecoration(
                labelText: "Eski Şifreniz",
                hintText: "Eski şifreniz",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(18),
                ),
                suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
              ),
            ),
          SizedBox(height: getProportionateScreenHeight(20)),
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => newPass = newValue,
            onChanged: (value) {
              setState(() {
                confirmPass = value;
              });
              if (value.isNotEmpty && errors.contains(kNewPassNullError)) {
                setState(() {
                  errors.remove(kNewPassNullError);
                });
              }
              if (errors.length == 0)
                return null;
              else
                return "";
            },
            validator: (value) {
              if (value.isEmpty && !errors.contains(kNewPassNullError)) {
                setState(() {
                  errors.add(kNewPassNullError);
                });
              }
              if (errors.length == 0)
                return null;
              else
                return "";
            },
            decoration: InputDecoration(
              labelText: "Yeni Şifre",
              hintText: "Yeni şifre",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(18),
              ),
              suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          TextFormField(
            obscureText: true,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kNewPassNullError)) {
                setState(() {
                  errors.remove(kNewPassNullError);
                });
                
              }
              if (value != confirmPass &&
                    !errors.contains(kNewPassNotMatchError)) {
                  setState(() {
                    errors.add(kNewPassNotMatchError);
                  });
                } else {
                  setState(() {
                    errors.remove(kNewPassNotMatchError);
                  });
                }
              if (errors.length == 0)
                return null;
              else
                return "";
            },
            validator: (value) {
              if (value.isNotEmpty && errors.contains(kNewPassNullError)) {
                setState(() {
                  errors.remove(kNewPassNullError);
                });
                
              }
              if (value != confirmPass &&
                    !errors.contains(kNewPassNotMatchError)) {
                  setState(() {
                    errors.add(kNewPassNotMatchError);
                  });
                } else {
                  setState(() {
                    errors.remove(kNewPassNotMatchError);
                  });
                }
              if (errors.length == 0)
                return null;
              else
                return "";
            },
            decoration: InputDecoration(
              labelText: "Yeni Şifre Tekrar",
              hintText: "Yeni şifre tekrar",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(18),
              ),
              suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
              text: "Gönder",
              press: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  if (model.isCoded) {
                    UserService().updatePassword(model.email, oldPass, newPass);
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  } else {
                    //TODO:Eski şifre ile değiştirme
                    if (oldPass == "12345") {
                    } else {
                      setState(() {
                        errors.add("apiden gelen");
                      });
                    }
                  }
                }
              })
        ],
      ),
    );
  }
}

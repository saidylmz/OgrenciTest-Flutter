import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../controllers/NewPasswordController.dart';
import '../../../screens/login/login_screen.dart';
import '../../../size_config.dart';
import '../../../constants.dart';
import '../../../services/user_service.dart';

NewPasswordController _controller;

class Body extends StatelessWidget {
  final NewPasswordController controller;

  const Body({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller = controller;
    _controller.setModelFromArgument(ModalRoute.of(context).settings.arguments);
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
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _controller.formKey,
      child: Column(
        children: [
          if (!_controller.model.isCoded)
            TextFormField(
              obscureText: true,
              onSaved: (newValue) => _controller.oldPass = newValue,
              onChanged: (value) {
                if (value.isNotEmpty &&
                    _controller.errors.contains(kOldPassNullError)) {
                  _controller.removeError(kOldPassNullError);
                }
                return _controller.errors.length == 0 ? null : "";
              },
              validator: (value) {
                if (value.isEmpty &&
                    !_controller.errors.contains(kOldPassNullError)) {
                  _controller.addError(kOldPassNullError);
                }
                return _controller.errors.length == 0 ? null : "";
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
            onSaved: (newValue) => _controller.newPass = newValue,
            onChanged: (value) {
              _controller.confirmPass = value;
              if (value.isNotEmpty &&
                  _controller.errors.contains(kNewPassNullError)) {
                _controller.removeError(kNewPassNullError);
              }
              return _controller.errors.length == 0 ? null : "";
            },
            validator: (value) {
              if (value.isEmpty &&
                  !_controller.errors.contains(kNewPassNullError)) {
                _controller.addError(kNewPassNullError);
              }
              return _controller.errors.length == 0 ? null : "";
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
              if (value.isNotEmpty &&
                  _controller.errors.contains(kNewPassNullError)) {
                _controller.removeError(kNewPassNullError);
              }
              if (value != _controller.confirmPass &&
                  !_controller.errors.contains(kNewPassNotMatchError)) {
                _controller.addError(kNewPassNotMatchError);
              } else if (value == _controller.confirmPass) {
                _controller.removeError(kNewPassNotMatchError);
              }
              return _controller.errors.length == 0 ? null : "";
            },
            validator: (value) {
              if (value.isNotEmpty &&
                  _controller.errors.contains(kNewPassNullError)) {
                _controller.removeError(kNewPassNullError);
              }
              if (value != _controller.confirmPass &&
                  !_controller.errors.contains(kNewPassNotMatchError)) {
                _controller.addError(kNewPassNotMatchError);
              } else if (value == _controller.confirmPass) {
                _controller.removeError(kNewPassNotMatchError);
              }
              return _controller.errors.length == 0 ? null : "";
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
          FormError(errors: _controller.errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: "Gönder",
            press: () async {
              if (_controller.formKey.currentState.validate()) {
                _controller.formKey.currentState.save();
                var res = await UserService().updatePassword(
                    _controller.model.email,
                    _controller.oldPass,
                    _controller.newPass);
                AwesomeDialog(
                  context: context,
                  animType: AnimType.SCALE,
                  dialogType: DialogType.SUCCES,
                  body: Center(
                    child: Text(
                      res,
                    ),
                  ),
                  title: "Şifre Değişikliği",
                  btnOkOnPress: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginScreen.routeName, (r) => false);
                  },
                )..show();
              }
            },
          )
        ],
      ),
    );
  }
}

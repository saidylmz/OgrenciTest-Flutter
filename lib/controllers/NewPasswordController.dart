import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import '../models/new_password_model.dart';

class NewPasswordController extends ControllerMVC {
  NewPasswordController([StateMVC state]) : super(state);

  NewPasswordModel model;
  final formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String oldPass, newPass, confirmPass;

  void addError(String error) => setState(() => errors.add(error));
  void removeError(String error) => setState(() => errors.remove(error));

  void setModelFromArgument(NewPasswordModel model) =>
      this.model = model;

  void changeConfirmPass(String value) => setState(()=> confirmPass = value);
}

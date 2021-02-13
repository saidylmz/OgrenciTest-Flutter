import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ForgotPasswordController extends ControllerMVC {
  ForgotPasswordController([StateMVC state]) : super(state);

  final formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String email, buttonText = "Gönder", code = "", getCode;
  bool codeSended = false;

  void addError(String error) => setState(() => errors.add(error));
  void removeError(String error) => setState(() => errors.remove(error));
}
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:otsappmobile/constants.dart';
import 'package:otsappmobile/services/user_service.dart';

class ProfileController extends ControllerMVC {
  ProfileController([StateMVC state]) : super(state);

  String newPhone = "";
  bool showPhoneError = false;

  selectBirthDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: sUser.birthDate ?? DateTime.now(), // Refer step 1
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
    ).then((value) {
      if (value != null && value != sUser.birthDate) {
        setState(() {
          sUser.birthDate = value;
        });
        //Navigator.pop(context);
        UserService().updateBirthDate(value.toString()).then((value) {
          AwesomeDialog(
            context: context,
            title: "Doğum Tarihi",
            dialogType: DialogType.SUCCES,
            desc: value,
            btnOkText: "Tamam",
            btnOkOnPress: () {},
          )..show();
        });
      }
    });
  }
}

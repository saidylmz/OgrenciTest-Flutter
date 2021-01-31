import 'package:flutter/material.dart';
import 'package:otsappmobile/models/user_model.dart';
import 'package:otsappmobile/size_config.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
// const kPrimaryGradientColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
// );
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
const kPrimaryGradient = LinearGradient(
  colors: [kPrimaryColor, kPrimaryLightColor],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const String AppName = "TEST";

const String apiUrl = "http://192.168.2.241:45456/api";

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Lütfen mail adresinizi yazınız";
const String kInvalidEmailError = "Mail formatı yanlış";
const String kPassNullError = "Lütfen şifrenizi yazınız";
const String kPassCodeNullError = "Lütfen kodu giriniz";
const String kPassCodeValidError = "Girdiğiniz kod hatalıdır";
const String kOldPassNullError = "Lütfen eski şifrenizi yazınız";
const String kOldPassValidError = "Eski şifreniz hatalıdır";
const String kNewPassNotMatchError = "Girdiğiniz şifreler eşleşmemektedir";
const String kNewPassNullError = "Lütfen yeni şifrenizi giriniz";

//Storage Keys
String sToken = "";
int sUserID;
DateTime sExpiration;
UserModel sUser;

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

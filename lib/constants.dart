import 'package:flutter/material.dart';
import 'models/user_model.dart';
import 'services/firestore_service.dart';
import 'size_config.dart';

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

const String AppName = "TEST Takip";

const String apiUrl = "http://192.168.92.1:45456/api";
const String fcmServerKey = "AAAA_Zs6pN4:APA91bEli0iUBw9ka6fHQedgS6KbknajITAOfVJp5IXW9bjKVsf7Koid0Qk7C4_DV9oOQ5h1v9dZ7iJxK_X3Y4abZMT-RhFsFfGcjZ-vWopfMTHnHhvnqwe0ggnFWIjD1wXcoquJayJN";

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

//Static Variables
String sToken = "";
int sUserID;
DateTime sExpiration;
UserModel sUser;
List<FrUser> sFrUsers;
String sNotifToken;

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

Map<int, String> operationClaims = { 1: "Admin", 2: "Müdür", 3: "Öğretmen", 4: "Öğrenci" };
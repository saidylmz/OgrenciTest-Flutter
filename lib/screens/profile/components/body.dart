import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:otsappmobile/constants.dart';
import 'package:otsappmobile/controllers/ProfileController.dart';
import 'package:otsappmobile/models/new_password_model.dart';
import 'package:otsappmobile/screens/new_password/new_password.dart';
import 'package:otsappmobile/services/user_service.dart';
import 'package:otsappmobile/size_config.dart';

class Body extends StatefulWidget {
  final ProfileController controller;
  const Body({Key key, this.controller}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage:
                  MemoryImage(Base64Decoder().convert(sUser.image)),
              maxRadius: 50,
              child: GestureDetector(
                onTap: () async {
                  ImagePicker imagePicker = ImagePicker();
                  PickedFile pickedFile;

                  pickedFile =
                      await imagePicker.getImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    var imageFile = File(pickedFile.path);
                    if (imageFile != null) {
                      List<int> imageBytes = imageFile.readAsBytesSync();
                      sUser.image = base64Encode(imageBytes);
                      setState(() {});
                      UserService().updateImage(sUser.image).then((value) {
                        AwesomeDialog(
                          context: context,
                          title: "Resim",
                          dialogType: DialogType.SUCCES,
                          desc: value,
                          btnOkText: "Tamam",
                          btnOkOnPress: () {
                            //Navigator.pop(context);
                          },
                        )..show();
                      });
                    }
                  }
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    child: Icon(Icons.camera_alt, color: Colors.white),
                    maxRadius: 17,
                    backgroundColor: Colors.black.withAlpha(120),
                  ),
                ),
              ),
            ),
          ),
          Center(
              child: Text(
            sUser.userName +
                " " +
                sUser.userSurName +
                (sUser.birthDate == null
                    ? ""
                    : ", " +
                        (DateTime.now().year - sUser.birthDate.year)
                            .toString()),
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          )),
          SizedBox(height: getProportionateScreenHeight(50)),
          Row(
            children: [
              Icon(Icons.email),
              SizedBox(width: getProportionateScreenWidth(5)),
              RichText(
                text: TextSpan(
                  text: "Email\n",
                  style: TextStyle(color: kPrimaryColor, fontSize: 17),
                  children: [
                    TextSpan(
                      text: sUser.email,
                      style: TextStyle(color: kSecondaryColor, fontSize: 16),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          GestureDetector(
            onTap: () => showModal(context, widget.controller),
            child: Row(
              children: [
                Icon(Icons.phone_android),
                SizedBox(width: getProportionateScreenWidth(5)),
                RichText(
                  text: TextSpan(
                    text: "Telefon\n",
                    style: TextStyle(color: kPrimaryColor, fontSize: 17),
                    children: [
                      TextSpan(
                        text: sUser.phone,
                        style: TextStyle(color: kSecondaryColor, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          GestureDetector(
            onTap: () => widget.controller.selectBirthDate(context),
            child: Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: getProportionateScreenWidth(5)),
                RichText(
                  text: TextSpan(
                    text: "Doğum Tarihi\n",
                    style: TextStyle(color: kPrimaryColor, fontSize: 17),
                    children: [
                      TextSpan(
                        text: sUser.birthDate == null
                            ? "-"
                            : DateFormat("dd.MM.yyyy").format(sUser.birthDate),
                        style: TextStyle(color: kSecondaryColor, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(60)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, NewPasswordScreen.routeName,
                    arguments: NewPasswordModel(false, sUser.email)),
                child: Text("Şifreni Değiştir",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.red[900],
                    )),
              ),
              Icon(
                Icons.arrow_right_rounded,
                color: Colors.red[900],
                size: 22,
              ),
            ],
          )
        ],
      ),
    );
  }
}

showModal(BuildContext context, ProfileController controller) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  child: Icon(Icons.close),
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      controller.newPhone = value;
                    },
                    inputFormatters: [
                      MaskTextInputFormatter(mask: "(###) ###-####")
                    ],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Telefon Numarası',
                    ),
                  ),
                  if (controller.showPhoneError)
                    Text(
                      "Lütfen numarayı kontrol ediniz.",
                      style: TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Kaydet"),
                      onPressed: () {
                        if (controller.newPhone.isNotEmpty &&
                            controller.newPhone.length == 14) {
                          //Navigator.pop(context);
                          UserService()
                              .updatePhone(controller.newPhone)
                              .then((value) {
                            AwesomeDialog(
                              context: context,
                              title: "Telefon",
                              dialogType: DialogType.SUCCES,
                              desc: value,
                              btnOkText: "Tamam",
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                            )..show();
                            sUser.phone = controller.newPhone;
                            controller.setState(() {});
                            controller.showPhoneError = false;
                            controller.newPhone = "";
                          });
                        } else {
                          controller.showPhoneError = true;
                          Navigator.pop(context);
                          showModal(context, controller);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

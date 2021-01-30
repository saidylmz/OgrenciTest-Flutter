import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:otsappmobile/models/user_model.dart';

import '../constants.dart';

class UserService {
  Client client = Client();

  Future<String> sendPasswordCode(String email) async {
    final response = await client.post(
      "$apiUrl/Users/SendPasswordCode",
      headers: {"content-type": "application/json"},
      body: (json.encode({"Email": email})),
    );
    return response.body;
  }

  Future<String> updatePassword(
      String email, String oldPass, String newPass) async {
    final response = await client.post(
      "$apiUrl/Users/UpdatePassword",
      headers: {"content-type": "application/json"},
      body: (json.encode(
          {"Email": email, "OldPassword": oldPass, "NewPassword": newPass})),
    );
    return response.body;
  }

  Future<UserModel> getUserById(int userId) async {
    final response = await client.post(
      "$apiUrl/Users/GetUserById",
      headers: {"content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + sToken },
      body: (json.encode({"value": userId})),
    );
    if (response.statusCode == 200) return userModelFromJson(response.body);
    return UserModel();
  }
}

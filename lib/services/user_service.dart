import 'dart:convert';

import 'package:http/http.dart';

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
}

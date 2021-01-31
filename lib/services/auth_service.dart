import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:otsappmobile/models/login_model.dart';

import '../constants.dart';

class AuthService {
  Client client = Client();

  Future<LoginModel> login(String email, String password) async {
    final response = await client.post(
      "$apiUrl/Auth/Login",
      headers: {"content-type": "application/json"},
      body: (json.encode({ "Email": email, "Password": password })),
    );
      print(response.body);
    if (response.statusCode == 200) {
      return loginModelFromJson(response.body);
    } else {
      return LoginModel(error: response.body);
    }
  }

  // Future<bool> createProfile(Profile data) async {
  //   final response = await client.post(
  //     "$baseUrl/api/profile",
  //     headers: {"content-type": "application/json"},
  //     body: profileToJson(data),
  //   );
  //   if (response.statusCode == 201) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // Future<bool> updateProfile(Profile data) async {
  //   final response = await client.put(
  //     "$baseUrl/api/profile/${data.id}",
  //     headers: {"content-type": "application/json"},
  //     body: profileToJson(data),
  //   );
  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // Future<bool> deleteProfile(int id) async {
  //   final response = await client.delete(
  //     "$baseUrl/api/profile/$id",
  //     headers: {"content-type": "application/json"},
  //   );
  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}

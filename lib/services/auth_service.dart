import 'dart:convert';
import 'package:http/http.dart' show Client;

import '../models/login_model.dart';
import '../constants.dart';

class AuthService {
  Client client = Client();

  Future<LoginModel> login(String email, String password) async {
    final response = await client.post(
      "$apiUrl/Auth/Login",
      headers: {"content-type": "application/json"},
      body: (json.encode({ "Email": email, "Password": password })),
    );
    if (response.statusCode == 200) {
      return loginModelFromJson(response.body);
    } else {
      return LoginModel(error: response.body);
    }
  }
}

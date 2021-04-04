import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';
import 'package:otsappmobile/models/scoreboard_model.dart';
import 'package:otsappmobile/models/user_statistic_model.dart';

import '../models/user_model.dart';
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
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + sToken
      },
      body: (json.encode({"value": userId})),
    );
    if (response.statusCode == 200) return userModelFromJson(response.body);
    return UserModel();
  }

  Future<UserStatisticModel> getUserStatistic() async {
    final response = await client.post(
      "$apiUrl/UserTests/GetUserStatistic",
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + sToken
      },
      body: (json.encode({"value": sUserID})),
    );
    if (response.statusCode == 200)
      return userStatisticModelFromJson(response.body);
    return null;
  }

  Future<List<UserModel>> getMessageUserList() async {
    final response = await client.post(
      "$apiUrl/Users/GetMessageUserList",
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + sToken
      },
      body: (json.encode({"value": sUserID})),
    );
    if (response.statusCode == 200) return userModelListFromJson(response.body);
    return null;
  }

  Future<ScoreBoardModel> getScoreBoardStatistic() async {
    final response = await client.post(
      "$apiUrl/Dashboard/GetScoreBoardData",
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + sToken
      },
      body: (json.encode({"value": sUserID})),
    );
    if (response.statusCode == 200)
      return scoreBoardModelFromJson(response.body);
    return null;
  }

  Future<String> updatePhone(String phone) async {
    final response = await client.post(
      "$apiUrl/Users/UpdatePhone",
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + sToken
      },
      body: (json.encode({"UserId": sUserID, "Phone": phone})),
    );
    return response.body;
  }

  Future<String> updateBirthDate(String birthDate) async {
    final response = await client.post(
      "$apiUrl/Users/UpdateBirthDate",
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + sToken
      },
      body: (json.encode({"UserId": sUserID, "Phone": birthDate})),
    );
    return response.body;
  }

  Future<String> updateImage(String base64) async {
    final response = await client.post(
      "$apiUrl/Users/UpdateUserImage",
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + sToken
      },
      body: (json.encode({"UserId": sUserID, "Image": base64})),
    );
    return response.body;
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:otsappmobile/models/get_user_test_model.dart';
import 'package:otsappmobile/models/test_detail.dart';
import 'package:otsappmobile/models/test_home_model.dart';
import 'package:otsappmobile/models/test_question_model.dart';

import '../constants.dart';

class TestService {
  Client client = Client();

  Future<List<TestHomeModel>> getUserTests(GetUserTest model) async {
    final response = await client.post(
      "$apiUrl/UserTests/GetUserTests",
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + sToken
      },
      body: (getUserTestModelToJson(model)),
    );
    if (response.statusCode == 200) {
      return testHomeModelFromJson(response.body);
    }
    return null;
  }

  Future<TestDetailModel> getTestDetail(int testId) async {
    final response = await client.post(
      "$apiUrl/Tests/GetTestById",
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + sToken
      },
      body: (json.encode({"value": testId})),
    );
    if (response.statusCode == 200) {
      return testDetailFromJson(response.body);
    }
    return null;
  }
  Future<List<TestQuestionModel>> getTestQuestions(int testId) async {
    final response = await client.post(
      "$apiUrl/TestQuestions/GetAllTestQuestions",
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + sToken
      },
      body: (json.encode({"value": testId})),
    );
    if (response.statusCode == 200) {
      return testQuestionModelFromJson(response.body);
    }
    return null;
  }
}

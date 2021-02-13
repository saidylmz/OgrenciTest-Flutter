import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:otsappmobile/models/test_answers_statistic_model.dart';
import 'package:otsappmobile/models/user_test_info_model.dart';

import '../models/test_answer.dart';
import '../models/test_detail.dart';
import '../models/test_home_model.dart';
import '../models/test_question_model.dart';
import '../constants.dart';

class TestService {
  Client client = Client();

  Future<List<TestHomeModel>> getUserTests(int userId) async {
    final response = await client.post(
      "$apiUrl/UserTests/GetUserTestsByUserId",
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + sToken
      },
      body: (json.encode({"value" : userId})),
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

  Future<String> addTestAnswers(List<TestAnswerModel> testAnswerModel) async {
    final response = await client.post(
      "$apiUrl/TestQuestions/AddTestAnswers",
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + sToken
      },
      body: (addTestAnswersModelToJson(testAnswerModel)),
    );
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }
  Future<TestAnswerStatisticModel> getTestAnswerStatistic() async {
    final response = await client.post(
      "$apiUrl/TestQuestions/GetTestAnswerStatistic",
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + sToken
      },
      body: (json.encode({"value": sUserID})),
    );
    if (response.statusCode == 200) {
      return testAnswerStatisticFromJson(response.body);
    }
    return null;
  }
  Future<UserTestInfoModel> getUserTestInfo(int testId) async {
    final response = await client.post(
      "$apiUrl/UserTests/GetUserTestByTestId",
      headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + sToken
      },
      body: (json.encode({"value": testId, "value2": sUserID})),
    );
    if (response.statusCode == 200) {
      return userTestInfoModelFromJson(response.body);
    }
    return null;
  }
}

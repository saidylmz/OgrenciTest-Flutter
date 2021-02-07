import 'dart:convert';
String addTestAnswersModelToJson(List<TestAnswerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestAnswerModel {
  TestAnswerModel(
      {this.testQuestionId, this.answer, this.createdAt, this.userId});

  int testQuestionId;
  String answer;
  DateTime createdAt;
  int userId;

  Map<String, dynamic> toJson() => {
        "TestQuestionId": testQuestionId,
        "Answer": answer,
        "CreatedAt": createdAt.toIso8601String(),
        "UserId": userId,
      };
}

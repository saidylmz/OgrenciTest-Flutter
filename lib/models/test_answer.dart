import 'dart:convert';

String addTestAnswersModelToJson(List<TestAnswerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<TestAnswerModel> testAnswerModelFromJson(String str) => List<TestAnswerModel>.from(json.decode(str).map((x) => TestAnswerModel.fromJson(x)));

class TestAnswerModel {
  TestAnswerModel(
      {this.testQuestionId,
      this.answer,
      this.createdAt,
      this.userId,
      this.testId});

  int testQuestionId;
  String answer;
  DateTime createdAt;
  int userId;
  int testId;

  Map<String, dynamic> toJson() => {
        "TestQuestionId": testQuestionId,
        "Answer": answer,
        "CreatedAt": createdAt.toIso8601String(),
        "UserId": userId,
        "TestId": testId,
      };

      factory TestAnswerModel.fromJson(Map<String, dynamic> json) => TestAnswerModel(
        testQuestionId: json["TestQuestionId"],
        answer: json["Answer"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        userId: json["UserId"],
        testId: json["TestId"],
    );
}

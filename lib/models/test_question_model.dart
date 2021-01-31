import 'dart:convert';

List<TestQuestionModel> testQuestionModelFromJson(String str) =>
    List<TestQuestionModel>.from(
        json.decode(str).map((x) => TestQuestionModel.fromJson(x)));

String testQuestionModelToJson(List<TestQuestionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestQuestionModel {
  TestQuestionModel({
    this.id,
    this.questionBody,
    this.questionA,
    this.questionB,
    this.questionC,
    this.questionD,
    this.questionE,
    this.correctAnswer,
    this.isActive,
    this.testId,
  });

  int id;
  String questionBody;
  String questionA;
  String questionB;
  String questionC;
  String questionD;
  String questionE;
  String correctAnswer;
  bool isActive;
  int testId;

  factory TestQuestionModel.fromJson(Map<String, dynamic> json) =>
      TestQuestionModel(
        id: json["Id"],
        questionBody: json["QuestionBody"],
        questionA: json["QuestionA"],
        questionB: json["QuestionB"],
        questionC: json["QuestionC"],
        questionD: json["QuestionD"],
        questionE: json["QuestionE"],
        correctAnswer: json["CorrectAnswer"],
        isActive: json["IsActive"],
        testId: json["TestId"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "QuestionBody": questionBody,
        "QuestionA": questionA,
        "QuestionB": questionB,
        "QuestionC": questionC,
        "QuestionD": questionD,
        "QuestionE": questionE,
        "CorrectAnswer": correctAnswer,
        "IsActive": isActive,
        "TestId": testId,
      };
}

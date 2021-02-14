// To parse this JSON data, do
//
//     final userStatisticModel = userStatisticModelFromJson(jsonString);

import 'dart:convert';

UserStatisticModel userStatisticModelFromJson(String str) => UserStatisticModel.fromJson(json.decode(str));

String userStatisticModelToJson(UserStatisticModel data) => json.encode(data.toJson());

class UserStatisticModel {
    UserStatisticModel({
        this.completedTest,
        this.uncompletedTest,
        this.questionCount,
        this.correctQuestionCount,
        this.wrongQuestionCount,
        this.tests,
        this.newMessageCount,
        this.teacherFullName,
        this.classroom,
        this.classroomBranch,
    });

    int completedTest;
    int uncompletedTest;
    int questionCount;
    int correctQuestionCount;
    int wrongQuestionCount;
    List<Test> tests;
    int newMessageCount;
    String teacherFullName;
    int classroom;
    String classroomBranch;

    factory UserStatisticModel.fromJson(Map<String, dynamic> json) => UserStatisticModel(
        completedTest: json["CompletedTest"],
        uncompletedTest: json["UncompletedTest"],
        questionCount: json["QuestionCount"],
        correctQuestionCount: json["CorrectQuestionCount"],
        wrongQuestionCount: json["WrongQuestionCount"],
        tests: List<Test>.from(json["Tests"].map((x) => Test.fromJson(x))),
        newMessageCount: json["NewMessageCount"],
        teacherFullName: json["TeacherFullName"],
        classroom: json["Classroom"],
        classroomBranch: json["ClassroomBranch"],
    );

    Map<String, dynamic> toJson() => {
        "CompletedTest": completedTest,
        "UncompletedTest": uncompletedTest,
        "QuestionCount": questionCount,
        "CorrectQuestionCount": correctQuestionCount,
        "WrongQuestionCount": wrongQuestionCount,
        "Tests": List<dynamic>.from(tests.map((x) => x.toJson())),
        "NewMessageCount": newMessageCount,
        "TeacherFullName": teacherFullName,
        "Classroom": classroom,
        "ClassroomBranch": classroomBranch,
    };
}

class Test {
    Test({
        this.startDate,
        this.endDate,
        this.isCompleted,
        this.testName,
        this.lessonName,
        this.lessonSubjectName,
        this.testQuestionCount,
        this.isActive,
        this.testId,
    });

    DateTime startDate;
    DateTime endDate;
    bool isCompleted;
    String testName;
    String lessonName;
    String lessonSubjectName;
    int testQuestionCount;
    bool isActive;
    int testId;

    factory Test.fromJson(Map<String, dynamic> json) => Test(
        startDate: DateTime.parse(json["StartDate"]),
        endDate: DateTime.parse(json["EndDate"]),
        isCompleted: json["IsCompleted"],
        testName: json["TestName"],
        lessonName: json["LessonName"],
        lessonSubjectName: json["LessonSubjectName"],
        testQuestionCount: json["TestQuestionCount"],
        isActive: json["IsActive"],
        testId: json["TestId"],
    );

    Map<String, dynamic> toJson() => {
        "StartDate": startDate.toIso8601String(),
        "EndDate": endDate.toIso8601String(),
        "IsCompleted": isCompleted,
        "TestName": testName,
        "LessonName": lessonName,
        "LessonSubjectName": lessonSubjectName,
        "TestQuestionCount": testQuestionCount,
        "IsActive": isActive,
        "TestId": testId,
    };
}

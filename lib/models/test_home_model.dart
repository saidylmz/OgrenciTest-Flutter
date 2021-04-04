import 'dart:convert';

List<TestHomeModel> testHomeModelFromJson(String str) => List<TestHomeModel>.from(json.decode(str).map((x) => TestHomeModel.fromJson(x)));

String testHomeModelToJson(List<TestHomeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestHomeModel {
    TestHomeModel({
        this.students,
        this.lessons,
        this.lessonSubjects,
        this.startDate,
        this.endDate,
        this.studentId,
        this.lessonId,
        this.lessonSubjectId,
        this.testName,
        this.lessonName,
        this.lessonSubjectName,
        this.studentName,
        this.testCreatedName,
        this.testQuestionCount,
        this.isActive,
        this.isCompleted,
        this.description,
        this.createdAt,
        this.testId,
    });

    dynamic students;
    dynamic lessons;
    dynamic lessonSubjects;
    DateTime startDate;
    DateTime endDate;
    dynamic studentId;
    dynamic lessonId;
    dynamic lessonSubjectId;
    String testName;
    String lessonName;
    String lessonSubjectName;
    String studentName;
    String testCreatedName;
    int testQuestionCount;
    bool isActive;
    bool isCompleted;
    dynamic description;
    DateTime createdAt;
    int testId;

    factory TestHomeModel.fromJson(Map<String, dynamic> json) => TestHomeModel(
        students: json["Students"],
        lessons: json["Lessons"],
        lessonSubjects: json["LessonSubjects"],
        startDate: DateTime.parse(json["StartDate"]),
        endDate: DateTime.parse(json["EndDate"]),
        studentId: json["StudentId"],
        lessonId: json["LessonId"],
        lessonSubjectId: json["LessonSubjectId"],
        testName: json["TestName"],
        lessonName: json["LessonName"],
        lessonSubjectName: json["LessonSubjectName"],
        studentName: json["StudentName"],
        testCreatedName: json["TestCreatedName"],
        testQuestionCount: json["TestQuestionCount"],
        isActive: json["IsActive"],
        isCompleted: json["IsCompleted"],
        description: json["Description"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        testId: json["TestId"],
    );

    Map<String, dynamic> toJson() => {
        "Students": students,
        "Lessons": lessons,
        "LessonSubjects": lessonSubjects,
        "StartDate": startDate.toIso8601String(),
        "EndDate": endDate.toIso8601String(),
        "StudentId": studentId,
        "LessonId": lessonId,
        "LessonSubjectId": lessonSubjectId,
        "TestName": testName,
        "LessonName": lessonName,
        "LessonSubjectName": lessonSubjectName,
        "StudentName": studentName,
        "TestCreatedName": testCreatedName,
        "TestQuestionCount": testQuestionCount,
        "IsActive": isActive,
        "IsCompleted": isCompleted,
        "Description": description,
        "CreatedAt": createdAt.toIso8601String(),
        "TestId": testId,
    };
}
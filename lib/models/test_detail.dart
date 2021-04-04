import 'dart:convert';

TestDetailModel testDetailFromJson(String str) => TestDetailModel.fromJson(json.decode(str));

class TestDetailModel {
    TestDetailModel({
        this.id,
        this.name,
        this.description,
        this.createdUserId,
        this.createdUser,
        this.createdAt,
        this.questionCount,
        this.lessonId,
        this.lessonSubjectId,
        this.isActive,
        this.lessons,
        this.lessonSubjects,
        this.testQuestions,
        this.testTime,
        this.testCategoryName
    });

    int id;
    String name;
    dynamic description;
    int createdUserId;
    CreatedUser createdUser;
    DateTime createdAt;
    int questionCount;
    int lessonId;
    int lessonSubjectId;
    bool isActive;
    List<Lesson> lessons;
    List<Lesson> lessonSubjects;
    List<TestQuestion> testQuestions;
    int testTime;
    String testCategoryName;

    factory TestDetailModel.fromJson(Map<String, dynamic> json) => TestDetailModel(
        id: json["Id"],
        name: json["Name"],
        description: json["Description"],
        createdUserId: json["CreatedUserId"],
        createdUser: CreatedUser.fromJson(json["CreatedUser"]),
        createdAt: DateTime.parse(json["CreatedAt"]),
        questionCount: json["QuestionCount"],
        lessonId: json["LessonId"],
        lessonSubjectId: json["LessonSubjectId"],
        isActive: json["IsActive"],
        lessons: List<Lesson>.from(json["Lessons"].map((x) => Lesson.fromJson(x))),
        lessonSubjects: List<Lesson>.from(json["LessonSubjects"].map((x) => Lesson.fromJson(x))),
        testQuestions: List<TestQuestion>.from(json["TestQuestions"].map((x) => TestQuestion.fromJson(x))),
        testTime: json["TestTime"],
        testCategoryName: json["TestCategoryName"],
    );
}

class CreatedUser {
    CreatedUser({
        this.id,
        this.userName,
        this.userSurName,
        this.createdAt,
        this.createdUserId,
        this.email,
        this.phone,
        this.isActive,
        this.gender,
        this.operationClaimId,
        this.classroomId,
        this.classroomBranchId,
    });

    int id;
    String userName;
    String userSurName;
    DateTime createdAt;
    int createdUserId;
    String email;
    String phone;
    int errorPasswordCount;
    bool lockStatus;
    dynamic lockTime;
    bool isActive;
    bool gender;
    int operationClaimId;
    dynamic classroomId;
    dynamic classroomBranchId;

    factory CreatedUser.fromJson(Map<String, dynamic> json) => CreatedUser(
        id: json["Id"],
        userName: json["UserName"],
        userSurName: json["UserSurName"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        createdUserId: json["CreatedUserId"],
        email: json["Email"],
        phone: json["Phone"],
        isActive: json["IsActive"],
        gender: json["Gender"],
        operationClaimId: json["OperationClaimId"],
        classroomId: json["ClassroomId"],
        classroomBranchId: json["ClassroomBranchId"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "UserName": userName,
        "UserSurName": userSurName,
        "CreatedAt": createdAt.toIso8601String(),
        "CreatedUserId": createdUserId,
        "Email": email,
        "Phone": phone,
        "ErrorPasswordCount": errorPasswordCount,
        "IsActive": isActive,
        "Gender": gender,
        "OperationClaimId": operationClaimId,
        "ClassroomId": classroomId,
        "ClassroomBranchId": classroomBranchId,
    };
}

class Lesson {
    Lesson({
        this.id,
        this.name,
        this.isActive,
        this.lessonId,
    });

    int id;
    String name;
    bool isActive;
    int lessonId;

    factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["Id"],
        name: json["Name"],
        isActive: json["IsActive"],
        lessonId: json["LessonId"] == null ? null : json["LessonId"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "IsActive": isActive,
        "LessonId": lessonId == null ? null : lessonId,
    };
}

class TestQuestion {
    TestQuestion({
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

    factory TestQuestion.fromJson(Map<String, dynamic> json) => TestQuestion(
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

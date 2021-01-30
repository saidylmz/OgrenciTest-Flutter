
import 'dart:convert';

String getUserTestModelToJson(GetUserTest data) => json.encode(data.toJson());

class GetUserTest {

  DateTime startDate, endDate;
  int studentId, lessonId, lessonSubjectId;

  GetUserTest({
    this.startDate,
    this.endDate,
    this.studentId,
    this.lessonId,
    this.lessonSubjectId,
  });

   Map<String, dynamic> toJson() => {
        "StartDate": startDate.toIso8601String(),
        "EndDate": endDate.toIso8601String(),
        "StudentId": studentId,
        "LessonId": lessonId,
        "LessonSubjectId": lessonSubjectId,
    };
}

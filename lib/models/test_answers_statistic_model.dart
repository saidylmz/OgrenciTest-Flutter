import 'dart:convert';

TestAnswerStatisticModel testAnswerStatisticFromJson(String str) => TestAnswerStatisticModel.fromJson(json.decode(str));

String testAnswerStatisticToJson(TestAnswerStatisticModel data) => json.encode(data.toJson());

class TestAnswerStatisticModel {
    TestAnswerStatisticModel({
        this.dayCorrect,
        this.dayWrong,
        this.dayEmpty,
        this.weekCorrect,
        this.weekWrong,
        this.weekEmpty,
        this.totalCorrect,
        this.totalWrong,
        this.totalEmpty,
    });

    int dayCorrect;
    int dayWrong;
    int dayEmpty;
    int weekCorrect;
    int weekWrong;
    int weekEmpty;
    int totalCorrect;
    int totalWrong;
    int totalEmpty;

    factory TestAnswerStatisticModel.fromJson(Map<String, dynamic> json) => TestAnswerStatisticModel(
        dayCorrect: json["DayCorrect"],
        dayWrong: json["DayWrong"],
        dayEmpty: json["DayEmpty"],
        weekCorrect: json["WeekCorrect"],
        weekWrong: json["WeekWrong"],
        weekEmpty: json["WeekEmpty"],
        totalCorrect: json["TotalCorrect"],
        totalWrong: json["TotalWrong"],
        totalEmpty: json["TotalEmpty"],
    );

    Map<String, dynamic> toJson() => {
        "DayCorrect": dayCorrect,
        "DayWrong": dayWrong,
        "DayEmpty": dayEmpty,
        "WeekCorrect": weekCorrect,
        "WeekWrong": weekWrong,
        "WeekEmpty": weekEmpty,
        "TotalCorrect": totalCorrect,
        "TotalWrong": totalWrong,
        "TotalEmpty": totalEmpty,
    };
}

import 'dart:convert';

UserTestInfoModel userTestInfoModelFromJson(String str) => UserTestInfoModel.fromJson(json.decode(str));

String userTestInfoModelToJson(UserTestInfoModel data) => json.encode(data.toJson());

class UserTestInfoModel {
    UserTestInfoModel({
        this.startDate,
        this.endDate,
        this.isCompleted,
    });

    DateTime startDate;
    DateTime endDate;
    bool isCompleted;

    factory UserTestInfoModel.fromJson(Map<String, dynamic> json) => UserTestInfoModel(
        startDate: DateTime.parse(json["StartDate"]),
        endDate: DateTime.parse(json["EndDate"]),
        isCompleted: json["IsCompleted"],
    );

    Map<String, dynamic> toJson() => {
        "StartDate": startDate.toIso8601String(),
        "EndDate": endDate.toIso8601String(),
        "IsCompleted": isCompleted,
    };
}

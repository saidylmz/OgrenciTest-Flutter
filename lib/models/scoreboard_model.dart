import 'dart:convert';

ScoreBoardModel scoreBoardModelFromJson(String str) => ScoreBoardModel.fromJson(json.decode(str));

String scoreBoardModelToJson(ScoreBoardModel data) => json.encode(data.toJson());

class ScoreBoardModel {
    ScoreBoardModel({
        this.victories,
        this.questionCounts,
        this.classRooms,
    });

    List<ClassRoom> victories;
    List<ClassRoom> questionCounts;
    List<ClassRoom> classRooms;

    factory ScoreBoardModel.fromJson(Map<String, dynamic> json) => ScoreBoardModel(
        victories: List<ClassRoom>.from(json["Victories"].map((x) => ClassRoom.fromJson(x))),
        questionCounts: List<ClassRoom>.from(json["QuestionCounts"].map((x) => ClassRoom.fromJson(x))),
        classRooms: List<ClassRoom>.from(json["ClassRooms"].map((x) => ClassRoom.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Victories": List<dynamic>.from(victories.map((x) => x.toJson())),
        "QuestionCounts": List<dynamic>.from(questionCounts.map((x) => x.toJson())),
        "ClassRooms": List<dynamic>.from(classRooms.map((x) => x.toJson())),
    };
}

class ClassRoom {
    ClassRoom({
        this.userId,
        this.userNameSurname,
        this.image,
        this.value,
    });

    int userId;
    String userNameSurname;
    String image;
    int value;

    factory ClassRoom.fromJson(Map<String, dynamic> json) => ClassRoom(
        userId: json["UserId"],
        userNameSurname: json["UserNameSurname"],
        image: json["Image"],
        value: json["Value"],
    );

    Map<String, dynamic> toJson() => {
        "UserId": userId,
        "UserNameSurname": userNameSurname,
        "Image": image,
        "Value": value,
    };
}

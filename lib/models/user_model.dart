import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.id,
        this.userName,
        this.userSurName,
        this.createdAt,
        this.createdUserId,
        this.updatedAt,
        this.updatedUserId,
        this.email,
        this.phone,
        this.errorPasswordCount,
        this.lockStatus,
        this.lockTime,
        this.lastLogInDate,
        this.lastLogOutDate,
        this.passwordHash,
        this.passwordSalt,
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
    DateTime updatedAt;
    int updatedUserId;
    String email;
    String phone;
    int errorPasswordCount;
    bool lockStatus;
    dynamic lockTime;
    DateTime lastLogInDate;
    DateTime lastLogOutDate;
    String passwordHash;
    String passwordSalt;
    bool isActive;
    bool gender;
    int operationClaimId;
    dynamic classroomId;
    dynamic classroomBranchId;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["Id"],
        userName: json["UserName"],
        userSurName: json["UserSurName"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        createdUserId: json["CreatedUserId"],
        updatedAt: DateTime.parse(json["UpdatedAt"]),
        updatedUserId: json["UpdatedUserId"],
        email: json["Email"],
        phone: json["Phone"],
        errorPasswordCount: json["ErrorPasswordCount"],
        lockStatus: json["LockStatus"],
        lockTime: json["LockTime"],
        lastLogInDate: DateTime.parse(json["LastLogInDate"]),
        lastLogOutDate: DateTime.parse(json["LastLogOutDate"]),
        passwordHash: json["PasswordHash"],
        passwordSalt: json["PasswordSalt"],
        isActive: json["IsActive"],
        gender: json["Gender"] ?? true,
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
        "UpdatedAt": updatedAt.toIso8601String(),
        "UpdatedUserId": updatedUserId,
        "Email": email,
        "Phone": phone,
        "ErrorPasswordCount": errorPasswordCount,
        "LockStatus": lockStatus,
        "LockTime": lockTime,
        "LastLogInDate": lastLogInDate.toIso8601String(),
        "LastLogOutDate": lastLogOutDate.toIso8601String(),
        "PasswordHash": passwordHash,
        "PasswordSalt": passwordSalt,
        "IsActive": isActive,
        "Gender": gender,
        "OperationClaimId": operationClaimId,
        "ClassroomId": classroomId,
        "ClassroomBranchId": classroomBranchId,
    };
}

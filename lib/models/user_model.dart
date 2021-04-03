import 'dart:convert';

List<UserModel> userModelListFromJson(String str) =>
    List<UserModel>.from(
        json.decode(str).map((x) => UserModel.fromJsonForMessage(x)));

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
    UserModel({
        this.id,
        this.userName,
        this.userSurName,
        this.createdAt,
        this.createdUserId,
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
        this.birthDate,
        this.image
    });

    int id;
    String userName;
    String userSurName;
    DateTime createdAt;
    int createdUserId;
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
    DateTime birthDate;
    String image;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["Id"],
        userName: json["UserName"],
        userSurName: json["UserSurName"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        createdUserId: json["CreatedUserId"],
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
        birthDate: json["BirthDate"] == null ? null : DateTime.parse(json["BirthDate"]),
        image: json["Image"],
    );
    factory UserModel.fromJsonForMessage(Map<String, dynamic> json) => UserModel(
        id: json["Id"],
        userName: json["UserName"],
        userSurName: json["UserSurName"],
        operationClaimId: json["OperationClaimId"],
        classroomId: json["ClassroomId"],
        image: json["Image"],
        birthDate: json["BirthDate"] == null ? DateTime.now() : DateTime.parse(json["BirthDate"]),
    );
}

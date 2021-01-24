import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        this.userId,
        this.token,
        this.expiration,
        this.error
    });

    int userId;
    String token;
    DateTime expiration;
    String error;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        userId: json["UserId"],
        token: json["Token"],
        expiration: DateTime.parse(json["Expiration"]),
        error: ""
    );

    Map<String, dynamic> toJson() => {
        "UserId": userId,
        "Token": token,
        "Expiration": expiration.toIso8601String(),
    };
}
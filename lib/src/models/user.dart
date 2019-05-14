import 'dart:convert';

UserModel UserFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool success;
  UserData data;
  String message;

  UserModel({this.success, this.data, this.message});

  factory UserModel.fromJson(Map<String, dynamic> json) => new UserModel(
      success: json["success"],
      data: UserData.fromJson(json["data"]),
      message: json['message']);

  Map<String, dynamic> toJson() =>
      {"success": success, "data": data.toJson(), "message": message};
}

class UserData {
  int id;
  String name;
  String email;
  int emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  UserData({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => new UserData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

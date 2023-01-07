import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

List<User> userFromJsonID(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJsonID(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNumber,
    required this.isManager,
  });

  User.getWithID({required this.userId, required this.name});

  final int userId;
  final String name;
  String email = "";
  String password = "";
  String address = "";
  String phoneNumber = "";
  int isManager = 0;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        isManager: json["is_manager"],
      );

  factory User.fromJsonID(Map<String, dynamic> json) => User.getWithID(
        userId: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "address": address,
        "phone_number": phoneNumber,
        "is_manager": isManager,
      };
}

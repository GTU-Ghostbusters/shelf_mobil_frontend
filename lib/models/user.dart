import 'dart:convert';

List<User> userFromMap(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromMap(x)));

String userToMap(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

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

  final int userId;
  final String name;
  final String email;
  final String password;
  final String address;
  final String phoneNumber;
  final bool isManager;

  factory User.fromMap(Map<String, dynamic> json) => User(
        userId: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        isManager: json["is_manager"],
      );

  Map<String, dynamic> toMap() => {
        "id": userId,
        "name": name,
        "email": email,
        "password": password,
        "address": address,
        "phone_number": phoneNumber,
        "is_manager": isManager,
      };
}

import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNumber,
    required this.isSuperuser,
    required this.isManager,
  });

  final String name;
  final String surname;
  final String email;
  final String password;
  final String address;
  final String phoneNumber;
  final bool isSuperuser;
  final bool isManager;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        isSuperuser: json["is_superuser"],
        isManager: json["is_manager"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "email": email,
        "password": password,
        "address": address,
        "phone_number": phoneNumber,
        "is_superuser": isSuperuser,
        "is_manager": isManager,
      };
}

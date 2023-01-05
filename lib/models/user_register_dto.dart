import 'dart:convert';

List<UserRegisterDto> userFromJson(String str) => List<UserRegisterDto>.from(
    json.decode(str).map((x) => UserRegisterDto.fromJson(x)));

String userToJson(List<UserRegisterDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserRegisterDto {
  UserRegisterDto({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  final String name;
  final String email;
  final String password;
  final String phoneNumber;

  factory UserRegisterDto.fromJson(Map<String, dynamic> json) =>
      UserRegisterDto(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "phone": phoneNumber,
      };
}

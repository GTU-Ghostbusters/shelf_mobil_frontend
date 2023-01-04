import 'dart:convert';

List<Adress> addressFromJson(String str) =>
    List<Adress>.from(json.decode(str).map((x) => Adress.fromJson(x)));

String addressToJson(List<Adress> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Adress {
  Adress({required this.name});

  String name;

  @override
  operator ==(other) => other is Adress && name == other.name;

  factory Adress.fromJson(Map<String, dynamic> json) => Adress(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

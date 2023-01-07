import 'dart:convert';

List<Author> authorFromJson(String str) =>
    List<Author>.from(json.decode(str).map((x) => Author.fromJson(x)));

String authorToJson(List<Author> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Author {
  Author({
    required this.name,
    required this.authorID,
  });

  Author.createNew({required this.name});
  
  final String name;
  int authorID = 0;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: json["name"],
        authorID: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

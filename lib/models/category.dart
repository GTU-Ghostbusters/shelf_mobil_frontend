import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category(
      {required this.title,
      required this.imagePath,
      required this.numberOfBooks});

  String title;
  String imagePath;
  int numberOfBooks;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      title: json["title"],
      imagePath: json["imagePath"],
      numberOfBooks: json["numberOfBooks"]);

  Map<String, dynamic> toJson() =>
      {"title": title, "imagePath": imagePath, "numberOfBooks": numberOfBooks};
}

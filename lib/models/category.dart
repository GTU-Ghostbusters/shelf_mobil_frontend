import 'dart:convert';

import 'package:shelf_mobil_frontend/services/api_service.dart';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category(
      {required this.categoryID,
      required this.title,
      required this.imagePath,
      required this.numberOfBooks});

  int categoryID;
  String title;
  String imagePath;
  int numberOfBooks;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      categoryID: json["id"],
      title: json["name"],
      imagePath: ApiConstants.baseUrlImg + json["image"],
      numberOfBooks: json["books_count"]);

  Map<String, dynamic> toJson() =>
      {"name": title, "image": imagePath, "books_count": numberOfBooks};
}

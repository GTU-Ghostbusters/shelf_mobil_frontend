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

  // API
  // factory Category.fromJson(Map<String, dynamic> json) => Category(
  //     title: json["name"],
  //     imagePath: '', //! json["image"]
  //     numberOfBooks: json["books_count"]);
  
  // TEST
  factory Category.fromJson(Map<String, dynamic> json) => Category(
      title: json["title"],
      imagePath: json["imagePath"], //! json["image"]
      numberOfBooks: json["numberOfBooks"],
  );

  Map<String, dynamic> toJson() =>
      {"name": title, "image": imagePath, "books_count": numberOfBooks};
}

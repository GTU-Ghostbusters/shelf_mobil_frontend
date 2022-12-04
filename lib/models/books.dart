// To parse this JSON data, do
//
//     final books = booksFromMap(jsonString);
import 'dart:convert';

List<Books> booksFromMap(String str) =>
    List<Books>.from(json.decode(str).map((x) => Books.fromMap(x)));

String booksToMap(List<Books> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Books {
  Books({
    required this.donator,
    required this.name,
    required this.author,
    required this.category,
    required this.numberOfBooks,
    required this.available,
    required this.bookAbstract,
  });

  final String donator;
  final String name;
  final String author;
  final String category;
  final int numberOfBooks;
  final bool available;
  final String bookAbstract;

  factory Books.fromMap(Map<String, dynamic> json) => Books(
        donator: json["donator"],
        name: json["name"],
        author: json["author"],
        category: json["category"],
        numberOfBooks: json["number_of_books"],
        available: json["available"],
        bookAbstract: json["abstract"],
      );

  Map<String, dynamic> toMap() => {
        "donator": donator,
        "name": name,
        "author": author,
        "category": category,
        "number_of_books": numberOfBooks,
        "available": available,
        "abstract": bookAbstract,
      };
}

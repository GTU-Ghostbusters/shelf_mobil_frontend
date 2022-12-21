import 'dart:convert';

List<Books> booksFromJson(String str) =>
    List<Books>.from(json.decode(str).map((x) => Books.fromJson(x)));

String booksToJson(List<Books> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Books {
  Books({
    required this.donator,
    required this.name,
    required this.author,
    required this.category,
    required this.numberOfBooks,
    required this.available,
    required this.bookAbstract,
    required this.image,
    required this.shipmentType,
  });

  String donator;
  String name;
  String author;
  String category;
  int numberOfBooks;
  bool available;
  String bookAbstract;
  String image;
  String shipmentType;

  factory Books.fromJson(Map<String, dynamic> json) => Books(
        donator: json["donator"],
        name: json["name"],
        author: json["author"],
        category: json["category"],
        numberOfBooks: json["number_of_books"],
        available: json["available"],
        bookAbstract: json["abstract"],
        image: json["images"],
        shipmentType: json["shipment_type"],
      );

  Map<String, dynamic> toJson() => {
        "donator": donator,
        "name": name,
        "author": author,
        "category": category,
        "number_of_books": numberOfBooks,
        "available": available,
        "abstract": bookAbstract,
        "image": image,
        "shipment_type": shipmentType
      };
}

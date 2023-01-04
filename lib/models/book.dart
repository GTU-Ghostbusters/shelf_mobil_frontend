import 'dart:convert';

List<Book> booksFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String booksToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Book({
    required this.donator,
    required this.name,
    required this.author,
    required this.category,
    required this.numberOfPages,
    required this.bookId,
    required this.available,
    required this.bookAbstract,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.shipmentType,
  });

  final String donator;
  final String name;
  final String author;
  final String category;
  final int numberOfPages;
  final int bookId;
  final bool available;
  final String bookAbstract;
  final String image1;
  final String image2;
  final String image3;
  final String shipmentType;

  @override
  operator ==(other) => other is Book && bookId == other.bookId;

  @override
  int get hashCode => Object.hash(bookId, name);

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        donator: json["donor"],
        name: json["name"],
        author: json["author"],
        category: json["category"],
        numberOfPages: json["page_count"],
        bookId: json["id"],
        available: json["available"],
        bookAbstract: json["abstract"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        shipmentType: json["shipment_type"],
      );

  Map<String, dynamic> toJson() => {
        "donor": donator,
        "name": name,
        "author": author,
        "category": category,
        "page_count": numberOfPages,
        "id": bookId,
        "available": available,
        "abstract": bookAbstract,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "shipment_type": shipmentType
      };
}

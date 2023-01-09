import 'dart:convert';

import 'package:shelf_mobil_frontend/services/api_service.dart';

List<Book> booksFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String booksToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Book({
    required this.bookId,
    required this.name,
    required this.donatorID,
    required this.author,
    required this.category,
    required this.numberOfPages,
    required this.available,
    required this.bookAbstract,
    required this.shipmentType,
    required this.image1,
    required this.image2,
    required this.image3,
  });

  Book.shareBook(
    this.name,
    this.donatorID,
    this.authorID,
    this.categoryID,
    this.numberOfPages,
    this.available,
    this.bookAbstract,
    this.shipmentType,
    this.image1,
    this.image2,
    this.image3,
  );

  int bookId = 0;
  final String name;
  final int donatorID;
  String donatorName = "";
  String author = "";
  int authorID = 0;
  String category = "";
  int categoryID = 0;
  final int numberOfPages;
  int available = 1;
  final String bookAbstract;
  final String shipmentType;
  final String image1;
  final String image2;
  final String image3;

  @override
  operator ==(other) =>
      other is Book &&
      bookId == other.bookId &&
      name == other.name &&
      author == other.author &&
      category == other.category &&
      available == other.available;
  @override
  int get hashCode => Object.hash(bookId, name, author, category, available);

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        donatorID: json['donor'],
        name: json["name"],
        author: json["author"],
        category: json["category"],
        numberOfPages: json["page_count"],
        bookId: json["id"],
        available: json["available"],
        bookAbstract: json["abstract"],
        image1: ApiConstants.baseUrlImg + json["image1"],
        image2: ApiConstants.baseUrlImg + json["image2"],
        image3: ApiConstants.baseUrlImg + json["image3"],
        shipmentType: json["shipment_type"] == "R" ? "Receiver" : "Sender",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "donor": donatorID,
        "author": authorID,
        "category": categoryID,
        "page_count": numberOfPages,
        "available": available,
        "abstract": bookAbstract,
        "shipment_type": shipmentType,
        "image1": image1,
        "image2": image2,
        "image3": image3,
      };
}

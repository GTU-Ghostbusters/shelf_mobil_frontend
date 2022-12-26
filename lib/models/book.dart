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
    required this.available,
    required this.bookAbstract,
    required this.image,
    required this.shipmentType,
  });

  String donator;
  String name;
  String author;
  String category;
  int numberOfPages;
  bool available;
  String bookAbstract;
  String image;
  String shipmentType;

  @override
  operator ==(other) =>
      other is Book &&
      donator == other.donator &&
      name == other.name &&
      author == other.author &&
      category == other.category &&
      numberOfPages == other.numberOfPages &&
      available == other.available &&
      bookAbstract == other.bookAbstract &&
      image == other.image &&
      shipmentType == other.shipmentType;
  @override
  int get hashCode => Object.hash(donator, name, author, category,
      numberOfPages, available, bookAbstract, image, shipmentType);

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        donator: json["donator"],
        name: json["name"],
        author: json["author"],
        category: json["category"],
        numberOfPages: json["number_of_books"],
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
        "number_of_books": numberOfPages,
        "available": available,
        "abstract": bookAbstract,
        "image": image,
        "shipment_type": shipmentType
      };
}

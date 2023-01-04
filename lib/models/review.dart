// To parse this JSON data, do
//
//     final review = reviewFromMap(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(String str) =>
    List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  Review({
    required this.id,
    required this.userId,
    required this.buyerId,
    required this.point,
    required this.review,
  });

  final int id;
  final int userId;
  final int buyerId;
  final int point;
  final String review;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["user_id"],
        buyerId: json["buyer_id"],
        point: json["point"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "buyer_id": buyerId,
        "point": point,
        "review": review,
      };
}

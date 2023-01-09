import 'dart:convert';

List<Address> addressFromJson(String str) =>
    List<Address>.from(json.decode(str).map((x) => Address.fromJson(x)));

String addressToJson(List<Address> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Address {
  Address(
      {required this.addressName,
      required this.city,
      required this.town,
      required this.openAddress,
      required this.phoneNumber});
  String addressName;
  String city;
  String town;
  String phoneNumber;
  String openAddress;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
      addressName: json["address_name"],
      city: json["city"],
      town: json["town"],
      phoneNumber: json["phone"],
      openAddress: json["address"]);

  Map<String, dynamic> toJson() => {
        "receiver_name": 82,
        "address_name": addressName,
        "city": city,
        "town": town,
        "address": openAddress,
        "phone": phoneNumber
      };
}

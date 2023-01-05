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
      addressName: json["name"],
      city: json["city"],
      town: json["town"],
      phoneNumber: json["phoneNumber"],
      openAddress: json["address"]);

  Map<String, dynamic> toJson() => {
        "name": addressName,
        "city": city,
        "town": town,
        "address": openAddress,
        "phoneNumber": phoneNumber
      };
}

// LOCAL DATA
List<City> citiesFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromMap(x)));

class City {
  City({
    required this.cityName,
    required this.townList,
  });

  final String cityName;
  final List<Town> townList;

  factory City.fromMap(Map<String, dynamic> json) => City(
        cityName: json["name"],
        townList: List<Town>.from(json["towns"].map((x) => Town.fromMap(x))),
      );
}

class Town {
  Town({required this.townName});

  final String townName;

  factory Town.fromMap(Map<String, dynamic> json) =>
      Town(townName: json["name"]);
}

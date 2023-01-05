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
      required this.openAddress});
  String addressName;
  String city;
  String town;
  String openAddress;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
      addressName: json["name"],
      city: json["city"],
      town: json["town"],
      openAddress: json["address"]);

  Map<String, dynamic> toJson() =>
      {"name": addressName, "city": city, "town": town, "address": openAddress};
}

List<City> citiesFromStaticJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

class City {
  City({required this.cityName, required this.townList});

  String cityName;
  List<Town> townList;

  factory City.fromJson(Map<String, dynamic> json) => City(
        cityName: json["name"],
        townList: List<dynamic>.from(json['towns'])
            .map((i) => Town.fromJson(i))
            .toList(),
      );
}

class Town {
  Town({required this.townName});
  String townName;
  factory Town.fromJson(Map<String, dynamic> json) => Town(
        townName: json["name"],
      );
}

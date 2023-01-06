import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shelf_mobil_frontend/models/address.dart';
import 'package:shelf_mobil_frontend/models/author.dart';

import 'package:shelf_mobil_frontend/models/book.dart';

class ApiConstants {
  static String baseUrl = 'https://hodikids.com/api';
  static String baseUrlImg = 'https://hodikids.com/';
  static String login = '/login';
  static String logout = '/logout';
  static String register = '/register';
  static String verifyEmail = '/verify-email';
  static String add = '/add';
  static String delete = '/delete';
  static String create = '/create';
  static String books = '/books';
  static String category = '/categories';
  static String author = '/authors';
  static String address = '/addresses';
  static String order = '/order';
  static String cart = '/cart';
}

class ApiService {
  String bearerToken = "Bearer 2|yAx5KiDejngz3WsLT4yN8JXP0CaSUIet1Xn11Crp";

  Map<String, String> get requestHeaders => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": bearerToken,
      };

  /* User Operations */
  Future<http.Response> login(String email, String password) async {
    return await http.post(Uri.parse(ApiConstants.baseUrl + ApiConstants.login),
        headers: requestHeaders,
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        }));
  }

  Future<http.Response> logout() async {
    return await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.logout),
        headers: requestHeaders);
  }

  Future<http.Response> register(
      String name, String email, String password, String phone) async {
    return await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.register),
        headers: requestHeaders,
        body: jsonEncode(<String, String>{
          "name": name,
          "email": email,
          "password": password,
          "phone": phone
        }));
  }

  Future<http.Response> verifyEmail(int id, String verificationCode) async {
    return await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.verifyEmail),
        headers: requestHeaders,
        body: jsonEncode(<String, String>{
          "user_id": id.toString(),
          "verification_code": verificationCode
        }));
  }

  Future<http.Response> addAdress(Address address) async {
    return await http.post(
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.address + ApiConstants.add),
        headers: requestHeaders,
        body: jsonEncode(address.toJson()));
  }

  Future<http.Response> createOrder(int id) async {
    return await http.post(
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.order + ApiConstants.create),
        headers: requestHeaders,
        body: jsonEncode(<String, int>{
          "address_id": id,
        }));
  }

  Future<http.Response> addCart(int id) async {
    return await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.cart + ApiConstants.add),
        headers: requestHeaders,
        body: jsonEncode(<String, int>{
          'book_id': id,
        }));
  }

  Future<http.Response> deleteCart(int id) async {
    return await http.post(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.cart}\\$id${ApiConstants.delete}'),
        headers: requestHeaders);
  }

  /* Book Operations */
  Future<http.Response> addBook(Book book) async {
    return await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.books + ApiConstants.add),
        headers: requestHeaders,
        body: jsonEncode(book.toJson()));
  }

  Future<http.Response> getBooks(
      String name, String author, String category) async {
    return await http.get(Uri.parse(ApiConstants.baseUrl + ApiConstants.books),
        headers: requestHeaders);
  }

  Future<http.Response> getBooksWithCategory(int categoryID) async {
    if (categoryID == 0) {
      return getAllBooks();
    } else {
      return await http.get(
          Uri.parse(
              "${ApiConstants.baseUrl}${ApiConstants.books}?category=$categoryID"),
          headers: requestHeaders);
    }
  }

  Future<http.Response> getAllBooks() async {
    var response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.books}?category="),
        headers: requestHeaders);
    return response;
  }

  /* Author Operations */
  Future<http.Response> getAuthors(Author author) async {
    return await http.get(Uri.parse(ApiConstants.baseUrl + ApiConstants.author),
        headers: requestHeaders);
  }

  Future<http.Response> addAuthor(Author book) async {
    return await http.post(
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.author + ApiConstants.add),
        headers: requestHeaders,
        body: jsonEncode(book.toJson()));
  }

  /* Category Operations */
  Future<http.Response> getCategories() async {
    return await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.category),
        headers: requestHeaders);
  }
}

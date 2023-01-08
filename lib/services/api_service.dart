import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shelf_mobil_frontend/models/address.dart';
import 'package:shelf_mobil_frontend/models/author.dart';

import 'package:shelf_mobil_frontend/models/book.dart';
import 'package:shelf_mobil_frontend/models/user.dart';
import 'package:shelf_mobil_frontend/pages/account_page.dart';

class ApiConstants {
  static String baseUrl = 'https://hodikids.com/api';
  static String baseUrlImg = 'https://hodikids.com/';
  static String login = '/login';
  static String logout = '/logout';
  static String register = '/register';
  static String verifyEmail = '/verify-email';
  static String resetPassword = '/password-reset';
  static String changePassword = '/change-password';
  static String add = '/add';
  static String delete = '/delete';
  static String create = '/create';
  static String update = '/update';
  static String user = '/user';
  static String users = '/users';
  static String reviews = '/reviews';
  static String books = '/books';
  static String favorites = '/favorites';
  static String category = '/categories';
  static String author = '/authors';
  static String address = '/addresses';
  static String order = '/order';
  static String cart = '/cart';
}

class ApiService {
  Map<String, String> get requestHeaders => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": AccountPage.getToken() != null
            ? "Bearer ${AccountPage.getToken()!}"
            : "",
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

  Future<http.Response> resetPassword(String email) async {
    return await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.resetPassword),
        headers: requestHeaders,
        body: jsonEncode(<String, String>{
          "email": email,
        }));
  }

  Future<http.Response> changePassword(
      int id, String resetCode, String newPassword) async {
    return await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.changePassword),
        headers: requestHeaders,
        body: jsonEncode(<String, String>{
          "user_id": id.toString(),
          "reset_code": resetCode,
          "password": newPassword,
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

  Future<http.Response> getLoggedUser() async {
    return await http.get(Uri.parse(ApiConstants.baseUrl + ApiConstants.user),
        headers: requestHeaders);
  }

  Future<http.Response> updateUser(User user) async {
    return await http.put(
        Uri.parse(
            "${ApiConstants.baseUrl}${ApiConstants.user}${user.userId}/${ApiConstants.update}"),
        headers: requestHeaders,
        body: jsonEncode(user.toJson()));
  }

  Future<http.Response> getUserList() async {
    return await http.get(Uri.parse(ApiConstants.baseUrl + ApiConstants.users),
        headers: requestHeaders);
  }

  /* Address Operations */
  Future<http.Response> addAdress(Address address) async {
    return await http.post(
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.address + ApiConstants.add),
        headers: requestHeaders,
        body: jsonEncode(address.toJson()));
  }

  /* Favorities Operations */
  Future<http.Response> getFavorities(int id) async {
    return await http.get(
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.order + ApiConstants.favorites),
        headers: requestHeaders);
  }

  Future<http.Response> addToFavorities(
      int userId, int bookId, int favId) async {
    return await http.post(
        Uri.parse(ApiConstants.baseUrl +
            ApiConstants.order +
            ApiConstants.favorites +
            ApiConstants.add),
        headers: requestHeaders,
        body: jsonEncode(<String, int>{
          "user_id": userId,
          "book_id": bookId,
          "id": favId,
        }));
  }

  /* Order Operations */
  Future<http.Response> createOrder(int id) async {
    return await http.post(
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.order + ApiConstants.create),
        headers: requestHeaders,
        body: jsonEncode(<String, int>{
          "address_id": id,
        }));
  }

  /* Cart Operations */
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
            '${ApiConstants.baseUrl}${ApiConstants.cart}/$id${ApiConstants.delete}'),
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
  Future<http.Response> getAuthors() async {
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

  /* Review Operations */
  Future<http.Response> getReviewList(int id) async {
    return await http.get(
        Uri.parse(
            "${ApiConstants.baseUrl}${ApiConstants.user}/$id${ApiConstants.reviews}"),
        headers: requestHeaders);
  }
}

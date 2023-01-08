import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shelf_mobil_frontend/models/address.dart';
import 'package:shelf_mobil_frontend/models/author.dart';

import 'package:shelf_mobil_frontend/models/book.dart';
import 'package:shelf_mobil_frontend/models/user.dart';
import 'package:shelf_mobil_frontend/pages/account_page.dart';

class ApiConstants {
  static const String baseUrl = 'https://hodikids.com/api';
  static const String baseUrlImg = 'https://hodikids.com/';
  static const String login = '/login';
  static const String logout = '/logout';
  static const String register = '/register';
  static const String verifyEmail = '/verify-email';
  static const String resetPassword = '/password-reset';
  static const String changePassword = '/change-password';
  static const String add = '/add';
  static const String delete = '/delete';
  static const String create = '/create';
  static const String update = '/update';
  static const String user = '/user';
  static const String users = '/users';
  static const String reviews = '/reviews';
  static const String books = '/books';
  static const String favorites = '/favorites';
  static const String category = '/categories';
  static const String author = '/authors';
  static const String address = '/addresses';
  static const String order = '/order';
  static const String cart = '/cart';
}

class ApiService {
  static Map<String, String> get requestHeaders => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": AccountPage.getToken() != null
            ? "Bearer ${AccountPage.getToken()!}"
            : "",
      };

  /* User Operations */
  static Future<http.Response> login(String email, String password) async {
    return await http.post(Uri.parse(ApiConstants.baseUrl + ApiConstants.login),
        headers: requestHeaders,
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        }));
  }

  static Future<http.Response> logout() async {
    return await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.logout),
        headers: requestHeaders);
  }

  static Future<http.Response> register(
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

  static Future<http.Response> resetPassword(String email) async {
    return await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.resetPassword),
        headers: requestHeaders,
        body: jsonEncode(<String, String>{
          "email": email,
        }));
  }

  static Future<http.Response> changePassword(
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

  static Future<http.Response> verifyEmail(
      int id, String verificationCode) async {
    return await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.verifyEmail),
        headers: requestHeaders,
        body: jsonEncode(<String, String>{
          "user_id": id.toString(),
          "verification_code": verificationCode
        }));
  }

  static Future<http.Response> getLoggedUser() async {
    return await http.get(Uri.parse(ApiConstants.baseUrl + ApiConstants.user),
        headers: requestHeaders);
  }

  static Future<http.Response> updateUser(User user) async {
    return await http.put(
        Uri.parse(
            "${ApiConstants.baseUrl}${ApiConstants.user}${user.userId}/${ApiConstants.update}"),
        headers: requestHeaders,
        body: jsonEncode(user.toJson()));
  }

  static Future<http.Response> getUserList() async {
    return await http.get(Uri.parse(ApiConstants.baseUrl + ApiConstants.users),
        headers: requestHeaders);
  }

  static Future<http.Response> getUser(int id) async {
    var response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.user}/$id"),
        headers: requestHeaders);
    print(response.statusCode);
    return response;
  }

  /* Address Operations */
  static Future<http.Response> addAdress(Address address) async {
    return await http.post(
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.address + ApiConstants.add),
        headers: requestHeaders,
        body: jsonEncode(address.toJson()));
  }

  /* Favorities Operations */
  static Future<http.Response> getFavorities() async {
    return await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.favorites),
        headers: requestHeaders);
  }

  static Future<http.Response> addToFavorities(int userId, int bookId) async {
    return await http.post(
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.favorites + ApiConstants.add),
        headers: requestHeaders,
        body: jsonEncode(<String, int>{
          "user_id": userId,
          "book_id": bookId,
        }));
  }

  static Future<http.Response> deleteFav(int id) async {
    return await http.post(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.favorites}/$id${ApiConstants.delete}'),
        headers: requestHeaders);
  }

  /* Order Operations */
  static Future<http.Response> createOrder(int id) async {
    return await http.post(
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.order + ApiConstants.create),
        headers: requestHeaders,
        body: jsonEncode(<String, int>{
          "address_id": id,
        }));
  }

  /* Cart Operations */
  static Future<http.Response> addCart(int id) async {
    return await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.cart + ApiConstants.add),
        headers: requestHeaders,
        body: jsonEncode(<String, int>{
          'book_id': id,
        }));
  }

  static Future<http.Response> deleteCart(int id) async {
    return await http.post(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.cart}/$id${ApiConstants.delete}'),
        headers: requestHeaders);
  }

  /* Book Operations */
  static Future<http.Response> addBook(Book book) async {
    return await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.books + ApiConstants.add),
        headers: requestHeaders,
        body: jsonEncode(book.toJson()));
  }

  static Future<http.Response> getBooks(
      String name, String author, String category) async {
    return await http.get(Uri.parse(ApiConstants.baseUrl + ApiConstants.books),
        headers: requestHeaders);
  }

  static Future<http.Response> getBookDetail(int bookId) async {
    return await http.get(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.books}/$bookId"),
        headers: requestHeaders);
  }

  static Future<http.Response> getBooksWithCategory(int categoryID) async {
    if (categoryID == 0) {
      return getAllBooks();
    } else {
      return await http.get(
          Uri.parse(
              "${ApiConstants.baseUrl}${ApiConstants.books}?category=$categoryID"),
          headers: requestHeaders);
    }
  }

  static Future<http.Response> getAllBooks() async {
    var response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.books}?category="),
        headers: requestHeaders);
    return response;
  }

  /* Author Operations */
  static Future<http.Response> getAuthors() async {
    return await http.get(Uri.parse(ApiConstants.baseUrl + ApiConstants.author),
        headers: requestHeaders);
  }

  static Future<http.Response> addAuthor(Author book) async {
    return await http.post(
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.author + ApiConstants.add),
        headers: requestHeaders,
        body: jsonEncode(book.toJson()));
  }

  /* Category Operations */
  static Future<http.Response> getCategories() async {
    return await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.category),
        headers: requestHeaders);
  }

  /* Review Operations */
  static Future<http.Response> getReviewList(int id) async {
    return await http.get(
        Uri.parse(
            "${ApiConstants.baseUrl}${ApiConstants.user}/$id${ApiConstants.reviews}"),
        headers: requestHeaders);
  }
}

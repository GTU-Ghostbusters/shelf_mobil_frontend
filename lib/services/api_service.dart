import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shelf_mobil_frontend/models/address.dart';
import 'package:shelf_mobil_frontend/models/author.dart';

import 'package:shelf_mobil_frontend/models/book.dart';

import '../models/category.dart';
import '../models/user.dart';

class ApiConstants {
  static String baseUrl = 'https://hodikids.com/api';
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
  Future<User> login(String email, String password) async {
    final response =
        await http.post(Uri.parse(ApiConstants.baseUrl + ApiConstants.login),
            headers: requestHeaders,
            body: jsonEncode(<String, String>{
              "email": email,
              "password": password,
            }));

    if (response.statusCode == 201) {
      // response contains access token and the user informations
      // save the access token for later use
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login.');
    }
  }

  Future<bool> logout() async {
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.logout),
        headers: requestHeaders);

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to logout.');
    }
  }

  Future<bool> register(String name, String email, String password) async {
    final response =
        await http.post(Uri.parse(ApiConstants.baseUrl + ApiConstants.register),
            headers: requestHeaders,
            body: jsonEncode(<String, String>{
              "name": name,
              "email": email,
              "password": password,
            }));

    if (response.statusCode == 201) {
      // after registeration user should verify provided email for login
      return true;
    } else {
      throw Exception('Failed to register.');
    }
  }

  Future<bool> verifyEmail(int id, String verificationCode) async {
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.verifyEmail),
        headers: requestHeaders,
        body: jsonEncode(<String, String>{
          "user_id": id.toString(),
          "verification_code": verificationCode
        }));

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to verify user.');
    }
  }

  Future<bool> addAdress(Adress address) async {
    final response = await http.post(
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.address + ApiConstants.add),
        headers: requestHeaders,
        body: jsonEncode(address.toJson()));

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add address.');
    }
  }

  Future<bool> createOrder(int id) async {
    final response = await http.post(
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.order + ApiConstants.create),
        headers: requestHeaders,
        body: jsonEncode(<String, int>{
          "address_id": id,
        }));

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to order create.');
    }
  }

  Future<bool> addCart(int id) async {
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.cart + ApiConstants.add),
        headers: requestHeaders,
        body: jsonEncode(<String, int>{
          'book_id': id,
        }));

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add to cart.');
    }
  }

  Future<bool> deleteCart(int id) async {
    final response = await http.post(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.cart}\\$id${ApiConstants.delete}'),
        headers: requestHeaders);

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to delete from cart.');
    }
  }

  /* Book Operations */
  Future<Book> addBook(Book book) async {
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.books + ApiConstants.add),
        headers: requestHeaders,
        body: jsonEncode(book.toJson()));

    if (response.statusCode == 201) {
      return Book.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add book.');
    }
  }

  Future<List<Book>> getBooks(
      String name, String author, String category) async {
    var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.books),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      return booksFromJson(response.body);
    } else {
      throw Exception('Failed to load books.');
    }
  }

  Future<List<Book>> getBooksWithCategory(String category) async {
    var response = await http.get(
        Uri.parse(
            "${ApiConstants.baseUrl}${ApiConstants.category}?category=$category"),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      return booksFromJson(response.body);
    } else {
      throw Exception('Failed to load books with category.');
    }
  }

  /* Author Operations */
  Future<List<Author>> getAuthors(Author author) async {
    var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.author),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      return authorFromJson(response.body);
    } else {
      throw Exception('Failed to load authors.');
    }
  }

  Future<Author> addAuthor(Author book) async {
    final response = await http.post(
        Uri.parse(
            ApiConstants.baseUrl + ApiConstants.author + ApiConstants.add),
        headers: requestHeaders,
        body: jsonEncode(book.toJson()));

    if (response.statusCode == 201) {
      return Author.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add author.');
    }
  }

  /* Category Operations */
  Future<List<Category>> getCategories() async {
    var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.category),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      return categoryFromJson(response.body);
    } else {
      throw Exception('Failed to load categories.');
    }
  }
}

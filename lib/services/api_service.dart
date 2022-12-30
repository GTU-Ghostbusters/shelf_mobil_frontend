import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:shelf_mobil_frontend/constants.dart';
import 'package:shelf_mobil_frontend/models/book.dart';

import '../models/category.dart';
import '../models/user.dart';

class ApiService {
  /* User Operations */
  Future<bool?> login() async {
    return null;
  }

  Future<bool?> register() async {
    return null;
  }

  Future<bool?> updateMyAccount() async {
    return null;
  }

  Future<User?> changeMyPassword() async {
    return null;
  }

  Future<User?> getUser() async {
    return null;
  }

  Future<User?> trackDelivery() async {
    return null;
  }

  Future<User?> postFeedback() async {
    return null;
  }

  /* Book Operations */
  Future<bool?> addBook() async {
    return null;
  }

  Future<bool?> shareBook() async {
    return null;
  }

  Future<List<Book>?> getAllBooks() async {
    return null;
  }

  Future<List<Book>> getBooks(
      String name, String author, String category) async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.booksEndpoint);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return booksFromJson(response.body);
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<Book>> getBooksWithCategory(String category) async {
    var url = Uri.parse(ApiConstants.baseUrl + category);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return booksFromJson(response.body);
    } else {
      throw Exception('Failed to load books with category');
    }
  }

  /* Category Operations */
  Future<List<Category>> getCategories() async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.categoryEndpoint);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return categoryFromJson(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }
}

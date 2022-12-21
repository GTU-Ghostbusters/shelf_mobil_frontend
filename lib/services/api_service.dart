import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:shelf_mobil_frontend/constants.dart';
import 'package:shelf_mobil_frontend/models/book.dart';

import '../models/category.dart';
import '../models/user.dart';

class ApiService {
  /* User Operations */
  Future<bool?> login() async {}

  Future<bool?> register() async {}

  Future<bool?> updateMyAccount() async {}

  Future<User?> changeMyPassword() async {}

  Future<User?> getUser() async {}

  Future<User?> trackDelivery() async {}

  Future<User?> postFeedback() async {}

  /* Book Operations */
  Future<bool?> addBook() async {}

  Future<bool?> shareBook() async {}

  Future<List<Books>?> getAllBooks() async {}

  Future<List<Books>?> getBooks() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.booksEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return booksFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  /* Category Operations */
  Future<List<Category>?> getCategories() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.categoryEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return categoryFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

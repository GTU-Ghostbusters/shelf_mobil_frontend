import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const tokenKey = "token";
  static const userKey = "user";

  static const storage = FlutterSecureStorage();

  static void storeToken(String token) async {
    await storage.write(key: tokenKey, value: token);
  }

  static void deleteToken() async {
    await storage.delete(key: tokenKey);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: tokenKey);
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shelf_mobil_frontend/models/user.dart';

class SecureService {
  static const tokenKey = "token";
  static const userKey = "user";

  static const storage = FlutterSecureStorage();

  void storeUser(User user) async {
    await storage.write(key: userKey, value: user.toJson().toString());
  }

  void deleteUser() async {
    await storage.delete(key: userKey);
  }

  Future<String?> getUser() async {
    return await (storage.read(key: userKey));
  }

  void storeToken(String token) async {
    await storage.write(key: tokenKey, value: token);
  }

  void deleteToken() async {
    await storage.delete(key: tokenKey);
  }

  Future<String?> getToken() async {
    return await storage.read(key: tokenKey);
  }
}

import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:diet_app_mobile/model/user_model.dart';
import 'package:get_storage/get_storage.dart';

enum StorageItems {
  token,
  email,
  password,
  user,
  isLoggedIn,
  splashSeen,
}

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  static StorageService get instance => _instance;
  final _storage = GetStorage();

  // Veri kaydetme
  Future<void> saveData(StorageItems key, dynamic value) async {
    await _storage.write(key.toString(), value);
  }

  // Veri okuma
  dynamic loadData(StorageItems key) {
    return _storage.read(key.toString());
  }

  // Veri silme
  Future<void> removeData(StorageItems key) async {
    await _storage.remove(key.toString());
  }

  // Tüm verileri silme
  Future<void> clearAll() async {
    await _storage.erase();
  }

  Future<void> saveUser(UserModel user) async {
    final jsonString = jsonEncode(user.toJson());
    await saveData(StorageItems.user, jsonString);
  }

  UserModel? loadUser() {
    final jsonString = loadData(StorageItems.user);
    if (jsonString == null) return null;

    try {
      if (jsonString is String) {
        final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        return UserModel.fromJson(jsonMap);
      } else if (jsonString is Map<String, dynamic>) {
        return UserModel.fromJson(jsonString);
      }
      return null;
    } catch (e) {
      print('User decode error: $e');
      return null;
    }
  }
}

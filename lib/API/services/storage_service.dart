import 'package:get_storage/get_storage.dart';

enum StorageItems {
  token,
  userId,
  userEmail,
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
}

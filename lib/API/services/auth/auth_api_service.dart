import 'package:diet_app_mobile/API/services/api_base.dart';
import 'package:diet_app_mobile/API/services/storage_service.dart';
import 'package:diet_app_mobile/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// API istekleri için kullanılan servis sınıfı
class AuthApiService {
  final Dio _dio = Dio();
  static final AuthApiService _instance = AuthApiService._internal();

  factory AuthApiService() => _instance;

  static AuthApiService get instance => _instance;

  AuthApiService._internal() {
    _dio.options.validateStatus = (status) {
      return status! < 500;
    };
  }

  /// Kullanıcı kaydı için API isteği
  Future<AuthResponse?> register(String email, String password) async {
    try {
      print("Registering user with email: $email");

      final response = await _dio.post(
        "${ApiBase.instance.baseApiUrl}/users",
        data: {
          "email": email,
          "password": password,
        },
      );

      print("Register API Response: ${response.statusCode} - ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // API yanıtından AuthResponse nesnesini oluştur
        final authResponse = AuthResponse.fromJson(response.data);

        // Token ve kullanıcı bilgilerini sakla
        await StorageService.instance
            .saveData(StorageItems.token, authResponse.accessToken);
        await StorageService.instance
            .saveData(StorageItems.userId, authResponse.user.userId);
        await StorageService.instance
            .saveData(StorageItems.userEmail, authResponse.user.email);
        await StorageService.instance.saveData(StorageItems.isLoggedIn, true);

        print(
            "User registered successfully. Token saved: ${authResponse.accessToken}");
        return authResponse;
      } else {
        // Hata durumunda bildirim göster
        _showErrorSnackbar("Kayıt başarısız: ${response.statusMessage}");
        return null;
      }
    } catch (e) {
      print("Registration error: $e");
      _showErrorSnackbar("Kayıt işlemi sırasında bir hata oluştu: $e");
      return null;
    }
  }

  /// Kullanıcı girişi için API isteği
  Future<AuthResponse?> login(String email, String password) async {
    try {
      final response = await _dio.post(
        "${ApiBase.instance.baseApiUrl}/login",
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        // API yanıtından AuthResponse nesnesini oluştur
        final authResponse = AuthResponse.fromJson(response.data);

        // Token ve kullanıcı bilgilerini sakla
        await StorageService.instance
            .saveData(StorageItems.token, authResponse.accessToken);
        await StorageService.instance
            .saveData(StorageItems.userId, authResponse.user.userId);
        await StorageService.instance
            .saveData(StorageItems.userEmail, authResponse.user.email);
        await StorageService.instance.saveData(StorageItems.isLoggedIn, true);

        return authResponse;
      } else {
        // Hata durumunda bildirim göster
        _showErrorSnackbar("Giriş başarısız: ${response.statusMessage}");
        return null;
      }
    } catch (e) {
      _showErrorSnackbar("Giriş işlemi sırasında bir hata oluştu: $e");
      return null;
    }
  }

  /// Hata bildirimlerini göstermek için yardımcı metod
  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "Hata",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}

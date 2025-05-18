import 'package:diet_app_mobile/API/services/api_base.dart';
import 'package:diet_app_mobile/API/services/storage_service.dart';
import 'package:diet_app_mobile/model/user_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralService {
  final dio.Dio _dio = dio.Dio();
  static GeneralService? _instance;
  static GeneralService get instance => _instance ?? GeneralService._init();

  GeneralService._init() {
    _dio.options.validateStatus = (status) {
      return status! < 500;
    };
  }

  // Kullanıcı kaydı için API isteği
  Future<AuthResponse?> register(String email, String password) async {
    try {
      final response = await _dio.post(
        "${ApiBase.instance.baseApiUrl}/users",
        data: {
          "email": email,
          "password": password,
        },
      );

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

        return authResponse;
      } else {
        // Hata durumunda bildirim göster
        _showErrorSnackbar("Kayıt başarısız: ${response.statusMessage}");
        return null;
      }
    } catch (e) {
      _showErrorSnackbar("Kayıt işlemi sırasında bir hata oluştu: $e");
      return null;
    }
  }

  // Kullanıcı girişi için API isteği
  Future<AuthResponse?> login(String email, String password) async {
    try {
      final response = await _dio.post(
        "${ApiBase.instance.baseApiUrl}/users/login",
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

  // Authorization header'ı içeren GET isteği
  Future<dio.Response?> authorizedGet(String endpoint) async {
    try {
      final token = StorageService.instance.loadData(StorageItems.token);

      if (token == null) {
        _showErrorSnackbar("Oturum bilgisi bulunamadı");
        return null;
      }

      final response = await _dio.get(
        "${ApiBase.instance.baseApiUrl}$endpoint",
        options: dio.Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return response;
    } catch (e) {
      _showErrorSnackbar("İşlem sırasında bir hata oluştu: $e");
      return null;
    }
  }

  // Authorization header'ı içeren POST isteği
  Future<dio.Response?> authorizedPost(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      final token = StorageService.instance.loadData(StorageItems.token);

      if (token == null) {
        _showErrorSnackbar("Oturum bilgisi bulunamadı");
        return null;
      }

      final response = await _dio.post(
        "${ApiBase.instance.baseApiUrl}$endpoint",
        data: data,
        options: dio.Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return response;
    } catch (e) {
      _showErrorSnackbar("İşlem sırasında bir hata oluştu: $e");
      return null;
    }
  }

  // Hata bildirimlerini göstermek için yardımcı metod
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

  // API yanıtından tekil nesne parse etme
  T? _parseSingleResponse<T>(dio.Response? response, String key,
      T Function(Map<String, dynamic>) fromJson) {
    if (response != null &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      final data = response.data[key];
      if (data != null) {
        return fromJson(data);
      }
    }
    return null;
  }

  // API yanıtından liste parse etme
  List<T>? _parseListResponse<T>(dio.Response? response, String key,
      T Function(Map<String, dynamic>) fromJson) {
    if (response != null &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      final dataList = response.data[key] as List?;
      if (dataList != null) {
        return dataList.map((json) => fromJson(json)).toList();
      }
    }
    return null;
  }
}

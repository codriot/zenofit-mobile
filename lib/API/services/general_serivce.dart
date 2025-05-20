import 'package:diet_app_mobile/API/model/login_response_model.dart';
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
    _dio.options.followRedirects = true;
    _dio.options.maxRedirects = 5;
    _dio.interceptors.add(dio.LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) => print(object),
    ));
  }

  // Kullanıcı kaydı için API isteği
  Future<AuthResponse?> register(String email, String password) async {
    try {
      final response = await _dio.post(
        "${ApiBase.instance.baseApiUrl}/users/",
        data: {
          "email": email,
          "password": password,
        },
      );
      print("status code :${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // API yanıtından AuthResponse nesnesini oluştur
        final authResponse = AuthResponse.fromJson(response.data);

        // Token ve kullanıcı bilgilerini sakla
        await StorageService.instance
            .saveData(StorageItems.token, authResponse.accessToken);
        await StorageService.instance.saveUser(authResponse.user);
        await StorageService.instance.saveData(StorageItems.isLoggedIn, true);

        return authResponse;
      } else {
        // Hata mesajını response.data['detail']'den al
        String errorMessage = "Kayıt başarısız";
        if (response.data != null && response.data is Map && response.data['detail'] != null) {
          errorMessage = response.data['detail'];
        }
        _showErrorSnackbar(errorMessage);
        return null;
      }
    } catch (e) {
      _showErrorSnackbar("Kayıt işlemi sırasında bir hata oluştu: $e");
      return null;
    }
  }

  // Kullanıcı girişi için API isteği
  Future<LoginResponseModel?> login(String email, String password) async {
  try {
    final response = await _dio.post(
      "${ApiBase.instance.baseApiUrl}/auth/",
      data: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(response.data);
    } else {
      String errorMessage = "Giriş başarısız";
      if (response.data != null && response.data is Map && response.data['detail'] != null) {
        errorMessage = response.data['detail'];
      }
      _showErrorSnackbar(errorMessage);
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
}

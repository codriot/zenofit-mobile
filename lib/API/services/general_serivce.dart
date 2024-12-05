
import 'package:dio/dio.dart';

class GeneralService {
  // final Dio _dio = Dio();
  static GeneralService? _instance;
  static GeneralService get instance => _instance ?? GeneralService();
/* 
  Future<Response?> login(String email, String password) async {
    return _postRequest(
      AppServicesEndPointUtil.login.getName(),
      data: {
        "E_POSTA": email,
        "PAROLA": password,
      },
      showMessage: true,
      message: "Giriş Yapılamadı. Bilgileri Kontrol edin."
    );
  }

  Future<Response?> register(Map<String, dynamic> data) async {
    return _postRequest(AppServicesEndPointUtil.register.getName(), data: data);
  }

  Future<Response?> _postRequest(String endpoint,
      {Map<String, dynamic>? data, bool showMessage = false,String? message}) async {
    try {
      final response = await _dio.post(
        "${ApiBase.instance.baseApiUrl}$endpoint",
        data: data,
      );
      return response;
    } catch (e) {
      print("$endpoint alınamadı : $e");
      if (showMessage) {
        generalSnackBar(message: message);
      }
    }
    return null;
  }

  Future<Response?> _getRequest(String endpoint, String token) async {
    try {
      final response = await _dio.get(
        "${ApiBase.instance.baseApiUrl}$endpoint",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return response;
    } catch (e) {
      print("$endpoint alınamadı : $e");
      return null;
    }
  } */

  T? _parseSingleResponse<T>(Response? response, String key,
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

  List<T>? _parseListResponse<T>(Response? response, String key,
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
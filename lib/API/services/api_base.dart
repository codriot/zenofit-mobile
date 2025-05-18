class ApiBase {
  static final ApiBase _instance = ApiBase._internal();
  factory ApiBase() => _instance;
  ApiBase._internal();

  static ApiBase get instance => _instance;

  // API'nin temel URL'si
  final String baseApiUrl = "http://localhost:8000/api";
}

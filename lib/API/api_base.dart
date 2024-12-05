import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ApiBase {
  ApiBase._();
  static ApiBase instance = ApiBase._();

/*   final String baseApiUrl = dotenv.env['API_URL'] ?? '';
  final String socketApiUrl = dotenv.env['API_SOCKET_URL'] ?? '';
  final String imageApiUrl = dotenv.env['API_IMAGE_URL'] ?? ''; */
  
  late final BaseOptions baseOptions;
  late final Dio dio;

  Future<void> localDataBaseInit() async {
    await GetStorage.init();
    // AppData.box = GetStorage();
  }

  void dioSetUp(){
    baseOptions = BaseOptions(
      // baseUrl: baseApiUrl,
      headers: {}
    );
    dio = Dio(baseOptions);
  }
}
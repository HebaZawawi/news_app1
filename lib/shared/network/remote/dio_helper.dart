import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'baseUrl',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String path,
    required Map<String, dynamic> query,
    //required Map query,
  }) async {
    return await dio.get(
      path,
      queryParameters: query,);
  }
}

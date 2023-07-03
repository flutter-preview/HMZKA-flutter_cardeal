import 'package:dio/dio.dart';
import 'package:flutter_cardeal/constants.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  static Future<Response?> getData(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    return await dio?.get(path,
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  static Future<Response?> postData(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      required dynamic data}) async {
    return await dio?.post(path,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers));
  }

  static Future<Response?> patchData(
      {required String path,
      Map<String, dynamic>? queryParameters,
      required dynamic data}) async {
    return await dio?.patch(path, queryParameters: queryParameters, data: data);
  }

  static Future<Response?> deleteData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio?.delete(path,
        queryParameters: queryParameters, options: Options(headers: headers));
  }
}

import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl:
            "http://ip172-18-0-36-cig6qe0gftqg00e2e9e0-8000.direct.labs.play-with-docker.com/"));
  }

  static Future<Response?> getData(
      {required String path, Map<String, dynamic>? queryParameters}) async {
    return await dio?.get(path, queryParameters: queryParameters);
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
  }) async {
    return await dio?.delete(path, queryParameters: queryParameters);
  }
}

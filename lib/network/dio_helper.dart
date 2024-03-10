import 'package:app/data/constants/api_constants.dart';
import 'package:app/helpers/cache_helper.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseURL,
      sendTimeout: const Duration(minutes: 2),
      validateStatus: (statusCode) {
        if (statusCode == 422) {
          return true;
        }
        if (statusCode == 200) {
          return true;
        }
        if (statusCode == 400) {
          return true;
        }
        return false;
      },
      headers: CacheHelper.getString(key: "access_token") == null
          ? null
          : {
              'Authorization': CacheHelper.getString(key: "access_token") == null ? null : 'Bearer ${CacheHelper.getString(key: "access_token")}',
            },
    );
  }

  static Future<Response> post({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(),
    );
  }

  static Future<Response> put({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(),
    );
  }

  static Future<Response> delete({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(),
    );
  }

  static Future<Response> get({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }
}

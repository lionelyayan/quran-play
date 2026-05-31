import 'package:dio/dio.dart';

import '../../app/app_constants.dart';
import 'api_exceptions.dart';
import 'api_interceptor.dart';
import 'api_response.dart';

class DioClient {
  late final Dio _dio;

  late final ApiInterceptor apiInterceptor;

  DioClient({String? baseUrl}) {
    apiInterceptor = ApiInterceptor();

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? AppConstants.baseUrl,
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        sendTimeout: AppConstants.sendTimeout,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    )..interceptors.add(apiInterceptor);
  }

  Dio get dio => _dio;

  // ─────────────────────────────────────────────────────────
  //  GET
  // ─────────────────────────────────────────────────────────
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResponse.success(
        data: parser != null ? parser(response.data) : response.data as T?,
        code: response.statusCode,
      );
    } on DioException catch (e) {
      final apiError = ApiException.fromDioError(e);
      return ApiResponse.error(
        status: apiError.message,
        code: apiError.statusCode,
      );
    }
  }

  // ─────────────────────────────────────────────────────────
  //  POST
  // ─────────────────────────────────────────────────────────
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResponse.success(
        data: parser != null ? parser(response.data) : response.data as T?,
        code: response.statusCode,
      );
    } on DioException catch (e) {
      final apiError = ApiException.fromDioError(e);
      return ApiResponse.error(
        status: apiError.message,
        code: apiError.statusCode,
      );
    }
  }
}

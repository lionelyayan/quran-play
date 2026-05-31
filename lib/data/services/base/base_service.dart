import 'package:get/get.dart';

import '../../../core/network/api_response.dart';
import '../../../core/network/dio_client.dart';

abstract class BaseService {
  DioClient get client => Get.find<DioClient>();

  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic data)? parser,
  }) {
    return client.get<T>(
      path,
      queryParameters: queryParameters,
      parser: parser,
    );
  }

  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic data)? parser,
  }) {
    return client.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      parser: parser,
    );
  }
}

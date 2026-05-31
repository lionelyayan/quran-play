import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor();

  // ─────────────────────────────────────────────────────────
  //  REQUEST
  // ─────────────────────────────────────────────────────────
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Debug log
    if (kDebugMode) {
      dev.log('──▶ ${options.method} ${options.uri}', name: 'HTTP');
      if (options.data != null) {
        dev.log('    Body: ${options.data}', name: 'HTTP');
      }
      if (options.queryParameters.isNotEmpty) {
        dev.log('    Query: ${options.queryParameters}', name: 'HTTP');
      }
    }

    handler.next(options);
  }

  // ─────────────────────────────────────────────────────────
  //  RESPONSE
  // ─────────────────────────────────────────────────────────
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      dev.log(
        '◀── ${response.statusCode} ${response.requestOptions.method} '
        '${response.requestOptions.uri}',
        name: 'HTTP',
      );
    }

    handler.next(response);
  }

  // ─────────────────────────────────────────────────────────
  //  ERROR
  // ─────────────────────────────────────────────────────────
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      dev.log(
        '✖── ${err.response?.statusCode ?? 'N/A'} '
        '${err.requestOptions.method} ${err.requestOptions.uri}',
        name: 'HTTP',
      );
      dev.log('    Error: ${err.message}', name: 'HTTP');
    }

    handler.next(err);
  }
}

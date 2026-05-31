import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException({required this.message, this.statusCode, this.data});

  @override
  String toString() => 'ApiException($statusCode): $message';

  static ApiException fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        return const NetworkException();

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);

      case DioExceptionType.cancel:
        return const ApiException(message: 'Cancelled by user');

      default:
        return ApiException(message: error.message ?? 'Unknown error');
    }
  }

  static ApiException _handleBadResponse(Response? response) {
    final statusCode = response?.statusCode ?? 0;
    final data = response?.data;
    String message = 'Something went wrong';

    if (data is Map<String, dynamic>) {
      message =
          data['message'] as String? ?? data['error'] as String? ?? message;
    }

    switch (statusCode) {
      case 400:
        return BadRequestException(message: message, data: data);
      case 401:
        return UnauthorizedException(message: message);
      case 403:
        return ForbiddenException(message: message);
      case 404:
        return NotFoundException(message: message);
      case 409:
        return ConflictException(message: message, data: data);
      case 422:
        return ValidationException(message: message, data: data);
      case 500:
        return const ServerException();
      case 503:
        return const ServiceUnavailableException();
      default:
        return ApiException(
          message: message,
          statusCode: statusCode,
          data: data,
        );
    }
  }
}

class NetworkException extends ApiException {
  const NetworkException({
    super.message = 'No internet connection. Please check your network.',
    super.statusCode,
  });
}

/// Request timeout
class TimeoutException extends ApiException {
  const TimeoutException({
    super.message = 'Request timeout. Please try again.',
    super.statusCode,
  });
}

/// 400 - Bad Request
class BadRequestException extends ApiException {
  const BadRequestException({
    super.message = 'Request is invalid',
    super.statusCode = 400,
    super.data,
  });
}

/// 401 - Unauthorized
class UnauthorizedException extends ApiException {
  const UnauthorizedException({
    super.message = 'Session has expired. Please login again.',
    super.statusCode = 401,
  });
}

/// 403 - Forbidden
class ForbiddenException extends ApiException {
  const ForbiddenException({
    super.message = 'You do not have access to this resource.',
    super.statusCode = 403,
  });
}

/// 404 - Not Found
class NotFoundException extends ApiException {
  const NotFoundException({
    super.message = 'Data not found',
    super.statusCode = 404,
  });
}

/// 409 - Conflict
class ConflictException extends ApiException {
  const ConflictException({
    super.message = 'Data conflict occurred',
    super.statusCode = 409,
    super.data,
  });
}

/// 422 - Validation Error
class ValidationException extends ApiException {
  const ValidationException({
    super.message = 'Data is not valid',
    super.statusCode = 422,
    super.data,
  });
}

/// 500 - Internal Server Error
class ServerException extends ApiException {
  const ServerException({
    super.message = 'Something went wrong on the server',
    super.statusCode = 500,
  });
}

/// 503 - Service Unavailable
class ServiceUnavailableException extends ApiException {
  const ServiceUnavailableException({
    super.message = 'Service is currently unavailable. Please try again later.',
    super.statusCode = 503,
  });
}

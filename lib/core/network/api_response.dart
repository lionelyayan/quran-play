class ApiResponse<T> {
  final bool isSuccess;
  final T? data;
  final String? status;
  final int? code;

  const ApiResponse._({
    required this.isSuccess,
    this.data,
    this.status,
    this.code,
  });

  String? get message => status;
  int? get statusCode => code;

  /// Response berhasil
  factory ApiResponse.success({
    T? data,
    String? status,
    int? code,
    String? message,
    int? statusCode,
  }) {
    return ApiResponse._(
      isSuccess: true,
      data: data,
      status: status ?? message,
      code: code ?? statusCode,
    );
  }

  /// Response gagal
  factory ApiResponse.error({
    String? status,
    int? code,
    T? data,
    String? message,
    int? statusCode,
  }) {
    return ApiResponse._(
      isSuccess: false,
      data: data,
      status: status ?? message,
      code: code ?? statusCode,
    );
  }

  @override
  String toString() =>
      'ApiResponse(isSuccess: $isSuccess, code: $code, '
      'status: $status, data: $data)';
}

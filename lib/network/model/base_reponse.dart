import '../app_exception.dart';

class BaseResponse<T> {
  T? data;
  bool? success;
  AppException? exception;

  BaseResponse({
    this.data,
    this.success,
    this.exception,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        data: json['data'],
        success: json['success'] ?? false,
      );
}

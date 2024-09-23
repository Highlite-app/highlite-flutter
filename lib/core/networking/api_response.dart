import 'package:highlite_flutter_mvp/core/networking/api_error_model.dart';
import 'package:highlite_flutter_mvp/core/networking/result_model.dart';

class ApiResponse<T> {
  ApiErrorModel? apiErrorModel;

  T? responseData;

  int? httpStatusCode;

  ApiStatus status;

  String? message = "";
  bool isOfflineData = false;

  ApiResponse.from({
    this.httpStatusCode,
    this.responseData,
    this.message = "",
    this.isOfflineData = false,
  }) : status = responseData != null ? ApiStatus.success : ApiStatus.empty;

  ApiResponse.networkError(
      {this.httpStatusCode, this.responseData, this.message = ""})
      : status = ApiStatus.networkError;

  ApiResponse.serverError(
      {this.httpStatusCode, this.responseData, this.message = ""})
      : status = ApiStatus.serverError;

  bool get isSuccess => status == ApiStatus.success;
}

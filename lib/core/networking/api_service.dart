import 'package:dio/dio.dart';
import 'package:highlite_flutter_mvp/core/environment/base_environment.dart';
import 'package:highlite_flutter_mvp/core/networking/api_errror_response.dart';
import 'package:highlite_flutter_mvp/core/networking/api_response.dart';
import 'package:highlite_flutter_mvp/core/networking/base_api_service.dart';
import 'package:highlite_flutter_mvp/core/networking/dio_interceptor.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/logger.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BaseApiService)
class ApiService extends BaseApiService {
  final int _defaultConnectionTimeout = 30 * 100;

  final int _defaultReceiveTimeout = 60 * 100;

  late Dio _dio;

  static final ApiService _instance = ApiService._internal();

  factory ApiService.getInstance() {
    return _instance;
  }

  ApiService._internal() {
    _dio = Dio()
      ..options.connectTimeout =
          Duration(milliseconds: _defaultConnectionTimeout)
      ..options.receiveTimeout = Duration(milliseconds: _defaultReceiveTimeout)
      ..interceptors.add(DioInterceptor());
  }

  @override
  Future<ApiResponse<T>> postApiCall<T>(
      {required String url,
      required Map<String, dynamic> body,
      Options? options}) async {
    url = "${BaseEnvironment.base_url}$url";
    logger.logEvent(body, tag: "REQUEST", isJson: true);
    logger.logEvent(url, tag: "POST URL");

    if (!(await isInternetConnected())) {
      return Future.value(ApiResponse.networkError(
          httpStatusCode: ApiResponseListener.noInternetConnection));
    }
    try {
      final Response response =
          await _dio.post(url, data: body, options: options);
      logger.logEvent("${response.statusCode}", tag: "RESPONSE CODE");
      logger.logEvent(response.data, tag: "RESPONSE", isJson: true);
      return Future.value(handleDioResponse(response));
    } on DioError catch (e) {
      return super.handleDioError(e);
    }
  }

  @override
  Future<ApiResponse<T>> getApiCall<T>(
      {required String url,
      Map<String, dynamic>? qParams,
      bool responseTypeAsBytes = false,
      Options? options}) async {
    url = "${BaseEnvironment.base_url}$url";
    logger.logEvent(qParams, tag: "REQUEST PARAMS", isJson: true);
    logger.logEvent(url, tag: "GET URL");

    if (!(await isInternetConnected())) {
      return Future.value(ApiResponse.networkError(
          httpStatusCode: ApiResponseListener.noInternetConnection));
    }
    Response response;
    try {
      if (responseTypeAsBytes) {
        Options ops = options ?? Options();
        ops.responseType = ResponseType.bytes;
        response = await _dio.get(url, queryParameters: qParams, options: ops);
      } else {
        response = await _dio.get(url, queryParameters: qParams, options: options);
      }
      logger.logEvent("${response.statusCode}", tag: "RESPONSE CODE");
      logger.logEvent(response.data, tag: "RESPONSE", isJson: true);
      return Future.value(handleDioResponse(response));
    } on DioException catch (e) {
      return super.handleDioError(e);
    } catch (e) {
      return ApiResponse.serverError(
        message: "Unexpected error occurred: $e",
      );
    }
  }

  @override
  Future<ApiResponse<T>> putApiCall<T>(
      {required String url,
      Map<String, dynamic>? body,
      Options? options}) async {
    url = "${BaseEnvironment.base_url}$url";
    logger.logEvent(body, tag: "REQUEST", isJson: true);
    logger.logEvent(url, tag: "PUT URL");

    if (!(await isInternetConnected())) {
      return Future.value(ApiResponse.networkError(
          httpStatusCode: ApiResponseListener.noInternetConnection));
    }
    try {

      final Response response = await _dio.put(url, data: body, options: options);
      logger.logEvent("${response.statusCode}", tag: "RESPONSE CODE");
      logger.logEvent(response.data, tag: "RESPONSE", isJson: true);
      return Future.value(handleDioResponse(response));

    } on DioException catch (e) {
      return super.handleDioError(e);
    } catch(e){
      return ApiResponse.serverError(
        message: "Unexpected error occurred: $e",
      );
    }
  }
}

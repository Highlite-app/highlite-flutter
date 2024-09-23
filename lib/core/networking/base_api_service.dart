import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:highlite_flutter_mvp/core/networking/mapper.dart';

import '../../presentation/widgets/utils/logger.dart';
import '../services/injection_container.dart';
import 'api_errror_response.dart';
import 'api_response.dart';

final apiService = sl.get<BaseApiService>();

abstract class BaseApiService {
  Future<ApiResponse<T>> postApiCall<T>(
      {required String url,
      required Map<String, dynamic> body,
      Options? options});

  Future<ApiResponse<T>> getApiCall<T>(
      {required String url,
      Map<String, dynamic>? qParams,
      bool responseTypeAsBytes = false,
      Options? options});

  Future<ApiResponse<T>> putApiCall<T>(
      {required String url, Map<String, dynamic>? body, Options?options});


  ApiResponse<T> handleDioResponse<T>(Response response){
    final parsedResponse = MapperFactory.map<T>(response.data);
    if(parsedResponse == null){
      logger.logEvent('parsed response is$parsedResponse ' , tag: "INSIDE NULL DIO RESPONSE");
      return ApiResponse.serverError(
        httpStatusCode: response.statusCode!,
        responseData: parsedResponse ,
      );
    }
    logger.logEvent('parsed response is$parsedResponse' , tag: "INSIDE DIO RESPONSE");
    return ApiResponse.from(
      httpStatusCode: response.statusCode!,
      responseData: parsedResponse
    );
  }

  Future<ApiResponse<T>> handleDioError<T>(DioError e) {
    if (e.response != null) {
      logger.logEvent("DioException", error: e.error, stackTrace: e.stackTrace);
      return Future.value(ApiResponse.serverError(httpStatusCode: e.response!.statusCode));
    } else {
      logger.logEvent("DioException", error: e.error);
      if (e.toString().contains('SocketException')) {
        if (e.toString().contains('Network is unreachable')) {
          return Future.value(ApiResponse.networkError(
              httpStatusCode: ApiResponseListener.noInternetConnection));
        }
        return Future.value(ApiResponse.serverError(
            httpStatusCode: ApiResponseListener.internalServerError));
      }
      return Future.value(
          ApiResponse.serverError(httpStatusCode: ApiResponseListener.unknown));
    }
  }

  Future<bool> isInternetConnected() async{
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi ){
      return true ;
    }
    return false ;
  }

}

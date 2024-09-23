import 'package:highlite_flutter_mvp/core/networking/api_error_model.dart';
import 'package:highlite_flutter_mvp/core/networking/api_response.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/logger.dart';

class ApiResponseListener{

  static const int httpOk = 200;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int maintenance = 403;
  static const int methodNotAllowed = 405;
  static const int internalServerError = 500;
  static const int badGateWay = 502;
  static const int serviceUnavailable = 503;
  static const int noInternetConnection = -101;
  static const int unknown = -102;
  static const int gatewayTimeout = 504 ;

  ApiErrorModel onHttpFailure(ApiResponse? response){
    try{
      if(response  !=null && response.httpStatusCode !=null){
        int statusCode = response.httpStatusCode ?? 0 ;
        switch (statusCode) {
          case httpOk:
          case badRequest:
            return ApiErrorModel.fromJson(response.responseData);
          case noInternetConnection:
            return ApiErrorModel(
                TranslationKeys.noInternetConnection, statusCode);
          case internalServerError:
          case methodNotAllowed:
          case badGateWay:
          case serviceUnavailable:
            return ApiErrorModel(TranslationKeys.technicalIssue, statusCode);
          case maintenance:
            return ApiErrorModel(
                TranslationKeys.serverUnderMaintenance, statusCode);
          default:
            return ApiErrorModel(TranslationKeys.technicalIssue, statusCode);
        }
      }
    }
    catch(e){
      logger.logEvent("ApiError Response ::$e");
    }

    return ApiErrorModel(TranslationKeys.somethingWentWrong, unknown);
  }


}
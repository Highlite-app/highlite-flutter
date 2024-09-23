import 'dart:convert';
import 'dart:developer';

import 'package:highlite_flutter_mvp/core/environment/base_environment.dart';
import 'package:injectable/injectable.dart';

import '../../../core/services/injection_container.dart';

final logger = sl.get<ILogger>();

 const highlite = "HIGHLITE" ;

abstract class ILogger {
  void logEvent(dynamic toPrint ,{String tag  = highlite  ,int level = 0 , isJson = false  , Object? error , StackTrace? stackTrace} );
}

@Injectable(as: ILogger)
class Logger implements ILogger {
  @override
  void logEvent(dynamic toPrint, {String tag = highlite, int level = 0, isJson = false , Object? error , StackTrace? stackTrace}) {
   if(BaseEnvironment.enabledLogger){
     log( isJson? jsonEncode(toPrint):toPrint , name: tag , level: level , error: error , stackTrace:stackTrace ) ;
   }
  }




  // @override
  // void logEvent(String toPrint ,{ required String name  }) {
  //   if (BaseEnvironment.enabledLogger) {
  //     log(toPrint , name:name );
  //   }
  // }
}

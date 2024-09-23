import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseEnvironment {
  static const String production = "prod";

  static const String development = "dev";

  static const String userAcceptance = "uat";

  static var _config = <String, dynamic>{};

  static Future<void> initialize(String env) async {
    String configAssetPath;
    debugPrint("*********");
    debugPrint("ENVIRONMENT:$env");
    debugPrint("*********");
    switch (env) {
      case production:
        configAssetPath = "assets/env/prod.json";
        break;
      case development:
        configAssetPath = "assets/env/dev.json";
        break;
      case userAcceptance:
        configAssetPath = "assets/env/uat.json";
        break;
      default:
        configAssetPath = "assets/env/dev.json";
        break;
    }
    final configString = await rootBundle.loadString(configAssetPath);
    _config = jsonDecode(configString);
  }

  static String get base_url {
    return _config["staticBaseUrl"] as String;
  }

  static bool get enabledLogger {
    return _config['logEnabled'] as bool;
  }

  static bool get autoPlayEnabled {
    return _config['autoPlayEnabled'] as bool;
  }
}

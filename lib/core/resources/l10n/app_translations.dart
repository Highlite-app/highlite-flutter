

import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'languages/english.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    "en_US": English.translations,

  };
}

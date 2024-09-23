



import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../core/build_context/build_context.dart';
import '../../../data/models/onboarding/country_city.dart';

class CountryCodes {
  static Future<List<CountryCode>> countryCodes() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/country_codes.json");
    final List<dynamic> jsonResult = jsonDecode(data);
    List<CountryCode> countryCodes = [];
    for (var value in jsonResult) {
      countryCodes.add(
        CountryCode(
          name: value['name'],
          dialCode: value['dial_code'],
          emoji: value['emoji'],
          code: value['code'],
        ),
      );
    }
    return countryCodes;
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  static SharedPreferences? _prefs; // Static variable to store SharedPreferences

  SharedPreferencesHelper._(); // Private constructor


  static Future<bool> clear() async{
    return _prefs!.clear() ;
  }

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? getValue({required String key})  {
    return _prefs!.getString(key);
  }

  static bool? getBool({required String key }){
    return _prefs!.getBool(key);
  }

  static Future<bool> setBool({required String key, required bool value}){
    return _prefs!.setBool(key , value);
  }

  static Future<void> setValue({required String key, required String value}) async {
    _prefs!.setString(key, value);
  }
}
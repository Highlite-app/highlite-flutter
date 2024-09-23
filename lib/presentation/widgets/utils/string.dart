import 'dart:math';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


/*extension CryptoString on String {
  String get decrypted =>
      decryptAESCryptoJS(this, BaseEnvironment.secretPassphrase);

  String get encrypted =>
      encryptAESCryptoJS(this, BaseEnvironment.secretPassphrase);
}*/

extension StringNullCheckExtensions on String?{
  bool get isNullOrEmpty {
    return this == null ||this!.isEmpty  ;
  }
}

extension StringExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  Future<bool> validateImage() async {
    http.Response res;
    try {
      res = await http.get(Uri.parse(this));
    } catch (e) {
      return false;
    }

    if (res.statusCode != 200) return false;
    Map<String, dynamic> data = res.headers;
    return checkIfImage(data['content-type']);
  }

  bool checkIfImage(String param) {
    if (param == 'image/jpeg' || param == 'image/png' || param == 'image/gif') {
      return true;
    }
    return false;
  }

  bool isValidURLForImage() {
    bool isURLValid = Uri.parse(this).host.isNotEmpty;
    bool isURLNotAbsolute = Uri.parse(this).isAbsolute;
    return isURLValid && isURLNotAbsolute;
  }

  Future<void> copyToClipboard() {
    return Clipboard.setData(ClipboardData(text: this));
  }
}

extension IntExtension on int {
  String formatted() {
    var formatter = NumberFormat('#,###,###');
    return formatter.format(this);
  }
}

extension StringExt on String? {
  String nullish() => this ?? "";
}

String formattedPhoneNumber(String countryCode, String phoneNumber) =>
    "${countryCode.toString().extracted}-$phoneNumber";
String dataPhoneNumber(String countryCode, String phoneNumber) =>
    "${countryCode.toString().extracted}$phoneNumber".phoneNumber;
String phoneNumberString(String countryCode, String phoneNumber) =>
    "${countryCode.toString()}$phoneNumber".phoneNumber;


extension PhoneExtensions on String {
  String get extracted => extractCountryCode();
  String extractCountryCode() {
    String s = this;
    int start = s.indexOf("(") + 1;
    int end = s.indexOf(")", start);
    String countryCode = "s.substring(start, end";
    return countryCode;
  }

  String get phoneNumber => replaceAll("-", "");
  String get extractedOtp => replaceAll("-", "");
  String get username {
    if (contains("@")) {
      return this;
    }
    return "@$this";
  }
}
// AppLocalizations  getLocalization(BuildContext context) {
//   return AppLocalizations.of(context) ??
//       lookupAppLocalizations(const Locale('en'));
// }
//AppLocalizations get currentLocalizations => getLocalization(buildContext);


String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

String formatDate(DateTime date) {
  final day = date.day;
  final month = _getMonthName(date.month);
  final year = date.year;

  return "${_getDayWithSuffix(day)} $month, $year";
}

 String formatDateShowMonthYear (DateTime date){
   final day = date.day;
   final month = _getMonthName(date.month);
   final year = date.year;

   return "$month, $year";
 }



String formatDateShowYear (DateTime date){

  final year = date.year;

  return "$year";
}
String _getMonthName(int month) {
  switch (month) {
    case 1:
      return "Jan";
    case 2:
      return "Feb";
    case 3:
      return "Mar";
    case 4:
      return "Apr";
    case 5:
      return "May";
    case 6:
      return "Jun";
    case 7:
      return "Jul";
    case 8:
      return "Aug";
    case 9:
      return "Sep";
    case 10:
      return "Oct";
    case 11:
      return "Nov";
    case 12:
      return "Dec";
    default:
      return "";
  }
}

String _getDayWithSuffix(int day) {
  if (day >= 11 && day <= 13) {
    return "${day}";
  }
  switch (day % 10) {
    case 1:
      return "${day}";
    case 2:
      return "${day}";
    case 3:
      return "${day}";
    default:
      return "${day}";
  }
}

import 'dart:convert';

import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:hive/hive.dart';

class CompanyOnboardingAdapter extends TypeAdapter<CompanyOnboarding>{

  @override
  int get typeId =>0;

  @override
  CompanyOnboarding read(BinaryReader reader) {

    final companyOnboarding = reader.readString() ;
    final Map<String , dynamic> companyJson =  jsonDecode(companyOnboarding) ;
    return CompanyOnboarding.fromJson(companyJson) ;
  }



  @override
  void write(BinaryWriter writer, CompanyOnboarding obj) {
    final companyString  = jsonEncode(obj.toJson()) ;
    writer.writeString(companyString) ;

  }


}
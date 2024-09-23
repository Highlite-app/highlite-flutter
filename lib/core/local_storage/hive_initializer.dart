
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'highlite_candidate_storage_service.dart';
import 'types/highlite_candidate_adapter.dart';

class HiveInitializer {
  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CandidateOnBoardingAdapter());
    await Hive.openLazyBox<CandidateOnBoarding>(candidateBox);
    await Hive.openLazyBox<CompanyOnboarding>(companyBox);
  }
}

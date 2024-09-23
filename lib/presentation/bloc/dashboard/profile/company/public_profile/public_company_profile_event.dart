
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';


abstract class PublicCompanyProfileEvent {
  const PublicCompanyProfileEvent();
}

class PublicCompanyProfileStartEvent extends PublicCompanyProfileEvent {
  const PublicCompanyProfileStartEvent(
      this.companyProfile,
      );
  final CompanyOnboarding companyProfile;
}

class FollowPublicCompanyProfileEvent extends PublicCompanyProfileEvent {
  const FollowPublicCompanyProfileEvent();
}

class UnfollowPublicCompanyProfileEvent extends PublicCompanyProfileEvent {
  const UnfollowPublicCompanyProfileEvent();
}
class ReloadPublicCompanyProfileEvent extends PublicCompanyProfileEvent {
  const ReloadPublicCompanyProfileEvent();
}
class SuperMessageEvent extends PublicCompanyProfileEvent {
  const SuperMessageEvent({required this.jobPostId, required this.message, required this.companyId,});
  final String jobPostId;
  final String message;
  final String companyId;
}

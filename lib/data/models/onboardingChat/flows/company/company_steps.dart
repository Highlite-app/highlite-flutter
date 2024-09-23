import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/company/steps/about_step.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/company/steps/company_benefits_step.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/company/steps/company_website_step.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/company/steps/job_industry_step.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/steps/salary_step.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/steps/job_duration_step.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/steps/work_type_step.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/company/steps/company_name_step.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/default_steps/location_step.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/company/steps/company_size_step.dart';

import '../default_steps/email_address_step.dart';
import '../onboarding_chat_models.dart';


class CompanyTags {

  static String companyName = 'companyName' ;
  static String industry  = 'industry' ;
  static String location  = 'location' ;
  static String website  = 'website' ;
  static String companySize = 'companySize' ;
  static String benefits = 'benefits' ;
  static String about = 'about' ;
  static String email = 'email' ;
  static String userName = 'userName' ;

}

class CompanyFlowTags {
  static String companyName = 'company_name_flow';
  static String industry = 'industry_flow';
  static String location = 'location_flow';
  static String website = 'website_flow';
  static String companySize = 'company_size_flow';
  static String benefits = 'benefits_flow';
  static String about = 'about_flow';
  static String email = 'email_flow';
  static String userName = 'username_flow';
}

class CompanySteps {
  // static OnboardingChatFlowItem username = UsernameStep(false);
  // static OnboardingChatFlowItem location = LocationStep();
  // static OnboardingChatFlowItem title = JobPositionTitleStep();
 // static OnboardingChatFlowItem organization = OrganizationStep();


//  static OnboardingChatFlowItem companyEmployees = CompanyEmployeesStep();
  static OnboardingChatFlowItem companyNameStep = CompanyNameStep();
  static OnboardingChatFlowItem jobIndustry = CompanyIndustryStep();
  static OnboardingChatFlowItem companySizeStep = CompanySizeStep();
  static OnboardingChatFlowItem companyBenefitStep = CompanyBenefitsStep();
 // static OnboardingChatFlowItem jobFlexibility = JobFlexibilityStep(isCandidate: false);
//  static OnboardingChatFlowItem jobType = JobDurationStep();
  //static OnboardingChatFlowItem hourlyRate = HourlyRateStep(isCandidate: false);
  static OnboardingChatFlowItem location = LocationStep(false);
  static OnboardingChatFlowItem companyWebsite = CompanyWebsiteStep();
  static OnboardingChatFlowItem emailAddress = EmailAddressStep();
  static OnboardingChatFlowItem about = AboutStep(false);
  // static OnboardingChatFlowItem companyLogo = ProfileStep(true);
}

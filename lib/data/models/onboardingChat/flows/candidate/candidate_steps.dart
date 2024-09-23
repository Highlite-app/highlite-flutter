
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/steps/position_step.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/steps/skills_step.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/default_steps/email_address_step.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/steps/salary_step.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/steps/job_duration_step.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/steps/work_type_step.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/default_steps/location_step.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/onboarding_chat_models.dart';
import '../company/steps/about_step.dart';
import '../company/steps/company_name_step.dart';
import '../company/steps/company_size_step.dart';
import 'steps/tools_step.dart';


class CandidateTags {

  static String firstName = 'firstName';
  static String lastName = 'lastName';
  static String position = 'position';
  static String skills  = 'skills' ;
  static String tools = 'tools' ;
  static String workType = 'workType' ;
  static String jobDuration = 'jobDuration' ;
  static String salary = 'salary' ;
  static String city = 'city' ;
  static String country = 'country' ;
  static String email = 'email' ;
  static String username = 'username' ;

}

class CandidateFlowTag{

  static String firstName = 'first_name_flow';
  static String lastName = 'last_name_flow';
  static String position = 'position_flow';
  static String skills  = 'skills_flow' ;
  static String tools = 'tools_flow' ;
  static String workType = 'workType_flow' ;
  static String jobDuration = 'jobDuration_flow' ;
  static String salary = 'salary_flow' ;
  static String city = 'city_flow' ;
  static String country = 'country_flow' ;
  static String email = 'email_flow' ;
  static String username = 'username_flow' ;
}



class CandidateSteps {

  static OnboardingChatFlowItem positionStep = PositionStep() ;
  static OnboardingChatFlowItem skills = SkillsStep();
  static OnboardingChatFlowItem tools = ToolsStep();
  static OnboardingChatFlowItem workType = WorkTypeStep();
  static OnboardingChatFlowItem jobDuration = JobDurationStep();
  static OnboardingChatFlowItem salary = SalaryStep();
  static OnboardingChatFlowItem location = LocationStep(true);
  static OnboardingChatFlowItem about = AboutStep(true);
  static OnboardingChatFlowItem emailAddress = EmailAddressStep();


}




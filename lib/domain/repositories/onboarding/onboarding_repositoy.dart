import 'package:dartz/dartz.dart';
import 'package:highlite_flutter_mvp/core/constants/injection_constant.dart';
import 'package:highlite_flutter_mvp/core/error/failure.dart';
import 'package:highlite_flutter_mvp/data/models/apis/authentication/create_user.dart';
import 'package:highlite_flutter_mvp/data/models/apis/authentication/signup_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/login/email_otp.dart';
import 'package:highlite_flutter_mvp/data/models/apis/login/signin_api.dart';
import 'package:highlite_flutter_mvp/data/models/apis/login/verify_email_otp.dart';
import 'package:highlite_flutter_mvp/data/models/apis/login/verify_email_otp_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:highlite_flutter_mvp/domain/entites/onboarding/login_with_email_otp.dart';

import '../../../core/services/injection_container.dart';


final onboardingService = sl.get<OnBoardingRepository>(instanceName: InjectionConstant.onBoardingImplementation);

abstract class OnBoardingRepository{

 // Future<Either<Failure , EmailOtpResponse>> getLoginWithEmailOtp(String recipient) ;
  Future<EmailOtpResponse> getLoginWithEmailOtp(String recipient) ;

  Future<SignUpResponse> signUp(CreateUser creteUser) ;

 // Future<Either<Failure , VerifyEmailOtpResponse>> verifyEmailOtp(VerifyEmailOtp  verifyEmailOtp) ;
  Future<VerifyEmailOtpResponse> verifyEmailOtp(VerifyEmailOtp  verifyEmailOtp) ;

  Future<SigninResponse> signUpCandidate(CandidateOnBoarding candidate);

  Future<SigninResponse>  signUpCompanyUser(CompanyOnboarding companyOnboarding);
}
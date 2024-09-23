import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:highlite_flutter_mvp/core/error/failure.dart';
import 'package:highlite_flutter_mvp/core/local_storage/highlite_candidate_storage_service.dart';
import 'package:highlite_flutter_mvp/core/platform/network_info.dart';
import 'package:highlite_flutter_mvp/data/datasources/local_datasource.dart';
import 'package:highlite_flutter_mvp/data/datasources/remote_datasources.dart';
import 'package:highlite_flutter_mvp/data/models/apis/authentication/create_user.dart';
import 'package:highlite_flutter_mvp/data/models/apis/authentication/signup_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/login/signin_api.dart';
import 'package:highlite_flutter_mvp/data/models/apis/login/verify_email_otp.dart';
import 'package:highlite_flutter_mvp/data/models/apis/login/verify_email_otp_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:highlite_flutter_mvp/domain/entites/onboarding/login_with_email_otp.dart';
import 'package:highlite_flutter_mvp/domain/entites/onboarding/onboarding_questions.dart';
import 'package:highlite_flutter_mvp/domain/repositories/onboarding/onboarding_repositoy.dart';

import '../../models/apis/login/email_otp.dart';

class OnBoardingRepositoryImpl extends OnBoardingRepository {
  final LocalDataSource localDataSource;

  final RemoteDataSources remoteDataSources;

  final NetworkInfo networkInfo;

  OnBoardingRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSources,
      required this.networkInfo});

  @override
  Future<EmailOtpResponse> getLoginWithEmailOtp(String recipient) async {
    if (await networkInfo.isConnected()) {
      return await remoteDataSources.sendEmailOtpForSignIn(recipient);
    } else {
      throw Exception("No Internet Connection");
    }
  }

// @override
// Future<Either<Failure, OnBoardingQuestions>> getOnboardingQuestions() async{
//  if( await networkInfo.isConnected()){
//    try{
//      final remoteQuestions = await remoteDataSources.getOnboardingQuestions();
//      localDataSource.cacheQuestion(remoteQuestions);
//      return  Right(remoteQuestions);
//    } on ServerFailure {
//      return Left(ServerFailure());
//    }
//
//  }else {
//    try{
//      final localQuestions = await remoteDataSources.getOnboardingQuestions();
//      localDataSource.cacheQuestion(localQuestions);
//      return  Right(localQuestions);
//    } on ServerFailure {
//      return Left(ServerFailure());
//    }
//
//  }
// }

  @override
  Future<SigninResponse> signUpCandidate(CandidateOnBoarding candidate) async {
    if (await networkInfo.isConnected()) {
      return await remoteDataSources.signUpCandidate(candidate);
    } else {
      throw Exception("No Internet Connection");
    }
  }

  @override
  Future<SigninResponse> signUpCompanyUser(
      CompanyOnboarding companyOnboarding) async {
    if (await networkInfo.isConnected()) {
      return await remoteDataSources.signUpCompany(companyOnboarding);
    } else {
      throw Exception("No Internet Connection");
    }
  }

  @override
  Future<VerifyEmailOtpResponse> verifyEmailOtp(
      VerifyEmailOtp verifyEmailOtp) async {
    final VerifyEmailOtpResponse verifyEmailOtpResponse;
    if (await networkInfo.isConnected()) {
      try {
        verifyEmailOtpResponse =
            await remoteDataSources.verifyEmailOtp(verifyEmailOtp);
        return verifyEmailOtpResponse;
      } catch (e) {
        throw Exception();
      }
    } else {
      throw Exception("No Internet Connection");
    }
  }

  @override
  Future<SignUpResponse> signUp(CreateUser creteUser) async {
    if (await networkInfo.isConnected()) {
      try {
        final signUpResponse = await remoteDataSources.signup(creteUser);
        return signUpResponse;
      } catch (e) {
        throw Exception();
      }
    } else {
      throw Exception("No Internet Connection");
    }
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/networking/api_error_model.dart';
import 'package:highlite_flutter_mvp/core/networking/base_api_service.dart';
import 'package:highlite_flutter_mvp/core/networking/url_constants.dart';
import 'package:highlite_flutter_mvp/data/models/apis/authentication/create_user.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/home/candidate_feed_item_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/default/api_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/login/signin_api.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/bookmark/response/bookmark_collection_item_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/update_candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/data/models/onboarding/login_with_email_otp_model.dart';
import 'package:highlite_flutter_mvp/data/models/onboarding/question_model.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/logger.dart';

import '../models/apis/authentication/signup_response.dart';
import '../models/apis/dashboard/cadidate/profile/next_token_request.dart';
import '../models/apis/dashboard/cadidate/upload/about /about_candidate.dart';
import '../models/apis/dashboard/cadidate/upload/about /candidate_about_response.dart';
import '../models/apis/dashboard/cadidate/upload/education/candidate_education.dart';
import '../models/apis/dashboard/cadidate/upload/education/canidate_education_response.dart';
import '../models/apis/dashboard/cadidate/upload/employment/candidate_employment.dart';
import '../models/apis/dashboard/cadidate/upload/employment/candidate_employment_response.dart';
import '../models/apis/dashboard/cadidate/upload/project/candidate_project.dart';
import '../models/apis/dashboard/cadidate/upload/project/candidate_project_response.dart';
import '../models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import '../models/apis/dashboard/company/home/company_job_feed_item_response.dart';
import '../models/apis/login/email_otp.dart';
import '../models/apis/login/verify_email_otp.dart';
import '../models/apis/login/verify_email_otp_response.dart';
import '../models/apis/onboarding/bookmark/request/bookmark_model.dart';

abstract class RemoteDataSources {
  Future<QuestionsModel> getOnboardingQuestions();

  Future<EmailOtpResponse> sendEmailOtpForSignIn(String recipient) ;

  Future<VerifyEmailOtpResponse> verifyEmailOtp(VerifyEmailOtp  verifyEmailOtp) ;

  Future<SignUpResponse> signup(CreateUser createUser) ;

  Future<LoginWithEmailOtpModel> getLoginWithEmailOtp(String email);

  Future<SigninResponse> signUpCandidate(CandidateOnBoarding candidate);

  Future<CandidateOnBoarding> getCandidateOnBoarding(String id);

  Future<List<CandidateVideoFeed>> getCandidateVideoFeed(String candidateId);

  Future<CandidateOnBoarding> updateCandidateOnBoarding(
      String id, CandidateOnBoarding request);

  Future<CompanyJobFeedItemsResponse> fetch(NextTokenRequest request);

  Future<CandidateFeedItemResponse> fetchCandidate(NextTokenRequest request);

  Future<CandidateAboutResponse> aboutCandidate(AboutCandidate about);

  Future<CandidateEducationResponse> candidateEducation(
      CandidateEducation candidateEducation);

  Future<CandidateEmploymentResponse> candidateEmployment(
      CandidateEmployment candidateEmployment);

  Future<CandidateProjectResponse> candidateProject(
      CandidateProject candidateProject);

  Future<CandidateVideoFeedResponse> uploadCandidateVideo(
      CandidateVideoFeed candidateVideoFeed);

  // Bookmark

  Future<ApiResponse> createBookmark(BookmarkModel bookmarkModel);

  Future<BookmarkCollectionItemResponse> fetchBookmark(NextTokenRequest? request , String userId);
}

class RemoteDataSourceImpl implements RemoteDataSources {
  @override
  Future<LoginWithEmailOtpModel> getLoginWithEmailOtp(String email) {
    // TODO: implement getLoginWithEmailOtp
    throw UnimplementedError();
  }


  @override
  Future<SignUpResponse> signup(CreateUser createUser) async{

    try{
      final response  =  await apiService.postApiCall<SignUpResponse>(url: UrlConstants.signUp, body:  createUser.toJson()) ;

      if(response.isSuccess){
        final responseData = response.responseData ;
        if(responseData !=null){
          logger.logEvent(
              'The status is ${UrlConstants.signUp} is ${responseData.status}');
          return responseData ;
        }else {
          logger.logEvent("The ${UrlConstants.signUp} ${response.responseData} is null or Empty") ;
          throw ApiErrorModel( "The ${UrlConstants.signUp} ${response.responseData} is null or Empty", HttpStatus.noContent ) ;
        }

      }else {
        logger.logEvent("The ${UrlConstants.signUp} response is not success check ${response.httpStatusCode}") ;
        throw ApiErrorModel( "The ${UrlConstants.signUp} response is not success check ${response.httpStatusCode}", HttpStatus.conflict ) ;
      }
    }catch(e){
      throw Exception("Something went wrong ${UrlConstants.signUp} :: $e") ;

    }
  }

  @override
  Future<EmailOtpResponse> sendEmailOtpForSignIn(String recipient) async{
    try{
      final response  =  await apiService.postApiCall<EmailOtpResponse>(url: UrlConstants.sendEmail, body: {
        'recipient':recipient ,
      });

      if(response.isSuccess){
        final responseData = response.responseData ;
       if(responseData !=null){
         logger.logEvent(
             'The OTP is ${UrlConstants.sendEmail} is ${responseData.otp}');
         return responseData ;
       }else {
         logger.logEvent("The ${UrlConstants.sendEmail} ${response.responseData} is null or Empty") ;
         throw ApiErrorModel( "The ${UrlConstants.sendEmail} ${response.responseData} is null or Empty", HttpStatus.noContent ) ;
       }

      }else {
        logger.logEvent("The ${UrlConstants.sendEmail} response is not success check ${response.httpStatusCode}") ;
        throw ApiErrorModel( "The ${UrlConstants.sendEmail} response is not success check ${response.httpStatusCode}", HttpStatus.conflict ) ;
      }
    }catch(e){
      throw Exception("Something went wrong ${UrlConstants.sendEmail} :: $e") ; 

    }

  }


  @override
  Future<VerifyEmailOtpResponse> verifyEmailOtp(VerifyEmailOtp verifyEmailOtp)  async{
    try{
      final response  =  await apiService.postApiCall<VerifyEmailOtpResponse>(url: UrlConstants.verifyEmail, body: verifyEmailOtp.toJson());

      if(response.isSuccess){
        final responseData = response.responseData ;
        if(responseData !=null){
          logger.logEvent(
              'The  status is ${UrlConstants.verifyEmail} is ${responseData.status}');
          return responseData ;
        }else {
          logger.logEvent("The ${UrlConstants.verifyEmail} ${response.responseData} is null or Empty") ;
          throw ApiErrorModel( "The ${UrlConstants.verifyEmail} ${response.responseData} is null or Empty", HttpStatus.noContent ) ;
        }

      }else {
        logger.logEvent("The ${UrlConstants.verifyEmail} response is not success check ${response.httpStatusCode}") ;
        throw ApiErrorModel( "The ${UrlConstants.verifyEmail} response is not success check ${response.httpStatusCode}", HttpStatus.conflict ) ;
      }
    }catch(e){
      throw Exception("Something went wrong ${UrlConstants.verifyEmail} :: $e") ;

    }
  }
  @override
  Future<QuestionsModel> getOnboardingQuestions() {
    // TODO: implement getOnboardingQuestions
    FormData formData = FormData.fromMap({});
    throw UnimplementedError();
  }

  @override
  Future<SigninResponse> signUpCandidate(CandidateOnBoarding candidate) async {
    try {
      final response = await apiService.postApiCall<SigninResponse>(
          url: UrlConstants.onBoardingCandidateDetails,
          body: candidate.toJson());
      if (response.isSuccess) {
        debugPrint(response.responseData?.data.id ?? '');
      }
      return response.responseData!;
    } catch (e) {
      logger.logEvent("Unable to load data $e");
    }
    throw ApiErrorModel(
        "Something went wrong ${UrlConstants.onBoardingCandidateDetails}",
        HttpStatus.httpVersionNotSupported);
  }

  @override
  Future<CandidateOnBoarding> getCandidateOnBoarding(String id) async {
    try {
      final response = await apiService.getApiCall<CandidateOnBoarding>(
          url: '${UrlConstants.getOnBoardingCandidateDetails}/$id');
      if (response.isSuccess) {
        debugPrint(response.responseData?.username ?? '');
      }
      logger.logEvent(
          'The ${UrlConstants.getOnBoardingCandidateDetails} is ${response.responseData?.position}');

      return response.responseData!;
    } catch (e) {
      logger.logEvent(
          'Something went wrong ${UrlConstants.getOnBoardingCandidateDetails} , Reason : $e');
    }

    throw ApiErrorModel(
        "Something went wrong ${UrlConstants.getOnBoardingCandidateDetails}",
        HttpStatus.httpVersionNotSupported);
  }

  @override
  Future<CandidateOnBoarding> updateCandidateOnBoarding(
      String id, CandidateOnBoarding request) async {
    try {
      final response = await apiService.putApiCall<UpdateCandidate>(
        url: '${UrlConstants.updateOnBoardingCandidateDetails}/$id',
        body: request.toJson(),
      );

      if (response.isSuccess) {
        final responseData = response.responseData?.candidate;

        if (responseData != null) {
          logger.logEvent(
              'The ${UrlConstants.updateOnBoardingCandidateDetails} is ${responseData.position}');
          return responseData;
        } else {
          throw ApiErrorModel(
            "Unexpected null response data from ${UrlConstants.updateOnBoardingCandidateDetails}",
            HttpStatus.internalServerError,
          );
        }
      } else {
        throw ApiErrorModel(
          "API call failed: ${UrlConstants.updateOnBoardingCandidateDetails}",
          HttpStatus.badRequest,
        );
      }
    } catch (e) {
      logger.logEvent(
        'Something went wrong with ${UrlConstants.updateOnBoardingCandidateDetails}, Reason: $e',
      );
      throw Exception(
          'The exception in ${UrlConstants.updateOnBoardingCandidateDetails} API: $e');
    }
  }

  @override
  Future<CompanyJobFeedItemsResponse> fetch(NextTokenRequest request) async {
    var response = await apiService.getApiCall<CompanyJobFeedItemsResponse>(
        url: UrlConstants.fetchCompanyHomeFeed,
        qParams: {'nextToken': request});

    try {
      debugPrint("The response is ::${response.httpStatusCode}");
      if (response.isSuccess) {
        if (response.responseData != null &&
            response.responseData!.items.isNotEmpty) {
          logger.logEvent(response.responseData!.items.first.playbackId);
          return response.responseData!;
        } else {
          logger.logEvent(
              "No items found in the response.${UrlConstants.fetchCompanyHomeFeed}");
          return CompanyJobFeedItemsResponse(items: []);
        }
      } else {
        throw ApiErrorModel(
            "Api is not success failed status code ${UrlConstants.fetchCompanyHomeFeed}",
            HttpStatus.httpVersionNotSupported);
      }
    } catch (e) {
      throw Exception(
          'The exception in ${UrlConstants.fetchCompanyHomeFeed}  api ::$e');
    }
  }

  @override
  Future<CandidateFeedItemResponse> fetchCandidate(
      NextTokenRequest request) async {
    var response = await apiService.getApiCall<CandidateFeedItemResponse>(
        url: UrlConstants.fetchCandidateHomeFeed,
        qParams: {'nextToken': request});

    try {
      debugPrint("The response is ::${response.httpStatusCode}");
      if (response.isSuccess) {
        if (response.responseData != null &&
            response.responseData!.items.isNotEmpty) {
          logger.logEvent(response.responseData!.items.first.playbackId);
          return response.responseData!;
        } else {
          // Log or handle empty response scenario
          logger.logEvent(
              "No items found in the . ${UrlConstants.fetchCandidateHomeFeed}");
          return CandidateFeedItemResponse(items: []);
        }
      } else {
        throw ApiErrorModel(
            "Something went wrong ${UrlConstants.fetchCandidateHomeFeed}",
            HttpStatus.httpVersionNotSupported);
      }
    } catch (e) {
      throw Exception(
          'The exception in ${UrlConstants.fetchCandidateHomeFeed}  api ::$e');
    }
  }

  @override
  Future<CandidateAboutResponse> aboutCandidate(AboutCandidate about) async {
    try {
      final response = await apiService.postApiCall<CandidateAboutResponse>(
          url: UrlConstants.about, body: about.toJson());
      if (response.isSuccess) {
        debugPrint(response.responseData?.message ?? '');
      }
      return response.responseData!;
    } catch (e) {
      logger
          .logEvent('Something went wrong ${UrlConstants.about} , Reason : $e');
    }
    throw ApiErrorModel("Something went wrong ${UrlConstants.about}",
        HttpStatus.httpVersionNotSupported);
  }

  @override
  Future<CandidateEducationResponse> candidateEducation(
      CandidateEducation candidateEducation) async {
    try {
      final response = await apiService.postApiCall<CandidateEducationResponse>(
          url: UrlConstants.education, body: candidateEducation.toJson());
      if (response.isSuccess) {
        debugPrint(response.responseData?.message ?? '');
      }
      return response.responseData!;
    } catch (e) {
      logger
          .logEvent('Something went wrong ${UrlConstants.about} , Reason : $e');
    }
    throw ApiErrorModel("Something went wrong ${UrlConstants.about}",
        HttpStatus.httpVersionNotSupported);
  }

  @override
  Future<CandidateEmploymentResponse> candidateEmployment(
      CandidateEmployment candidateEmployment) async {
    try {
      final response =
          await apiService.postApiCall<CandidateEmploymentResponse>(
              url: UrlConstants.employment, body: candidateEmployment.toJson());
      if (response.isSuccess) {
        debugPrint(response.responseData?.message ?? '');
      }
      return response.responseData!;
    } catch (e) {
      logger.logEvent(
          'Something went wrong ${UrlConstants.employment} , Reason : $e');
    }
    throw ApiErrorModel("Something went wrong ${UrlConstants.employment}",
        HttpStatus.httpVersionNotSupported);
  }

  @override
  Future<CandidateProjectResponse> candidateProject(
      CandidateProject candidateProject) async {
    try {
      final response = await apiService.postApiCall<CandidateProjectResponse>(
          url: UrlConstants.project, body: candidateProject.toJson());
      if (response.isSuccess) {
        debugPrint(response.responseData?.message ?? '');
      }
      return response.responseData!;
    } catch (e) {
      logger.logEvent(
          'Something went wrong ${UrlConstants.employment} , Reason : $e');
    }
    throw ApiErrorModel("Something went wrong ${UrlConstants.employment}",
        HttpStatus.httpVersionNotSupported);
  }

  @override
  Future<CandidateVideoFeedResponse> uploadCandidateVideo(
      CandidateVideoFeed candidateVideoFeed) async {
    try {
      final response = await apiService.postApiCall<CandidateVideoFeedResponse>(
          url: UrlConstants.uploadVideo, body: candidateVideoFeed.toJson());
      if (response.isSuccess) {
        debugPrint(response.responseData?.candidateVideoId ?? '');
      }
      return response.responseData!;
    } catch (e) {
      logger.logEvent(
          'Something went wrong ${UrlConstants.uploadVideo} , Reason : $e');
    }
    throw ApiErrorModel("Something went wrong ${UrlConstants.uploadVideo}",
        HttpStatus.httpVersionNotSupported);
  }

  @override
  Future<List<CandidateVideoFeed>> getCandidateVideoFeed(
      String candidateId) async {
    try {
      final response = await apiService.getApiCall<List<CandidateVideoFeed>>(
          url: "${UrlConstants.getCandidateVideoByCandidateId}/$candidateId");

      if (response.isSuccess) {
        if (response.responseData != null &&
            response.responseData!.isNotEmpty) {
          debugPrint(response.responseData![0].candidateVideoFeedId);
        }
        return response.responseData ?? [];
      }
    } catch (e) {
      logger.logEvent(
          'Something went wrong ${UrlConstants.getCandidateVideoByCandidateId} , Reason : $e');
    }

    throw ApiErrorModel(
        "Something went wrong ${UrlConstants.getCandidateVideoByCandidateId}",
        HttpStatus.httpVersionNotSupported);
  }

  @override
  Future<ApiResponse> createBookmark(BookmarkModel bookmarkModel) async {
    try {
      final response = await apiService.postApiCall<ApiResponse>(
        url: UrlConstants.createBookmark,
        body: bookmarkModel.toJson(),
      );

      if (response.isSuccess) {
        final responseData = response.responseData;

        if (responseData != null) {
          logger.logEvent(
              'The ${UrlConstants.createBookmark} is ${responseData.status}');
          return responseData;
        } else {
          throw ApiErrorModel(
            "Unexpected null response data from ${UrlConstants.createBookmark}",
            HttpStatus.internalServerError,
          );
        }
      } else {
        throw ApiErrorModel(
          "API call failed: ${UrlConstants.createBookmark}",
          HttpStatus.badRequest,
        );
      }
    } catch (e) {
      logger.logEvent(
        'Something went wrong with ${UrlConstants.createBookmark}, Reason: $e',
      );
      throw Exception(
          'The exception in ${UrlConstants.createBookmark} API: $e');
    }
  }

  @override
  Future<BookmarkCollectionItemResponse> fetchBookmark(
      NextTokenRequest? request , String userId) async {


    try {
      final response = await apiService
          .getApiCall<BookmarkCollectionItemResponse>(
              url: "${UrlConstants.fetchBookmark}/$userId",
          qParams: {'nextToken': request});

      logger.logEvent('response.isSuccess: ${response.isSuccess}');

      if (response.isSuccess) {
        final responseData = response.responseData;

        if (responseData != null &&  responseData.items!.isNotEmpty )  {
          logger.logEvent('The ${UrlConstants.fetchBookmark} is ${responseData.items}', isJson: true);
          logger.logEvent('The ${UrlConstants.fetchBookmark} is ${responseData.items?.first.userId}', isJson: true);
          return responseData;
        } else {
          logger.logEvent('No Items found in ${UrlConstants.fetchBookmark}');
          return BookmarkCollectionItemResponse(items: [] , nextToken: request?.nextToken ?? '') ;

        }
      } else {
        throw ApiErrorModel("API call failed: ${UrlConstants.fetchBookmark}", HttpStatus.badRequest);
      }
    } catch (e) {
      logger.logEvent('Something went wrong with ${UrlConstants.fetchBookmark}, Reason: $e',);
      throw Exception('The exception in ${UrlConstants.fetchBookmark} API: $e');
    }
  }
}

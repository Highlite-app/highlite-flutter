import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/profile/next_token_request.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';
import 'package:injectable/injectable.dart';
import '../../core/services/injection_container.dart';
import '../models/apis/dashboard/company/home/company_job_feed_item_response.dart';
import '../models/apis/onboarding/company/company_onboarding.dart';
import '../models/onboarding/question_model.dart';

final localDatasource = sl.get<LocalDataSource>();

abstract class LocalDataSource {
  Future<QuestionsModel> getLastQuestion();

  Future<void> cacheQuestion(QuestionsModel questionsModel);

  Future<List<CompanyOnboarding>> getCompanyOnboardingFromJSON();

  Future<List<CompanyJobPost>> getCompanyJobPostFromJSON();

  Future<List<String>> getLocationListFromJSON();

  Future<List<String>> getJobTitleListFromJSON();

  Future<List<String>> getSkillsListFromJSON();

  Future<List<String>> getToolsListFromJSON();

  Future<List<String>> getSalaryListFromJSON();
}

@Injectable(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<void> cacheQuestion(QuestionsModel questionsModel) {
    // TODO: implement cacheQuestion
    throw UnimplementedError();
  }

  @override
  Future<QuestionsModel> getLastQuestion() {
    // TODO: implement getLastQuestion
    throw UnimplementedError();
  }

  @override
  Future<List<CompanyOnboarding>> getCompanyOnboardingFromJSON() async {
    final configString =
        await rootBundle.loadString(AssetConstant.companyOnboardingFixture);
    final List<dynamic> configResponse = jsonDecode(configString);
    final response = configResponse
        .map((companyOnboarding) =>
            CompanyOnboarding.fromJson(companyOnboarding))
        .toList();
    return response;
  }

  @override
  Future<List<CompanyJobPost>> getCompanyJobPostFromJSON() async {
    final configString =
        await rootBundle.loadString(AssetConstant.companyJobPostFixture);
    final List<dynamic> configResponse = jsonDecode(configString);
    final response = configResponse
        .map((companyJobPost) => CompanyJobPost.fromJson(companyJobPost))
        .toList();
    return response;
  }

  @override
  Future<List<String>> getJobTitleListFromJSON() async {
    final configString =
        await rootBundle.loadString(AssetConstant.jobTitleFixture);
    final Map<String, dynamic> configMap = jsonDecode(configString);
    final List<String> configResponse =
        List<String>.from(configMap['jobTitles']);
    final response = configResponse;
    return response;
  }

  @override
  Future<List<String>> getLocationListFromJSON() async {
    final configString =
        await rootBundle.loadString(AssetConstant.locationFixture);
    final Map<String, dynamic> configMap = jsonDecode(configString);
    final List<String> configResponse =
        List<String>.from(configMap['locations']);
    final response = configResponse;
    return response;
  }

  @override
  Future<List<String>> getSkillsListFromJSON() async {
    final configString =
        await rootBundle.loadString(AssetConstant.skillsFixture);
    final Map<String, dynamic> configMap = jsonDecode(configString);
    final List<String> configResponse = List<String>.from(configMap['skills']);
    final response = configResponse;
    return response;
  }

  @override
  Future<List<String>> getToolsListFromJSON() async {
    final configString =
        await rootBundle.loadString(AssetConstant.toolsFixture);
    final Map<String, dynamic> configMap = jsonDecode(configString);
    final List<String> configResponse = List<String>.from(configMap['tools']);
    final response = configResponse;
    return response;
  }

  @override
  Future<List<String>> getSalaryListFromJSON() async {
    final configString =
        await rootBundle.loadString(AssetConstant.salaryFixtures);
    final Map<String, dynamic> configMap = jsonDecode(configString);
    final List<String> configResponse =
        List<String>.from(configMap['salary_ranges']);
    final response = configResponse;
    return response;
  }
}

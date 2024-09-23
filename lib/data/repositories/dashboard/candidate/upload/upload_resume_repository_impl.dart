import 'package:highlite_flutter_mvp/core/platform/network_info.dart';
import 'package:highlite_flutter_mvp/data/datasources/local_datasource.dart';
import 'package:highlite_flutter_mvp/data/datasources/remote_datasources.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/about%20/about_candidate.dart';

import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/about%20/candidate_about_response.dart';

import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/education/candidate_education.dart';

import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/education/canidate_education_response.dart';

import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/employment/candidate_employment.dart';

import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/employment/candidate_employment_response.dart';

import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/project/candidate_project.dart';

import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/project/candidate_project_response.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/logger.dart';

import '../../../../../domain/repositories/dashboard/candidate/upload/upload_resume_repository.dart';

class UploadResumeRepositoryImpl implements UploadResumeRepository {
  final LocalDataSource localDataSource;

  final RemoteDataSources remoteDataSources;

  final NetworkInfo networkInfo;

  UploadResumeRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSources,
      required this.networkInfo});

  @override
  Future<CandidateAboutResponse> aboutCandidate(AboutCandidate about) async {
    if (await networkInfo.isConnected()) {
      final response = remoteDataSources.aboutCandidate(about);
      return response;
    } else {
      logger.logEvent("This is no local Datastore since its a post Api");
    }
    throw Exception();
  }

  @override
  Future<CandidateEducationResponse> candidateEducation(
      CandidateEducation candidateEducation) async {
    if (await networkInfo.isConnected()) {
      final response = remoteDataSources.candidateEducation(candidateEducation);
      return response;
    } else {
      logger.logEvent("This is no local Datastore since its a post Api");
    }
    throw Exception();
  }

  @override
  Future<CandidateEmploymentResponse> candidateEmployment(
      CandidateEmployment candidateEmployment) async {
    if (await networkInfo.isConnected()) {
      final response =
          remoteDataSources.candidateEmployment(candidateEmployment);
      return response;
    } else {
      logger.logEvent("This is no local Datastore since its a post Api");
    }
    throw Exception();
  }

  @override
  Future<CandidateProjectResponse> candidateProject(
      CandidateProject candidateProject) async {
    if (await networkInfo.isConnected()) {
      final response = remoteDataSources.candidateProject(candidateProject);
      return response;
    } else {
      logger.logEvent("This is no local Datastore since its a post Api");
    }
    throw Exception();
  }
}

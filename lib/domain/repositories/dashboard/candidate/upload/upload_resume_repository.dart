import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/about%20/about_candidate.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/about%20/candidate_about_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/education/candidate_education.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/education/canidate_education_response.dart';

import '../../../../../core/services/injection_container.dart';
import '../../../../../data/models/apis/dashboard/cadidate/upload/employment/candidate_employment.dart';
import '../../../../../data/models/apis/dashboard/cadidate/upload/employment/candidate_employment_response.dart';
import '../../../../../data/models/apis/dashboard/cadidate/upload/project/candidate_project.dart';
import '../../../../../data/models/apis/dashboard/cadidate/upload/project/candidate_project_response.dart';


final uploadResumeService = sl<UploadResumeRepository>() ;

abstract class UploadResumeRepository{

  Future<CandidateAboutResponse> aboutCandidate(AboutCandidate about);

  Future<CandidateEducationResponse>  candidateEducation(CandidateEducation candidateEducation) ;

  Future<CandidateEmploymentResponse> candidateEmployment(CandidateEmployment candidateEmployment) ;


  Future<CandidateProjectResponse> candidateProject(CandidateProject candidateProject) ;

}
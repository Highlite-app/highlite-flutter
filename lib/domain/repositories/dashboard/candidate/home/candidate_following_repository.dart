//
// import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/home/list_current_user_id_response.dart';
// import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/profile/next_token_request.dart';
//
// import '../../../../../core/services/injection_container.dart';
// import '../../../../../data/models/apis/dashboard/cadidate/home/highlite_candidate_following.dart';
// import '../../../../../data/models/apis/dashboard/cadidate/profile/id_request.dart';
// import '../../../../../data/models/apis/dashboard/cadidate/profile/id_response.dart';
// import '../../company/home/list_company_id_response.dart';
// import 'list_id_response.dart';
//
// final candidateFollowingService = sl.get<CandidateFollowingRepository>();
//
// abstract class CandidateFollowingRepository {
//   Future<IDResponse> createCandidateOnBoardingFollowing(
//       CandidateOnBoardingFollowing request);
//   Future<IDResponse> deleteCandidateOnBoardingFollowing(IDRequest idRequest);
//   Future<List<IDResponse>> deleteMultipleCandidateOnBoardingFollowing(
//       List<IDRequest> request);
//   Future<void> createMultipleCandidateOnBoardingFollowing(
//       List<CandidateOnBoardingFollowing> request);
//   Future<ListIDResponse> fetchAllByCompanyAndUserID(
//       NextTokenRequest request, String companyID, String userID);
//   Future<List<IDResponse>> fetchAllPaginatedByCompanyAndUser(
//       String companyId, String userID);
//   Future<ListCurrentUserIDResponse> fetchAllByCompanyID(
//       NextTokenRequest request, String companyID);
//   Future<List<CurrentUserIDResponse>> fetchAllPaginatedByCompanyID(
//       String companyId);
//   Future<ListCompanyIDResponse> fetchAllByUserID(
//       NextTokenRequest request, String userID);
//   Future<List<CompanyIDResponse>> fetchAllPaginatedByUserID(String userID);
// }

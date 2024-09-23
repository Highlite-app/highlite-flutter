import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:highlite_flutter_mvp/core/constants/injection_constant.dart';
import 'package:highlite_flutter_mvp/core/local_storage/highlite_candidate_storage_service.dart';
import 'package:highlite_flutter_mvp/core/networking/api_service.dart';
import 'package:highlite_flutter_mvp/core/networking/base_api_service.dart';
import 'package:highlite_flutter_mvp/core/platform/network_info.dart';
import 'package:highlite_flutter_mvp/core/services/navigation_service.dart';
import 'package:highlite_flutter_mvp/data/datasources/local_datasource.dart';
import 'package:highlite_flutter_mvp/data/datasources/remote_datasources.dart';
import 'package:highlite_flutter_mvp/data/repositories/auth/auth_repository_impl.dart';
import 'package:highlite_flutter_mvp/data/repositories/dashboard/candidate/home/candidate_following_repository_impl.dart';
import 'package:highlite_flutter_mvp/data/repositories/dashboard/candidate/home/job_post_video_feed_repository_impl.dart';
import 'package:highlite_flutter_mvp/data/repositories/dashboard/candidate/profile/candidate_profile_repository_impl.dart';
import 'package:highlite_flutter_mvp/data/repositories/dashboard/candidate/profile/candidate_video_feed_repository_impl.dart';
import 'package:highlite_flutter_mvp/data/repositories/dashboard/common/bookmark/bookmark_repository_impl.dart';
import 'package:highlite_flutter_mvp/data/repositories/dashboard/common/feed_service/home_feed_state_repository_impl.dart';
import 'package:highlite_flutter_mvp/data/repositories/dashboard/common/feed_service/video_feed_integrated__repository_impl.dart';
import 'package:highlite_flutter_mvp/data/repositories/dashboard/company/profile/company_job_post_video_feed_repository_impl.dart';
import 'package:highlite_flutter_mvp/data/repositories/integrated_uploader/http_uploader_repository_impl.dart';
import 'package:highlite_flutter_mvp/data/repositories/integrated_uploader/integrated_uploader_repository_impl.dart';
import 'package:highlite_flutter_mvp/data/repositories/onboarding/onboarding_repository_impl.dart';
import 'package:highlite_flutter_mvp/data/repositories/persistent/persistent_repository_impl.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/candidate/home/candidate_following_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/candidate/home/job_post_video_feed_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/candidate/profile/candidate_profile_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/candidate/profile/candidate_video_feed_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/candidate/upload/upload_video_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/common/bookmark/bookmark_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/common/feed_service/home_feed_state_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/common/feed_service/video_feed_integrated_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/common/video_player/video_player_queue_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/integrated_uploader/http_uploader_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/integrated_uploader/integrated_uploader_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/onboarding/onboarding_repositoy.dart';
import 'package:highlite_flutter_mvp/domain/repositories/persistent/persistent_repository.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate/candidate_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/toast/toast_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/upload_handler/upload_handler_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/logger.dart';

import '../../data/repositories/dashboard/candidate/home/candidate_feed_repository_impl.dart';
import '../../data/repositories/dashboard/candidate/search/search_repository_impl.dart';
import '../../data/repositories/dashboard/candidate/upload/upload_resume_repository_impl.dart';
import '../../data/repositories/dashboard/candidate/upload/upload_video_repository_impl.dart';
import '../../data/repositories/dashboard/company/videp_player/video_player_queue_repository_impl.dart';
import '../../domain/repositories/dashboard/candidate/home/candidate_feed_repository.dart';
import '../../domain/repositories/dashboard/candidate/search/search_repository.dart';
import '../../domain/repositories/dashboard/candidate/upload/upload_resume_repository.dart';
import '../../domain/repositories/dashboard/company/home/company_job_post_video_feed_repository.dart';
import '../../presentation/bloc/center_prompt/center_prompt_bloc.dart';
import '../../presentation/bloc/dashboard/home/candidate/for_you/candidate_for_you_bloc.dart';
import '../../presentation/bloc/dashboard/upload/candidate/video/upload_candidate_bloc.dart';
import '../../presentation/bloc/dashboard/upload/company/about/company_upload_info_bloc.dart';
import '../../presentation/widgets/utils/file.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  // *********************** HOME FEED ***********************//

  sl.registerLazySingleton<JobPostVideoFeedRepository>(() =>
      JobPostVideoFeedRepositoryImpl(
          localDataSource: sl(), remoteDataSources: sl(), networkInfo: sl()));

  sl.registerLazySingleton<CandidateFeedRepository>(() =>
      CandidateFeedRepositoryImpl(
          localDataSource: sl(), remoteDataSources: sl(), networkInfo: sl()));

  sl.registerFactory<HomeFeedStateRepository>(
      () => HomeFeedStateRepositoryImpl());
  //TODO : NEED TO ADD FOLLOWING REPOSITORY WHEN WORKED ON CANDIDATE FOLLOWING
  //sl.registerLazySingleton<CandidateFollowingRepository>(() => CandidateFollowingRepositoryImpl());

  // *********************** UPLOAD CANDIDATE ***********************//
  sl.registerLazySingleton<UploadResumeRepository>(() =>
      UploadResumeRepositoryImpl(
          localDataSource: sl(), remoteDataSources: sl(), networkInfo: sl()));

  // *********************** UPLOAD CANDIDATE VIDEO ***********************

  sl.registerLazySingleton<UploadVideoRepository>(()=> UploadVideoRepositoryImpl(remoteDataSources: sl(), localDataSource: sl(), networkInfo: sl())) ;

  // *********************** VIDEO PLAYER MUX ***********************//
  sl.registerLazySingleton<VideoPlayerQueueRepository>(
      () => VideoPlayerQueueRepositoryImpl());


  // *********************** CANDIDATE SEARCH REPOSITROY ***********************//
  sl.registerLazySingleton<SearchRepository>(
          () => SearchRepositoryImpl(remoteDataSources: sl(), localDataSource: sl(), networkInfo: sl()));

  // *********************** BOOKMARK REPOSITORY ***********************//
  sl.registerLazySingleton<BookmarkRepository>(
          () => BookmarkRepositoryImpl(remoteDataSources: sl(), localDataSource: sl(), networkInfo: sl()));
  // *********************** COMMON ***********************//
  sl.registerLazySingleton<VideoFeedIntegratedRepository>(
      () => VideoFeedIntegratedRepositoryImpl());

  sl.registerLazySingleton<OnBoardingRepository>(
      () => OnBoardingRepositoryImpl(
          localDataSource: sl(), remoteDataSources: sl(), networkInfo: sl()),
      instanceName: InjectionConstant.onBoardingImplementation);

  //candidate Repository
  sl.registerLazySingleton<CandidateProfileRepository>(
      () => CandidateProfileRepositoryImpl(
          localDataSource: sl(), remoteDataSources: sl(), networkInfo: sl()),
      instanceName: InjectionConstant.candidateProfileRepository);

  //register Parameter of
  sl.registerLazySingleton<RemoteDataSources>(() => RemoteDataSourceImpl());
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  sl.registerLazySingleton(() => Connectivity());

  sl.registerLazySingleton<PersistentRepository>(
      () => PersistentRepositoryImpl(),
      instanceName: InjectionConstant.persistentImplementation);
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(),
      instanceName: InjectionConstant.authRepository);
  sl.registerLazySingleton<ICandidateOnBoardingStorage>(() => HighliteStorage(),
      instanceName: InjectionConstant.CandidateOnBoardingStorage);
  sl.registerLazySingleton<CandidateVideoFeedRepository>(
      () => CandidateVideoFeedRepositoryImpl(),
      instanceName: InjectionConstant.candidateVideoFeedRepository);
  sl.registerLazySingleton<IFileManager>(() => FileManager(),
      instanceName: InjectionConstant.fileManager);
  sl.registerLazySingleton<IntegratedUploaderRepository>(
      () => IntegratedUploaderRepositoryImpl(),
      instanceName: InjectionConstant.integratedUploaderRepository);
  sl.registerLazySingleton<HttpUploaderRepository>(
      () => HttpUploaderRepositoryImpl(),
      instanceName: InjectionConstant.httpUploaderRepository);

  // *********************** COMPANY ***********************//
  sl.registerLazySingleton<CompanyJobPostVideoFeedRepository>(
      () => CompanyJobPostVideoFeedRepositoryImpl());

  // *********************** HOME ***********************//
  sl.registerLazySingleton<HomeFeedStateRepositoryImpl>(
      () => HomeFeedStateRepositoryImpl());

  // *********************** LOGGER ***********************//
  sl.registerLazySingleton<ILogger>(() => Logger());

  // *********************** BLOC ***********************//
  sl.registerFactory<AuthenticationBloc>(() => AuthenticationBloc(),
      instanceName: InjectionConstant.authenticationBloc);
  sl.registerFactory<UploadHandlerBloc>(() => UploadHandlerBloc(),
      instanceName: InjectionConstant.uploadHandlerBloc);
  sl.registerFactory<ToasterBloc>(() => ToasterBloc());
  sl.registerFactory<CenterPromptBloc>(() => CenterPromptBloc());
  sl.registerLazySingleton<CompanyUploadInfoBloc>(
      () => CompanyUploadInfoBloc());
  sl.registerLazySingleton<UploadCandidateBloc>(() => UploadCandidateBloc());
  sl.registerLazySingleton<CandidateForYouBloc>(()=> CandidateForYouBloc());
  sl.registerLazySingleton<CandidateBloc>(()=> CandidateBloc());

  // *********************** API SERVICE ***********************//
  sl.registerLazySingleton<BaseApiService>(() => ApiService.getInstance());


  // *********************** THIRD PARTY SERVICES SDk SERVICE ***********************



  // *********************** CONTEXT ***********************//
  sl.registerFactory<NavigationService>(() => NavigationService());




}

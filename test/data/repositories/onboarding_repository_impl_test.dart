// import 'dart:math';
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:highlite_flutter_mvp/core/error/exceptions.dart';
// import 'package:highlite_flutter_mvp/core/error/failure.dart';
// import 'package:highlite_flutter_mvp/core/platform/network_info.dart';
// import 'package:highlite_flutter_mvp/data/datasources/local_datasource.dart';
// import 'package:highlite_flutter_mvp/data/datasources/remote_datasources.dart';
// import 'package:highlite_flutter_mvp/data/models/onboarding/question_model.dart';
// import 'package:highlite_flutter_mvp/data/repositories/onboarding_repository_impl.dart';
// import 'package:mockito/mockito.dart';
//
// class MockRemoteDataSource extends Mock implements OnBoardingRemoteDataSources{}
//
// class MockLocalDataSource extends Mock implements OnBoardingLocalDataSource{}
//
//
// class MockNetworkInfo extends Mock implements NetworkInfo{}
//
// void main(){
//
//  late  OnBoardingRepositoryImpl repositoryImpl  ;
//  late MockLocalDataSource mockLocalDataSource ;
//  late MockRemoteDataSource mockRemoteDataSource ;
//  late MockNetworkInfo mockNetworkInfo ;
//
//  setUp(() {
//    repositoryImpl = OnBoardingRepositoryImpl(
//     remoteDataSources:MockRemoteDataSource(),
//     localDataSource : MockLocalDataSource(),
//     networkInfo : MockNetworkInfo()
//    ) ;
//   mockNetworkInfo = MockNetworkInfo() ;
//   mockLocalDataSource = MockLocalDataSource();
//   mockRemoteDataSource = MockRemoteDataSource();
//  });
//
//  void runTestOnline(Function body){
//   group("device is online ", () {
//    setUp(() {
//     when(mockNetworkInfo.isConnected())
//         .thenAnswer((_) async => true);
//    });
//
//    body();
//
//   });
//  }
//
//  void runTestOffline(Function body){
//   group("device is online ", () {
//    setUp(() {
//     when(mockNetworkInfo.isConnected())
//         .thenAnswer((_) async => false);
//    });
//
//    body();
//
//   });
//  }
//
//
//  group("getQuestions", () {
//
//   const tQuestions = "Test Questions" ;
//   const tQuestionModel = QuestionsModel(question: tQuestions) ;
//
//   test("Should check if the device is online", () {
//  when(mockNetworkInfo.isConnected)
//        .thenAnswer((_) async {
//          return true ;
//  });
//
//    repositoryImpl.getOnboardingQuestions();
//
//    verify(mockNetworkInfo.isConnected());
//    expect(mockNetworkInfo.isConnected(), true);
//
//   });
//
//  group("device is online", () {
//
//   setUp(() {
//    when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true) ;
//   });
//   test("should return remote data when call to remote data source is successful",
//           () async{
//
//    //arrange
//     when(mockRemoteDataSource.getOnboardingQuestions()).thenAnswer((_)async => tQuestionModel);
//     //act
//     final result  = await repositoryImpl.getOnboardingQuestions();
//     //assert
//     verify(mockRemoteDataSource.getOnboardingQuestions());
//     expect(result, equals(Right(tQuestions)));
//   });
//
//   test("should cache the data locally  when call to remote data source is successful",
//           () async{
//
//        //arrange
//        when(mockRemoteDataSource.getOnboardingQuestions()).thenAnswer((_)async => tQuestionModel);
//        //act
//        final result  = await repositoryImpl.getOnboardingQuestions();
//        //assert
//        verify(mockRemoteDataSource.getOnboardingQuestions());
//        verify(mockLocalDataSource.cacheQuestion(tQuestionModel));
//        expect(result, equals(Right(tQuestions)));
//       });
//
//   test("should return server failure  when call to remote data source is unsuccessful",
//           () async{
//
//         //arrange
//         when(mockRemoteDataSource.getOnboardingQuestions()).thenThrow((ServerExceptions()));
//         //act
//         final result  = await repositoryImpl.getOnboardingQuestions();
//         //assert
//         verify(mockRemoteDataSource.getOnboardingQuestions());
//         verifyZeroInteractions(mockLocalDataSource);
//         expect(result, equals(Left(ServerFailure())));
//       });
//  });
//
//  runTestOffline( () {
//
//   setUp(() {
//   when(mockNetworkInfo.isConnected()).thenAnswer((_)async => false) ;
//   });
//
//   test("should return last locally cached data when data is cached successfully",() async{
//
//     //arrange
//     when(mockLocalDataSource.getLastQuestion()).thenAnswer((_) async => tQuestionModel);
//     // act
//     final result  = await repositoryImpl.getOnboardingQuestions();
//     //assert
//     verifyZeroInteractions(mockRemoteDataSource);
//     verify(mockLocalDataSource.getLastQuestion());
//     expect(result, right(tQuestions));
//   });
//
//   test("should return cache failure when there is no cached data present",() async{
//
//     //arrange
//     when(mockLocalDataSource.getLastQuestion()).thenThrow(CacheExceptions());
//     //act
//     final result = await repositoryImpl.getOnboardingQuestions();
//     //assert
//     verifyZeroInteractions(mockRemoteDataSource);
//     verify(mockLocalDataSource.getLastQuestion());
//     expect(result, equals(left(CacheFailure())));
//
//   });
//
//  });
//
//  });
//
//
// }
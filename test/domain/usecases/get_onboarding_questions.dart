// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:highlite_flutter_mvp/domain/entites/onboarding/onboarding_questions.dart';
// import 'package:highlite_flutter_mvp/domain/repositories/onboarding_repositoy.dart';
// import 'package:highlite_flutter_mvp/domain/usecases/onboarding/get_questions.dart';
// import 'package:mockito/mockito.dart';
//
// class MockQuestionRepository extends Mock implements OnBoardingRepository{}
//
// void main()  {
//   late GetQuestions useCase;
//   late MockQuestionRepository mockQuestionRepository ;
//
//   setUp(() {
//     mockQuestionRepository = MockQuestionRepository();
//     useCase = GetQuestions(mockQuestionRepository);
//   });
//
//   const questions = "Whats your name" ;
//   const getQuestions = OnBoardingQuestions(question: questions ) ;
//
//   test("should get Question from Repository",
//           () async{
//
//     when(mockQuestionRepository.getOnboardingQuestions())
//         .thenAnswer((_)async  => const Right(getQuestions));
//
//     final results = await useCase.call(NoParams());
//
//     expect(results,const  Right(getQuestions)) ;
//     verify(mockQuestionRepository.getOnboardingQuestions()) ;
//   });
//
//
//
//
// }
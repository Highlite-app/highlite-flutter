// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:highlite_flutter_mvp/core/usecases/usescases.dart';
// import 'package:highlite_flutter_mvp/domain/entites/onboarding/onboarding_questions.dart';
// import 'package:highlite_flutter_mvp/domain/repositories/onboarding_repositoy.dart';
//
// import '../../../core/error/failure.dart';
//
// class GetQuestions implements UseCase<OnBoardingQuestions , NoParams>{
//   final OnBoardingRepository questionRepository ;
//
//   GetQuestions(this.questionRepository);
//
//   @override
//   Future<Either<Failure, OnBoardingQuestions>> call( NoParams params) async{
//     return await questionRepository.getOnboardingQuestions();
//   }
// }
//
// class NoParams extends Equatable{
//   @override
//   List<Object?> get props => [];
//
// }

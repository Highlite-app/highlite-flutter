// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:highlite_flutter_mvp/core/error/failure.dart';
// import 'package:highlite_flutter_mvp/core/usecases/usescases.dart';
// import 'package:highlite_flutter_mvp/data/models/apis/login/email_otp.dart';
// import 'package:highlite_flutter_mvp/domain/repositories/onboarding/onboarding_repositoy.dart';
//
// class GetEmailOtp implements UseCase<EmailOtpResponse, Params> {
//   final OnBoardingRepository onBoardingRepository;
//
//   GetEmailOtp(this.onBoardingRepository);
//
//   @override
//   Future<Either<Failure, EmailOtpResponse>> call(Params params) async {
//     return await onBoardingRepository.getLoginWithEmailOtp(params.email);
//   }
// }
//
// class Params extends Equatable {
//   final String email;
//
//   const Params({required this.email});
//
//   @override
//   List<Object?> get props => [email];
// }

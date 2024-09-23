import 'package:equatable/equatable.dart';

class LoginInWithEmailOtp extends Equatable{
  final double otp ;

  const LoginInWithEmailOtp({required this.otp}) ;

  @override
  List<Object?> get props => [otp];
}
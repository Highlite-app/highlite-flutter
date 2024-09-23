import 'package:equatable/equatable.dart';

 class OnBoardingQuestions extends Equatable{
  final String question ;

  const OnBoardingQuestions({
    required this.question,
  });

  @override
  List<Object?> get props => [question ];
}
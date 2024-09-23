import 'package:equatable/equatable.dart';

class CountryCity extends Equatable{
  final String country;
  final String city;
  const CountryCity({required this.country,required this.city});

  @override
  List<Object> get props => [city];
}

class CountryCode {
  final String name;
  final String dialCode;
  final String emoji;
  final String code;
  
  const CountryCode({required this.name,required this.dialCode, required this.emoji, required this.code});
}
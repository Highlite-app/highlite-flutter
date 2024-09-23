import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([

], customMocks: [
  MockSpec<Dio>(as: #MockDioClint),
  MockSpec<Connectivity>(as: #MockConnectivity)
])
void main() {}
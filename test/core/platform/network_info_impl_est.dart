import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:highlite_flutter_mvp/core/platform/network_info.dart';
import 'package:mockito/mockito.dart';


class MockConnectivity extends Mock implements Connectivity{}


void main() {
  group('NetworkInfo', () {
    // Create a mock instance of Connectivity
     MockConnectivity mockConnectivity = MockConnectivity();


    // Create an instance of NetworkInfoImpl
     NetworkInfoImpl networkInfo = NetworkInfoImpl( mockConnectivity) ;

    setUp(() {
      mockConnectivity = MockConnectivity();
      networkInfo = NetworkInfoImpl( mockConnectivity);
    });

    test('isConnected returns true on mobile connectivity', () async {
      // Arrange
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.mobile);

      // Act
      final result = await networkInfo.isConnected();

      // Assert
      expect(result, true);
    });

    test('isConnected returns true on bluetooth connectivity', () async {
      // Arrange
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.bluetooth);

      // Act
      final result = await networkInfo.isConnected();

      // Assert
      expect(result, true);
    });

    test('isConnected returns true on wifi connectivity', () async {
      // Arrange
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.wifi);

      // Act
      final result = await networkInfo.isConnected();

      // Assert
      expect(result, true);
    });

    test('isConnected returns true on ethernet connectivity', () async {
      // Arrange
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.ethernet);

      // Act
      final result = await networkInfo.isConnected();

      // Assert
      expect(result, true);
    });

    test('isConnected returns false on no connectivity', () async {
      // Arrange
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.none);

      // Act
      final result = await networkInfo.isConnected();

      // Assert
      expect(result, false);
    });

    // Add more test cases as needed for different connectivity scenarios

    // Don't forget to verify that the mock was called as expected
    tearDown(() {
      verify(mockConnectivity.checkConnectivity()).called(1);
    });
  });
}

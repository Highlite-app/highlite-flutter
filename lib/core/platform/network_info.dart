import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool>  isConnected();
}
class NetworkInfoImpl extends NetworkInfo {
  final Connectivity _connectivity ;

  NetworkInfoImpl( this._connectivity);

  @override
  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();

    switch (result) {
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.bluetooth:
        return true;
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.ethernet:
        return true;
      case ConnectivityResult.none:
        return false;
      case ConnectivityResult.vpn:
        return false;
      case ConnectivityResult.other:
        return false;
      default:
        return false;
    }
  }
}
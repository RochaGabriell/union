/* Package Imports */
import 'package:connectivity_plus/connectivity_plus.dart';

abstract interface class ConnectionChecker {
  Future<bool> get connected;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final Connectivity _connection;

  ConnectionCheckerImpl(this._connection);

  @override
  Future<bool> get connected async {
    final checkerConnection = await _connection.checkConnectivity();
    if (checkerConnection.contains(ConnectivityResult.mobile) ||
        checkerConnection.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      return false;
    }
  }
}

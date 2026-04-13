import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
  ConnectivityProvider() {
    _initialize();
  }

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool _isConnected = true;
  bool get isConnected => _isConnected;

  Future<void> _initialize() async {
    final List<ConnectivityResult> results =
        await _connectivity.checkConnectivity();
    _isConnected = _hasConnection(results);
    notifyListeners();

    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      _isConnected = _hasConnection(results);
      notifyListeners();
    });
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.any((ConnectivityResult item) => item != ConnectivityResult.none);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

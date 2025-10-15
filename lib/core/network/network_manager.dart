import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

class NetworkManager {
  NetworkManager._(); // private constructor for singleton
  static Future<bool> isConnected() async {
    try {
      final connectivity = Connectivity();

      final result = await connectivity.checkConnectivity();
      return !result.contains(ConnectivityResult.none);
    } on PlatformException {
      return false;
    }
  }
}

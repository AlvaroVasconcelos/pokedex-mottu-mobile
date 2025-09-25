import 'dart:async';

import 'package:flutter/services.dart';

class ConnectivityService {

  ConnectivityService() {
    _channel.setMethodCallHandler(_handleMethod);
  }
  static const _channel = MethodChannel('connectivity_status');
  final _connectivityStreamController = StreamController<String>.broadcast();

  Stream<String> get connectivityStream => _connectivityStreamController.stream;

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'status':
        _connectivityStreamController.add(call.arguments as String);
      default:
        throw MissingPluginException();
    }
  }

  void dispose() {
    _connectivityStreamController.close();
  }
}

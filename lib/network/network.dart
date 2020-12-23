import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkService extends ChangeNotifier {
  static NetworkService _sInstance;
  NetworkService._();
  factory NetworkService.shared() {
    if(_sInstance == null) {
      _sInstance = NetworkService._();
    }
    return _sInstance;
  }

}
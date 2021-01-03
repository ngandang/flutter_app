import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/src/module.dart';

class ApiService extends ChangeNotifier{
  static ApiService _sInstance;

  ApiService._();

  factory ApiService.shared() {
    if (_sInstance == null) {
      _sInstance = ApiService._();
    }
    return _sInstance;
  }

  Future<Album> getData() async {
    final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');
    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

}

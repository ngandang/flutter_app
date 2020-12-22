import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerInfo extends ChangeNotifier {
  String id = '';
  String name = '';
  String phoneNumber = '';
  String salutation = '';
  String email = '';
  String password = '';
  String gender = '';
  bool isAccept = false;

}
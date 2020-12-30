import 'package:flutter/material.dart';

class Order extends ChangeNotifier{
  String orderDate;
  double orderId;
  String orderBy;
  String message;
  String status;
  bool selected;

  Order({this.orderDate ='', this.orderId=0,this.orderBy='', this.message='', this.status='' , this.selected = false});

  void setStatus(String stt) {
    status = stt;
    notifyListeners();

  }
}
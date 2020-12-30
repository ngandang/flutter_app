import 'package:flutter/material.dart';

import 'order.dart';

class OrderModel extends ChangeNotifier{
  List<Order> orders = [];
  OrderModel({this.orders});

  void addOrder(Order _order) {
    orders?.add(_order);
    notifyListeners();
  }
  void fill(List<Order> _list) {
    orders = [];
    _list.forEach((element) {
      orders?.add(element);
    });
    print(orders);
    notifyListeners();
  }

}
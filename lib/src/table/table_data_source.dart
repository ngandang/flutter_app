export 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/src/module.dart';

class TableDataSource extends DataTableSource {

  TableDataSource({this.context, this.orders, this.changeStatus});
  final BuildContext context;
  List<Order> orders;
  final Function(int, String) changeStatus;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    final order = orders[index];
    return DataRow.byIndex(
        index: index,
        selected: order.selected,
        onSelectChanged: (value) {
          if (order.selected != value) {
            _selectedCount += value ? 1: -1;
            order.selected = value;
            notifyListeners();
          }
        },
        cells: [
          DataCell(Text(order.orderDate)),
          DataCell(Text('${order.orderId}')),
          DataCell(Text(order.orderBy)),
          DataCell(Text(order.message)),
          DataCell(Center(
            child: Text(order.status),
          )),
          DataCell(
              Center(
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        openDialog(context: context,
                            title: 'Approve',
                            content: Text('Approved'),
                            onOk: () => this.changeStatus(index, 'Approved')
                        );
                      },
                      child: Container(
                          width: 80,
                          height:40,
                          alignment: Alignment.center,
                          color: Colors.blueAccent,
                          child: Text('Aprrove',
                            style: TextStyle(color: Colors.white),)
                      ),
                    ),
                    SizedBox(width: 20),
                    TextButton(
                      onPressed: () {
                        openDialog(context: context, title: 'Reject',
                            content: Text('Rejected'),
                            onOk: ()
                            => this.changeStatus(index, 'Rejected')

                        );
                      },
                      child: Container(
                          width: 80,
                          height:40,
                          alignment: Alignment.center,
                          color: Colors.red,
                          child: Text('Reject',
                            style: TextStyle(color: Colors.white),)
                      ),
                    )
                  ],
                ),
              )
          )
        ]
    );
  }

  @override
  int get rowCount => orders.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

}
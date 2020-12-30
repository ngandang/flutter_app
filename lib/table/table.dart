export 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/model/order_model.dart';
import 'package:flutter_app/module.dart';
import 'package:flutter_app/table/table_data_source.dart';
import 'package:provider/provider.dart';

ChangeNotifierProvider<OrderModel> createTableView() {
  return ChangeNotifierProvider(
    create: (_) => OrderModel(),
    child: TableView(),
  );
}

class TableView extends StatefulWidget {

  @override
  _TableState createState() => _TableState();
}
class _TableState extends State<TableView> {
  bool isSortAscending = false;
  int rowsPerPage = 5;
  int sortColumnIndex = 0;
  
  final List<Order> orders = [
    Order(orderDate: '11/1/2011', orderId: 4, orderBy: 'ngan dang', message: 'message', status: 'Request', selected: false),
    Order(orderDate: '12/6/2012', orderId: 2, orderBy: 'test', message: 'test message', status: 'Request', selected: false),
    Order(orderDate: '6/4/2019', orderId: 5, orderBy: 'lala', message: 'test test message', status: 'Request', selected: false),
    Order(orderDate: '12/1/2020', orderId: 4, orderBy: 'abc', message: 'message', status: 'Request', selected: false),
    Order(orderDate: '12/1/2014', orderId: 3, orderBy: 'hehe', message: 'message', status: 'Request', selected: false),
    Order(orderDate: '12/1/2014', orderId: 9, orderBy: 'haha', message: 'message', status: 'Request', selected: false),
    Order(orderDate: '12/1/2015', orderId: 8, orderBy: 'alex', message: 'message', status: 'Request', selected: false),
    Order(orderDate: '12/1/2018', orderId: 6, orderBy: 'lyly', message: 'message', status: 'Request', selected: false)
  ];
  @override
  void initState() {
    super.initState();
  }

  onSortColumn(int columnIndex, bool ascending) {
    sortColumnIndex = columnIndex;
    if (columnIndex == 1){
      if (ascending) {
        orders.sort((a,b) => a.orderId.compareTo(b.orderId));
      } else {
        orders.sort((a,b) => b.orderId.compareTo(a.orderId));
      }
    } else {
      if (columnIndex == 2){
        if (ascending) {
          orders.sort((a,b) => a.orderBy.compareTo(b.orderBy));
        } else {
          orders.sort((a,b) => b.orderBy.compareTo(a.orderBy));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderModel>(
        builder: (context, orderModel, child)
        {
          return Column(
            children: [
              Container(
                height: 60,
                child: Center(
                  child: Text('Table',
                    style: TextStyle(
                      fontSize: 20,
                    ),),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(40),
                  child: PaginatedDataTable(
                    sortAscending: isSortAscending,
                    sortColumnIndex: sortColumnIndex,
                    header: Text('Header'),
                    // onSelectAll: (value) {
                    //   setState(() {
                    //     for(int i=0; i< orders.length; i++) {
                    //       orders[i].selected = value;
                    //     }
                    //   });
                    // },
                    actions: [
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          setState(() {
                            for(int i=0; i< orders.length; i++) {
                              orders[i].selected = false;
                            }
                          });
                        },
                      ),

                    ],
                    rowsPerPage: rowsPerPage <= orders.length ? rowsPerPage : orders
                        .length,
                    onPageChanged: (value) {
                      if (value + rowsPerPage > orders.length) {
                        setState(() {
                          rowsPerPage = orders.length % 5;
                        });
                      } else {
                        setState(() {
                          rowsPerPage = 5;
                        });
                      }
                    },

                    columns: [
                      DataColumn(
                        label: Text(
                          'Order Date',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      DataColumn(
                          label: Text(
                            'Order ID',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          onSort: (columnIndex, sortAscending) {
                            setState(() {
                              isSortAscending = !isSortAscending;
                            });
                            onSortColumn(columnIndex, sortAscending);
                          }
                      ),
                      DataColumn(
                          label: Text(
                            'Order By',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          onSort: (columnIndex, sortAscending) {
                            setState(() {
                              isSortAscending = !isSortAscending;
                            });
                            onSortColumn(columnIndex, sortAscending);
                          }
                      ),
                      DataColumn(
                          label: Text(
                            'Order Message',
                            style: TextStyle(
                                fontWeight: FontWeight.w700
                            ),
                          )
                      ),
                      DataColumn(
                          label: Text(
                            'Status',
                            style: TextStyle(
                                fontWeight: FontWeight.w700
                            ),
                          )
                      ),
                      DataColumn(
                          label: Text(
                            '',
                          )
                      )
                    ],
                    source: TableDataSource(
                        context: context,
                        orders: orders,
                        changeStatus: (index, status) {
                          setState(() {
                            orders[index].status = status;
                          });
                        }
                    ),
                  ),
                ),
              )
            ],
          );
        }
    );
  }

}


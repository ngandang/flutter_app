export 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/module.dart';

class TableView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
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
            child: Table(
              border: TableBorder(
                horizontalInside: BorderSide(color: Colors.grey),
                top: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey),

              ),

              children: [
                TableRow(children: [
                  buildHeader('Date'),
                  buildHeader('Id'),
                  buildHeader('Name'),
                  buildHeader('Message'),
                  buildHeader('Status')
                ],
                ),
                TableRow(children: [
                  buildContent('11/11/2011'),
                  buildContent('012'),
                  buildContent('Ngan'),
                  buildContent('This is aMessage'),
                  buildContent('Approve'),
                ]),
                TableRow(children: [
                  buildContent('11/11/2011'),
                  buildContent('012'),
                  buildContent('Ngan'),
                  buildContent('This is a Message'),
                  buildContent('Approve'),
                ])
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildHeader(String text) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(text,
        style: TextStyle(
          fontWeight: FontWeight.w600
        ),),
      )
    );
  }

  Widget buildContent(String text) {
    return Container(
      height: 60,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text),
      ),
    );
  }
}
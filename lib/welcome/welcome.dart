import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Welcome extends StatelessWidget{

  final today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(child: Text(
              'Hello',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 40
              ),
            )),
          ),
        Container(
          child: Column(
            children: [
              // Text('Date Time: $today'),
              // Text('${DateFormat.yMMMd().add_Hms().format(today)}'),
              // Text('${DateFormat.yMd().add_Hms().format(today)}'),
              // Text('${DateFormat('dd/MM/yyyy, hh.mm.ss').format(today)}')
            ],
          ),
        )
      ]
    );
  }
}
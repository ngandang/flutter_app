import 'package:flutter/material.dart';
import 'package:flutter_app/quick_menu/quick_menu.dart';
import 'package:flutter_app/src/list_view/list_view.dart';
import 'package:flutter_app/src/module.dart';
import 'package:flutter_app/src/table/table.dart';
import 'package:flutter_app/welcome/welcome.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);




  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton<String> (
            onSelected: (result) {
              setState(() {
                pageIndex = int.parse(result);
              });
            },
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Icon(
                    Icons.menu
                ),
              ),
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: '0',
                    child: Text('Home'),

                  ),
                  const PopupMenuItem(
                    value: '1',
                    child: Text('Product'),
                  ),
                  const PopupMenuItem(
                    value: '2',
                    child: Text('Setting'),
                  ),


                ];
              }


          )
        ],
      ),
      body: buidBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: QuickMenu(),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: pageIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.card_travel),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.table_view),
            label: 'Table',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.list),
            label: 'List View',
          ),

        ],
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        }

      ),
    );
  }

  Widget buidBody() {
    switch (pageIndex) {
      case 0:
        return Welcome();
      case 1:
        return ProductView();
      case 2:
        return createProfileView();
      case 3:
        return createTableView();
      case 4:
        return ListItemView();
    }

  }
}

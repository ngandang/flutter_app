import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../module.dart';

class ProductView extends StatefulWidget {


  @override
  _ProductViewState createState() => _ProductViewState();
}
class _ProductViewState extends State<ProductView> {
  int selectedModel = 0;

  final List<String> models = ['Kona', 'Paradise', 'IONIQ'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.white70,
          title: Container(
            height: 60,
            child: Center(child: Text(
                'Product',
              style: TextStyle(
                color: Colors.black
              ),
            )),
          ),
        ) ,
      body: buildBody(),
    );
  }
  buildBody() {
    return Column(
      children: [
        Container(
          height: 60,
          margin: EdgeInsets.only(left: 30),
          child: Row(
            children: [
              FlatButton(

                color: Colors.blue,
                minWidth: 100,
                height: 50,
                onPressed: (){
                  openDialog(
                    context: context,
                    title: 'Alert',
                    content: Text('This is a alert popup'),
                  );
                },
                child: Text(
                    'Alert',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),
                ),

              ),
              SizedBox(width: 30),
              FlatButton(
                color: Colors.blue,
                minWidth: 100,
                height: 50,
                onPressed: (){
                  openDialog(
                    context: context,
                    title: 'Confirm',
                    isCancel: true,
                    content: Text('This is confirm popup'),
                  );
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  ),
                ),

              )
            ],
          ),
        ),
        
        Expanded(
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                margin: EdgeInsets.only(left: 30, right: 30),
                child: ListView(
                  children: [
                    for (int i = 0; i< models.length ; i ++)
                    ListTile(
                      title: Text (models[i]),
                      selected: selectedModel == i,
                      selectedTileColor: Colors.black12,
                      onTap: () {
                        setState(() {
                          selectedModel = i;
                        });
                      },
                    ),

                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: buildListModel(),
                )

              )
            ],
          ),
        ),
      ],
    );
  }
  buildListModel() {
    switch (selectedModel) {
      case 0 :
        return Wrap (
            children: [
              for (int i = 0; i < 10; i++)
                Container(
                  width: 300,
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black12,
                          width: 1
                      )
                  ),
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Image.asset('assets/kona.png'),
                      Center(child: Text(
                        'Kona',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.indigo
                        ),
                      )),
                      Text(
                        'Price : 2000',
                        style: TextStyle(
                            fontSize: 14
                        ),
                      )
                    ],
                  ),
                )
            ]
        );
      case 1:
        return Wrap (
            children: [
              for (int i = 0; i < 5; i++)
                Container(
                  width: 300,
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black12,
                          width: 1
                      )
                  ),
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Image.asset('assets/kona_electric.png'),
                      Center(child: Text(
                        'Paradise',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.indigo
                        ),
                      )),
                      Text(
                        'Price : 4000',
                        style: TextStyle(
                            fontSize: 14
                        ),
                      )
                    ],
                  ),
                )
            ]
        );
      case 2:
        return Center(
          child: Text('No data'),
        );


    }
  }
}
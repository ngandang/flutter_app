import 'package:flutter/material.dart';
import 'package:flutter_app/src/dialog/dialog.dart';

class QuickMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QuickMenuState();
}

class QuickMenuState extends State<QuickMenu> {
  bool showMenu = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: showMenu ? 300 : 60,
        height: showMenu ? 240: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: (){
                setState(() {
                  showMenu = !showMenu;
                });
              },
              child: Text('Quick Menu',
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(),
            ),
            !showMenu ?
            Container() :
            Container(
              child: Column(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 60,
                      child: FlatButton(
                        color: Colors.black,
                        textColor: Colors.white,
                        disabledColor: Colors.black,
                        disabledTextColor: Colors.white,
                        child: Row(
                          children: [
                              Icon(Icons.drive_eta),
                            Text('Request a Test Drive'),
                          ],
                        ),
                        onPressed: () => openDialog(context: context, content: Text('This is a Test Drive')),

                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 60,
                      child: FlatButton(
                        color: Colors.black,
                        textColor: Colors.white,
                        disabledColor: Colors.black,
                        disabledTextColor: Colors.white,
                        child: Row(
                          children: [
                            Icon(Icons.car_rental),
                            Text('Request a Trade-in'),
                          ],
                        ),

                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 60,
                      child: FlatButton(
                        color: Colors.black,
                        textColor: Colors.white,
                        disabledColor: Colors.black,
                        disabledTextColor: Colors.white,
                        child: Row(
                          children: [
                            Icon(Icons.request_quote),
                            Text('Get a Quote'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 60,
                      child: FlatButton(
                        color: Colors.black,
                        textColor: Colors.white,
                        disabledColor: Colors.black,
                        disabledTextColor: Colors.white,
                        child: Row(
                          children: [
                            Icon(Icons.contact_page),
                            Text('Contact Us'),
                          ],
                        ),
                      ),
                    ),
                  ],
              ),
            )
          ]
        )

    );
  }
}
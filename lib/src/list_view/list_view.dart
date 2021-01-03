import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/album.dart';
import 'package:http/http.dart' as http;

class ListItemView extends StatefulWidget{
   @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends State<ListItemView> {
  int selectedModel = 0;

  Album album;

  List<Album> _album = List<Album>();

  Future<List<Album>> fetchNote() async {
    var url = 'https://jsonplaceholder.typicode.com/albums';
    var response = await http.get(url);

    var albums = List<Album>();
    if (response.statusCode == 200){
      var albumsJson = json.decode(response.body);
      for(var albumJson in albumsJson){
        albums.add(Album.fromJson(albumJson));
      }
    }
    return albums;
  }

  @override
  Widget build(BuildContext context) {
    fetchNote().then((value) {
      setState(() {
        _album.addAll(value);
      });
    });

    return Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.white70,
          title: Container(
            height: 60,
            child: Center(child: Text(
                'List View',
              style: TextStyle(
                color: Colors.black
              ),
            )),
          ),
        ) ,
      body: ListView.builder(
        itemBuilder:(context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text('${_album[index].userId}'),
                  Text(_album[index].title)
                ]
              ),
            ),
          );
        },
        itemCount: _album.length,
      ),
    );
  }
}
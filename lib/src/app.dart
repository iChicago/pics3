import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import './models/image.dart';
import 'dart:convert';
import 'widgets/image_list.dart';

class App extends StatefulWidget{
  createState(){
    return AppState();
  }
}

class AppState extends State<App>{
  int counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    counter++;
    // response contains Json and other information
    var response = await get('https://jsonplaceholder.typicode.com/photos/$counter');
    // we care only about json response
    var imageModel = new ImageModel.fromJson(json.decode(response.body));

    setState(() {
      images.add(imageModel);
    });
  }

  Widget build(context){
    return MaterialApp(
      home: Scaffold(
        body: ImageList(images),
        floatingActionButton:  FloatingActionButton(
          onPressed: (){
            print('button pressed, await content...');
            fetchImage();
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Let us see some images!'),
        ),
      ),
    );
  }


}
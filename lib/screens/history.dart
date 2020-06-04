import 'package:flutter/material.dart';

class History extends StatelessWidget{
  final String title;
  History(this.title);

  @override
  Widget build(BuildContext context){

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("History"),
      ),
      body: new Center(
        child: new Text(title),
      ),

    );

  }
}
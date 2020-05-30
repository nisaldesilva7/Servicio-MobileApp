import 'package:flutter/material.dart';
import 'package:servicio/screens/home/home.dart';

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
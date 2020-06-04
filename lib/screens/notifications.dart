import 'package:flutter/material.dart';
class Notifications extends StatelessWidget{
  final String title;
  Notifications(this.title);
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Notifications"),
      ),
      body: new Center(
        child: new Text(title),
      ),
    );
  }
}
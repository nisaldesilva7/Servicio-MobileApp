import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget{
  final String title;
  MyProfile(this.title);
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Hi! Tamasha"),
      ),
      body: new Center(
        child: new Text(title),
      ),
    );
  }
}
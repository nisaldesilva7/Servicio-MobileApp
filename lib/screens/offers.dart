import 'package:flutter/material.dart';
import 'package:servicio/screens/home/home.dart';
class Offers extends StatelessWidget{
  final String title;
  Offers(this.title);
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Offers"),
      ),
      body: new Center(
        child: new Text(title),
      ),
    );
  }
}
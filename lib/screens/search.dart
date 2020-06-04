import 'package:flutter/material.dart';
class Search extends StatelessWidget{
  final String title;
  Search(this.title);
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Search"),
      ),
      body: new Center(
        child: new Text(title),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class HelpAndFeedback extends StatelessWidget{
  final String title;
  HelpAndFeedback(this.title);
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Help & Feedback"),
      ),
      body: new Center(
        child: new Text(title),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class MyBookings extends StatelessWidget{
  final String title;
  MyBookings(this.title);
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Bookings"),
      ),
      body: new Center(
        child: new Text(title),
      ),
    );
  }
}
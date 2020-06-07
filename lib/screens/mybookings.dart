import 'package:flutter/material.dart';

class MyBookings extends StatefulWidget{
  final String title;
  MyBookings(this.title);

  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Bookings"),
      ),
      body: new Container(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: new Text("Home"),
                backgroundColor: Colors.teal
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: new Text("Search"),
              backgroundColor: Colors.teal,
              //activeIcon: Icon(Icons.accessibility),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: new Text("Notifications"),
              backgroundColor: Colors.teal,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.offline_bolt),
              title: new Text("Offers"),
              backgroundColor: Colors.teal,
            ),
          ],

          onTap: (index){
            setState((){
              _currentIndex =index;
            });
          },
        ) ,
    );
  }
}
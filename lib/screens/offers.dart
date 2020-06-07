import 'package:flutter/material.dart';

class Offers extends StatefulWidget{
  final String title;
  Offers(this.title);

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Offers"),
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
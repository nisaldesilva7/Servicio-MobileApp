import 'package:flutter/material.dart';

class History extends StatefulWidget{
  final String title;
  History(this.title);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context){

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("History"),
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
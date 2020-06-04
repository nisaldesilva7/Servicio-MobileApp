import 'package:flutter/material.dart';
import 'package:servicio/screens/notifications.dart';
import 'package:servicio/screens/offers.dart';
import 'package:servicio/screens/search.dart';

import 'home/home.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
        theme: new ThemeData(primarySwatch: Colors.indigo),
        home: new Home(),
        routes: <String, WidgetBuilder>{
          "home": (BuildContext context)=> new Home(),
          "search": (BuildContext context)=> new Search("Search"),
          "notifications": (BuildContext context)=> new Notifications("Notifications"),
          "offers": (BuildContext context)=> new Offers("Offers"),

        }
    );
  }
}
class BottomIcons extends StatefulWidget{
  int _currentIndex = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
              backgroundColor: Colors.teal,
              //onTap: () => Navigator.of(context).pushNamed("home")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: new Text("Search"),
            backgroundColor: Colors.teal,
            //onTap: () => Navigator.of(context).pushNamed("search")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: new Text("Notifications"),
            backgroundColor: Colors.teal,
            //onTap: () => Navigator.of(context).pushNamed("notifications")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.offline_bolt),
            title: new Text("Offers"),
            //onTap: () => Navigator.of(context).pushNamed("offers"),
            backgroundColor: Colors.teal,
          ),
        ],
      ) ,
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

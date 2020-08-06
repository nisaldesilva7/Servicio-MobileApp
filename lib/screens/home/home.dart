import 'package:flutter/material.dart';
import 'package:servicio/screens/home/bottom_navs/bookings_view.dart';
import 'package:servicio/screens/home/bottom_navs/main_view.dart';
import 'package:servicio/services/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:servicio/screens/home/bottom_navs/search.dart';

import 'bottom_navs/main_menu.dart';
import 'bottom_navs/profile.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
        theme: new ThemeData(primarySwatch: Colors.indigo),
        home: new Home(),
    );
  }
}

class Home extends StatefulWidget{

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home>{
  int _currentIndex = 0;
  final List<Widget> _bottomNavs = [
    MainView(),
    SearchView(),
    MainMenu(),
    HomePage(),
    ProfileThreePage(),

  ];
  final AuthServices _auth = AuthServices();


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Servicio', style: TextStyle(fontFamily: 'icomoon'),),
          elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
          backgroundColor: Colors.blue[600],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {

              },
            ),
            FlatButton(
                onPressed: () async {
                  await _auth.signOut();
                },
                child: Text('LOGOUT', style: TextStyle(color: Colors.grey[100],),
                ),
            )
          ],
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("Tamasha Seneviratne"),
                accountEmail: new Text("tamzsene@gmail.com"),
                currentAccountPicture: InkWell(
                  child: new CircleAvatar(
                    backgroundColor: Colors.black26,
                    child: new Text("T"),
                  ),
                  onTap: () {
                    return Navigator.of(context).pushNamed("/image");
                  },
                ),
              ),
              new ListTile(
                title: new Text("Home"),
                trailing: new Icon(Icons.home, color: Colors.indigo,),
                onTap: () => Navigator.of(context).pop(),
              ),
              _divider(),
              ListTile(
                title: new Text("My Vehicles"),
                trailing: new Icon(Icons.directions_car, color: Colors.indigo,),
                  onTap: () => Navigator.of(context).pushNamed('/vehicle')
              ),
              new ListTile(
                title: new Text("My Profile"),
                trailing: new Icon(Icons.person,color: Colors.indigo,),
                onTap: () => Navigator.of(context).pushNamed('/profile')
              ),
              new ListTile(
                title: new Text("My Bookings"),
                trailing: new Icon(Icons.bookmark,color: Colors.indigo,),
                onTap: () => Navigator.of(context).pushNamed("/bookings"),
              ),
              _divider(),
              new ListTile(
                title: new Text("Notifications"),
                trailing: new Icon(Icons.message,color: Colors.indigo,),
                onTap: () => Navigator.of(context).pushNamed("/notifications"),
              ),
              new ListTile(
                title: new Text("Select Image"),
                trailing: new Icon(Icons.image, color: Colors.indigo,),
                onTap: () => Navigator.of(context).pushNamed("/image"),
              ),
              new ListTile(
                title: new Text("Help & Feedback"),
                trailing: new Icon(Icons.feedback,color: Colors.indigo,),
                onTap: () => Navigator.of(context).pushNamed("/feedback"),
              ),
              _divider(),
              new ListTile(
                title: new Text("Log Out"),
                trailing: new Icon(Icons.lock,color: Colors.indigo,),
                onTap: ()  async {
                  await _auth.signOut();
                  },
              ),
            ],
          ),
        ),
        body:  _bottomNavs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: new Text("Home"),
                backgroundColor: Colors.grey
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: new Text("Search"),
              backgroundColor: Colors.teal,
              //activeIcon: Icon(Icons.accessibility),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              title: new Text("Main"),
              backgroundColor: Colors.teal,
              //activeIcon: Icon(Icons.accessibility),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.collections_bookmark),
              title: new Text("Bookings"),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_ind),
              title: new Text("Profile"),
              backgroundColor: Colors.yellow,
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
  Widget _divider(){
    return Divider(thickness: 3.0, indent: 13.0, endIndent: 20.0, height: 1.0, color: Colors.indigo[200],);
  }
}

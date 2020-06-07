import 'package:flutter/material.dart';
import 'package:servicio/services/auth.dart';
import 'package:flutter/foundation.dart';


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
  final AuthServices _auth = AuthServices();


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Servicio '),
          elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
          backgroundColor: Colors.blue[600],
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.call_missed_outgoing),
                label: Text(
                    'LOGOUT',
                    style: TextStyle(
                      color: Colors.grey[100],

                    ),
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
                trailing: new Icon(Icons.home),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                title: new Text("My Vehicles"),
                trailing: new Icon(Icons.directions_car),
                  onTap: () => Navigator.of(context).pushNamed('/vehicle')
              ),
              new ListTile(
                title: new Text("My Profile"),
                trailing: new Icon(Icons.person),
                onTap: () => Navigator.of(context).pushNamed('/profile')
              ),
              new ListTile(
                title: new Text("My Bookings"),
                trailing: new Icon(Icons.bookmark),
                onTap: () => Navigator.of(context).pushNamed("/bookings"),
              ),
              new ListTile(
                title: new Text("Notifications"),
                trailing: new Icon(Icons.message),
                onTap: () => Navigator.of(context).pushNamed("/notifications"),
              ),
              new ListTile(
                title: new Text("Select Image"),
                trailing: new Icon(Icons.image),
                onTap: () => Navigator.of(context).pushNamed("/image"),
              ),
              new ListTile(
                title: new Text("Help & Feedback"),
                trailing: new Icon(Icons.feedback),
                onTap: () => Navigator.of(context).pushNamed("/feedback"),
              ),
              new ListTile(
                title: new Text("Log Out"),
                trailing: new Icon(Icons.lock),
                onTap: ()  async {
                  await _auth.signOut();
                  },
              ),
            ],
          ),
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

import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:servicio/models/vehicle.dart';

class MyVehicles extends StatefulWidget {

  @override
  _MyVehiclesState createState() => _MyVehiclesState();
}

class _MyVehiclesState extends State<MyVehicles> {
  int _currentIndex = 0;
  final List<Vehicle> vehiclelist = [
    Vehicle('520d', '2017bmw150', 'BMW' , '2020'),
    Vehicle('520d', '2017bmw150', 'BMW' , '2020'),
    Vehicle('520d', '2017bmw150', 'BMW' , '2020'),
    Vehicle('520d', '2017bmw150', 'BMW' , '2020'),
    Vehicle('520d', '2017bmw150', 'BMW' , '2020'),
  ];


//  AlertDialog alert = AlertDialog(
//    title: Text("AlertDialog"),
//    content: Text("Would you like to continue learning how to use Flutter alerts?"),
//    actions: [
//      FlatButton(
//        child: Text("Cancel"),
//        onPressed:  () {},
//      ),
//      FlatButton(
//        child: Text("Continue"),
//        onPressed:  () {},
//      ),
//    ],
//  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("My Vehicles"),
        actions: <Widget>[
            IconButton(
                tooltip: 'Add New Vehicle',
                icon: Icon(Icons.add),
                onPressed: () {

                }
            )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
        child: new ListView.builder(
            itemCount: vehiclelist.length,
            itemBuilder: (BuildContext context, int index) =>
                buildTripCard(context, index)),
      ),
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

  Widget buildTripCard(BuildContext context, int index) {
    final vehicle = vehiclelist[index];

    return  Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(vehicle.model, style: new TextStyle(fontSize: 30.0),),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.add_to_photos),
                    tooltip: 'Modfiy Vehicle',
                    onPressed: () {
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline),
                    tooltip: 'Delete Vehicle',
                    onPressed: () {
                     //return alert;
                    },
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                child: Row(children: <Widget>[
                  Text(vehicle.brand),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(vehicle.regNo, style: new TextStyle(fontSize: 35.0),),
                    Spacer(),
                    Icon(Icons.directions_car),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
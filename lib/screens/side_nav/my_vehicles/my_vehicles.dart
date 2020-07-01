import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:servicio/models/vehicle.dart';
import 'package:servicio/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class MyVehicles extends StatefulWidget {

  @override
  _MyVehiclesState createState() => _MyVehiclesState();
}

class _MyVehiclesState extends State<MyVehicles> {

  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  fixed swipe up card

//      bottomSheet: SolidBottomSheet(
//        headerBar: Container(
//          color: Theme.of(context).primaryColor,
//          height: 50,
//          child: Center(
//            child: Text("Swipe me!"),
//          ),
//        ),
//        body: Container(
//          color: Colors.white,
//          height: 30,
//          child: Center(
//            child: Text(
//              "Hello! I'm a bottom sheet :D",
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ),
//        ),
//      ),
      appBar: new AppBar(
        title: new Text("My Vehicles"),
        actions: <Widget>[
          IconButton(
              tooltip: 'Add New Vehicle',
              icon: Icon(Icons.add),
              onPressed: () {
                return Navigator.of(context).pushNamed('/addnewvehicle');
              }
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: StreamBuilder(
            stream: getUsersTripsStreamSnapshots(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return
                ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildTripCard(context, snapshot.data.documents[index])
                );
            }
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(BuildContext context) async* {
    final uid = await _auth.getCurrentUID();
    yield* Firestore.instance.collection('users').document(uid).collection('vehicles').snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot document) {

    final vehicle = Vehicle.fromSnapshot(document);
    print(vehicle.vehicleId);

    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(vehicle.brand, style: new TextStyle(fontSize: 30.0),),
                  Spacer(),
                  IconButton(icon: Icon(Icons.add_to_photos), tooltip: 'Modfiy Vehicle',
                    onPressed: ()  {
                      _tripEditModalBottomSheet(context);
                      },
                  ),
                  IconButton(icon: Icon(Icons.delete_outline), tooltip: 'Delete Vehicle',
                    onPressed: () async {
                      showAlertDialog(context,vehicle.vehicleId);
                    },
                  ),
                ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                child: Row(children: <Widget>[
                  Text(vehicle.model),
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

  showAlertDialog(BuildContext context , String id) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed:  () async {
        var uid = await _auth.getCurrentUID();
        final doc = Firestore.instance.collection('users').document(uid).collection("vehicles").document(id);
        Navigator.pop(context);
        return await doc.delete();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure?"),
      content: Text("dvdsdvvsdv"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  void _tripEditModalBottomSheet(context) {
    showModalBottomSheet(context: context, builder: (BuildContext bc) {
      return Container(
          height: MediaQuery.of(context).size.height * .60,
          color: Colors.indigo,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Edit Trip"),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel, color: Colors.orange, size: 25,),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )

                  ],
                ),
                Row(
                    children: [
                      Text(
                        'trip.title',
                        style: TextStyle(fontSize: 30, color: Colors.green[900]),
                      ),
                    ]
                )
              ],
            ),
          )
      );
    });
  }



}
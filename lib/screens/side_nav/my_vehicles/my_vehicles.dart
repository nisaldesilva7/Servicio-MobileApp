import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicio/models/vehicle.dart';
import 'package:servicio/screens/side_nav/my_vehicles/Vehicle_details_view.dart';
import 'package:servicio/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyVehicles extends StatefulWidget {

  @override
  _MyVehiclesState createState() => _MyVehiclesState();
}

class _MyVehiclesState extends State<MyVehicles> {

  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          height: 90,
          padding: const EdgeInsets.only(top: 20.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              )),
          child: ListTile(
            trailing: IconButton(
                tooltip: 'Add New Vehicle',
                icon: Icon(Icons.add,color: Colors.white,),
                onPressed: () {
                  return Navigator.of(context).pushNamed('/addnewvehicle');
                }
            ),
            leading: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "My Vehicles".toUpperCase(),
              style: GoogleFonts.quicksand(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(90.0),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: StreamBuilder(
            stream: getUsersTripsStreamSnapshots(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: const CircularProgressIndicator());
              return
                ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildList(context, snapshot.data.documents[index])
                );
            }
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(BuildContext context) async* {
    final uid = await _auth.getCurrentUID();
    yield* Firestore.instance.collection('Customers').document(uid).collection('Vehicles').snapshots();
  }


  Widget getTextWidgets(List<String> strings)
  {
    return new Row(children: strings.map((item) => new Text(item)).toList());
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot document) {

    final vehicle = Vehicle.fromSnapshot(document);
    print(vehicle.vehicleId);

    return GestureDetector(
      onTap: (){
        print('Vehicle card tap');
        Navigator.push(context, MaterialPageRoute(builder: (context) => VehiclePage(serviceInfo: vehicle)));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Card(
          shadowColor: Colors.grey,
          elevation: 10.0,
          color: Color(0xFF2f69de),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Text(vehicle.brand.toUpperCase(), style: new TextStyle(fontSize: 35.0, fontFamily: 'Cabin', color: Colors.white),),
                    Spacer(),
                    IconButton(icon: Icon(Icons.format_line_spacing),color: Colors.white, tooltip: 'Modfiy Vehicle',
                      onPressed: ()  {
                        _tripEditModalBottomSheet(vehicle.vehicleId);
                        },
                    ),
                    IconButton(icon: Icon(Icons.delete_outline),color: Colors.white, tooltip: 'Delete Vehicle',
                      onPressed: () async {
                        showAlertDialog(context,vehicle.vehicleId);
                      },
                    ),
                  ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 40.0),
                  child: Row(children: <Widget>[

                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text(vehicle.regNo.toUpperCase(), style: new TextStyle(fontSize: 25.0,fontFamily: 'Cabin', color: Colors.white),),
                      Spacer(),
                      Icon(Icons.directions_car,color: Colors.white,),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget buildList(BuildContext context, DocumentSnapshot document) {
    final vehicle = Vehicle.fromSnapshot(document);
    print(vehicle.vehicleId);


//    DocumentSnapshot snapshot= await Firestore.instance.collection('Services').document().get();
//                              var channelName = snapshot['channelName'];
//                              print(channelName);

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => VehiclePage(serviceInfo: vehicle)));

      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.indigo,
            Colors.blueAccent
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(40.0),
              topRight: Radius.circular(40.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                offset: Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        width: double.infinity,
        height: 204,
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.only(right: 12.0,left: 5.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(vehicle.brand.toUpperCase(), style: GoogleFonts.dmSans(fontSize: 35.0,  color: Colors.white),),
                  Spacer(),
                  IconButton(icon: Icon(Icons.timer),color: Colors.white, tooltip: 'Modfiy Vehicle',
                    onPressed: ()  {
                      _tripEditModalBottomSheet(vehicle.vehicleId);
                    },
                  ),
                  IconButton(icon: Icon(Icons.delete_outline),color: Colors.white, tooltip: 'Delete Vehicle',
                    onPressed: () async {
                      showAlertDialog(context,vehicle.vehicleId);
                    },
                  ),
                ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 40.0),
                child: Row(children: <Widget>[

                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(vehicle.regNo.toUpperCase(), style: new TextStyle(fontSize: 25.0,fontFamily: 'Cabin', color: Colors.white),),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.7),
                              offset: Offset(2.2, 2.2),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    )                  ],
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
        final doc = Firestore.instance.collection('Customers').document(uid).collection("Vehicles").document(id);
        Navigator.pop(context);
        return await doc.delete();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure?"),
      content: Text("This will permently delete your vehicle from the system"),
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
  String _mileage;

  void _tripEditModalBottomSheet(String id) {
    final _formKey = GlobalKey<FormState>();

    showModalBottomSheet(context: context, builder: (BuildContext bc) {
      return Container(
          height: MediaQuery.of(context).size.height * .7,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("Edit Vehicle Mileage", style: GoogleFonts.quicksand(fontSize: 20,color: Colors.indigoAccent),)),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel, color: Colors.indigoAccent, size: 25,),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )

                  ],
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration: new InputDecoration(labelText: "Update Vehicle mileage"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() => _mileage = val);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: RaisedButton(
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false
                              // otherwise.
                              if (_formKey.currentState.validate()) {
                                final uid = await _auth.getCurrentUID();
                                await Firestore.instance
                                    .collection('Customers')
                                    .document(uid).collection('Vehicles').document(id)
                                    .updateData({
                                  'mileage': '$_mileage KMs',
                                });
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text('Update'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      );
    });
  }
}




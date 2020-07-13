import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicio/models/vehicle.dart';
import 'package:servicio/services/auth.dart';

class AddNewVehicle extends StatelessWidget {

  final db = Firestore.instance;
  final AuthServices _auth = AuthServices();
  final temp = Vehicle('7-serise', '111x5cxc12', 'BMW' , '2020',['hi','hiii']);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Vehicle'),
      ) ,
      body: Container(
        child: RaisedButton(
          child: Text("Finish"),
          onPressed: () async {
            final uid = await _auth.getCurrentUID();
            await db.collection("users").document(uid).collection("vehicles").add(temp.toJson());
            print('succes collection');
          },
        ),
      ),
    );
  }
}

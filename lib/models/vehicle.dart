import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String model;
  final String regNo;
  final String brand;
  final String year;
  String vehicleId;


  Vehicle(this.model, this.regNo, this.brand, this.year);
  
  Map<String, dynamic> toJson() => {
    'model': model,
    'regNo': regNo,
    'brand': brand,
    'year': year,
  };

  Vehicle.fromSnapshot(DocumentSnapshot snapshot) :
        model = snapshot['model'],
        regNo = snapshot['regNo'],
        brand = snapshot['brand'],
        year = snapshot['year'],
        vehicleId = snapshot.documentID;
}
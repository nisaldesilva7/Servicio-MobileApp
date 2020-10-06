import 'package:cloud_firestore/cloud_firestore.dart';

class Bookings {
  final String bookingStatus;
  final String serviceType;
  final String serviceName;
  final String serviceId;
  final String date;
  final String vehicleId;
  String id;


  Bookings(this.serviceId, this.bookingStatus,this.vehicleId,this.serviceType,this.date,this.serviceName);

  Map<String, dynamic> toJson() => {
    'BookingStatus': bookingStatus,
    'ServiceId': serviceId,
    'ServiceType': serviceType,


  };


  Bookings.fromSnapshot(DocumentSnapshot snapshot) :
        bookingStatus = snapshot['BookingStatus'],
        serviceId = snapshot['ServiceId'],
        vehicleId = snapshot['Vehicle'],
        serviceName = snapshot['ServiceName'],
        serviceType= snapshot['ServiceType'],
        date= snapshot['Date'],
        id = snapshot.documentID;

}
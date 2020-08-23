import 'package:cloud_firestore/cloud_firestore.dart';

class OnBooking {
  final String bookingStatus;
  final String serviceType;
  final num progressStage;
  final Timestamp dateTime;
  final String serviceId;
  final Map vehicleDetails;
//  final List favs;
  String id;


  OnBooking(this.progressStage, this.dateTime, this.serviceId, this.bookingStatus, this.id,this.vehicleDetails,this.serviceType);

  Map<String, dynamic> toJson() => {
    'BookingStatus': bookingStatus,
    'DateTime': dateTime,
    'ProgressStage': progressStage,
    'ServiceId': serviceId,
    'VehicleDetails': vehicleDetails,
    'ServiceType': serviceType,


  };


  OnBooking.fromSnapshot(DocumentSnapshot snapshot) :
        bookingStatus = snapshot['BookingStatus'],
        dateTime = snapshot['DateTime'],
        progressStage = snapshot['ProgressStage'],
        serviceId = snapshot['ServiceId'],
        vehicleDetails = snapshot['VehicleDetails'],
        serviceType= snapshot['ServiceType'],
        id = snapshot.documentID;

}
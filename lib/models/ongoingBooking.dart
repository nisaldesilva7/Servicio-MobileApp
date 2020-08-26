import 'package:cloud_firestore/cloud_firestore.dart';

class OnBooking {
  final String bookingStatus;
  final String serviceType;
  final num progressStage;
  final Timestamp dateTime;
  final String serviceId;
  final String custId;
  final String serviceName;
  final Map vehicleDetails;
  String id;


  OnBooking(this.progressStage, this.dateTime, this.serviceId,this.serviceName, this.bookingStatus, this.id,this.vehicleDetails,this.serviceType,this.custId);

  Map<String, dynamic> toJson() => {
    'BookingStatus': bookingStatus,
    'DateTime': dateTime,
    'ProgressStage': progressStage,
    'ServiceId': serviceId,
    'CustId': custId,
    'VehicleDetails': vehicleDetails,
    'ServiceType': serviceType,
    'ServiceName': serviceName,


  };


  OnBooking.fromSnapshot(DocumentSnapshot snapshot) :
        bookingStatus = snapshot['BookingStatus'],
        dateTime = snapshot['DateTime'],
        progressStage = snapshot['progressStage'],
        serviceId = snapshot['ServiceId'],
        custId = snapshot['CustId'],
        vehicleDetails = snapshot['VehicleDetails'],
        serviceName = snapshot['ServiceName'],
        serviceType= snapshot['ServiceType'],
        id = snapshot.documentID;

}
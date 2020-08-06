import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  final String photo;
  final num rating;
  final String searchKey;
  final String serviceName;
  final List serviceTypes;
  String serviceId;


  Service(this.photo, this.rating, this.searchKey, this.serviceName, this.serviceTypes);
  
  Map<String, dynamic> toJson() => {
    'Photo': photo,
    'Rating': rating,
    'SearchKey': searchKey,
    'Service_Name': serviceName,
    'Service_Types': serviceTypes,

  };

  Service.fromSnapshot(DocumentSnapshot snapshot) :
        photo = snapshot['Photo'],
        rating = snapshot['Rating'],
        searchKey = snapshot['SearchKey'],
        serviceName = snapshot['Service_Name'],
        serviceTypes = List.of(snapshot['Service_Types']).cast<String>(),
        serviceId = snapshot.documentID;
}
import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  final String photo;
  final num rating;
  final String searchKey;
  final num telephone;
  final String city;
  final String type;
  final String description;
  final String address1;
  final String address2;
  final GeoPoint location;
  final String serviceName;
  final List serviceTypes;
  final List favs;
  String serviceId;


  Service(this.photo,this.type, this.location, this.rating, this.city, this.searchKey, this.serviceName, this.serviceTypes,this.favs,this.telephone,this.description,this.address1,this.address2);
  
  Map<String, dynamic> toJson() => {
    'Photo': photo,
    'Rating': rating,
    'SearchKey': searchKey,
    'Service_Name': serviceName,
    'Service_Types': serviceTypes,
    'Description': description,


  };

  Service.fromSnapshot(DocumentSnapshot snapshot) :
        photo = snapshot['Image'],
        rating = snapshot['Rating'],
        searchKey = snapshot['SearchKey'],
        city = snapshot['City'],
        serviceName = snapshot['Service_Name'],
        address1 = snapshot['Address'],
        type = snapshot['user_type'],
        address2 = snapshot['AddressTwo'],
        telephone = snapshot['Telephone'],
        location = snapshot['Location'],
        description = snapshot['Description'],
        serviceTypes = List.of(snapshot['Service_Types']).cast<String>(),
        favs = snapshot['Favs'],
        serviceId = snapshot.documentID;


  Service.fromElement(Map snapshot) :
        photo = snapshot['Image'],
        rating = snapshot['Rating'],
        searchKey = snapshot['SearchKey'],
        serviceName = snapshot['Service_Name'],
        location = snapshot['Location'],
        type = snapshot['user_type'],
      address1 = snapshot['Address'],
        city = snapshot['City'],
        address2 = snapshot['AddressTwo'],
        telephone = snapshot['Telephone'],
        description = snapshot['Description'],
        serviceTypes = List.of(snapshot['Service_Types']).cast<String>(),
        favs = snapshot['Favs'],
        serviceId = snapshot['Service_Id'];



}
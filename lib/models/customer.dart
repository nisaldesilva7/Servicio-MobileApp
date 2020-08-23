import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String email;
  String number;
  String name;
  String photo;
  String userId;

  Customer(this.name,this.email,this.number,this.photo);

  Map<String, dynamic> toJson() => {
    'number': number,
    'email': email,
    'name': name,
    'Photo': photo,
  };


  Customer.fromSnapshot(DocumentSnapshot snapshot) :
        email = snapshot['email'],
        number = snapshot['tel_num'],
        name = snapshot['name'],
        photo = snapshot['Photo'],
        userId = snapshot.documentID;


}
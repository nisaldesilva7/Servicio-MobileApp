import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String email;
  String number;
  String name;

  Customer(this.name,this.email,this.number);

  Map<String, dynamic> toJson() => {
    'number': number,
    'email': email,
    'name': name,
  };


  Customer.fromSnapshot(DocumentSnapshot snapshot) :
        email = snapshot['email'],
        number = snapshot['tel_num'],
        name = snapshot['name'];

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicio/services/auth.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Notifications extends StatefulWidget{


  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var rating = 0.0;
  final db = Firestore.instance;
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Latest Notifications"),
      ),
      body: new  Center(

      ),
    );
  }

  Stream<QuerySnapshot> getUsersServicesStreamSnapshots() async* {
    print('under stream');
    final uid = await _auth.getCurrentUID();
    yield* Firestore.instance.collection("Customers").document(uid)
        .collection('Bookings')
        .where('BookingStatus',isEqualTo: 'Pending')
        .snapshots();
  }
}
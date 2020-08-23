import 'package:cloud_firestore/cloud_firestore.dart';

class Events {
  final String dateTime;
  String eventId;

  Events(this.dateTime);

  Map<String, dynamic> toJson() => {
    'DateTime': dateTime,
  };

  Events.fromSnapshot(DocumentSnapshot snapshot) :
        dateTime = snapshot['start'].toDate(),
        eventId = snapshot.documentID;
}
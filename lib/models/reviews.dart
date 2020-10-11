import 'package:cloud_firestore/cloud_firestore.dart';

class Reviews {
  final Timestamp dateTime;
  String comment;
  num rate;
  String reviewId;
  String custID;

  Reviews(this.dateTime,this.custID,this.comment,this.rate);

  Map<String, dynamic> toJson() => {
    'timestamp': dateTime,
    'Comment': comment,
    'Rating': rate,
  };

  Reviews.fromSnapshot(DocumentSnapshot snapshot) :
        comment = snapshot['Comment'],
        rate = snapshot['Rating'],
        custID = snapshot['CustId'],
        dateTime = snapshot['timestamp'],
        reviewId = snapshot.documentID;
}
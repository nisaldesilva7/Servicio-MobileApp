import 'package:cloud_firestore/cloud_firestore.dart';

class Reviews {
  final Timestamp dateTime;
  String comment;
  num rate;
  String reviewId;

  Reviews(this.dateTime,this.comment,this.rate);

  Map<String, dynamic> toJson() => {
    'timestamp': dateTime,
    'Comment': comment,
    'Rating': rate,
  };

  Reviews.fromSnapshot(DocumentSnapshot snapshot) :
        comment = snapshot['Comment'],
        rate = snapshot['Rating'],
        dateTime = snapshot['timestamp'],
        reviewId = snapshot.documentID;
}
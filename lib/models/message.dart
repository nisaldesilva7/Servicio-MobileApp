import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  final Timestamp dateTime;
  String msg;
  num user;
  String msgId;
  String type;

  Messages(this.dateTime,this.msg,this.user);

  Map<String, dynamic> toJson() => {
    'time': dateTime,
    'text': msg,
    'id': user,
    'type': type,
  };

  Messages.fromSnapshot(DocumentSnapshot snapshot) :
        msg = snapshot['text'],
        user = snapshot['id'],
        dateTime = snapshot['time'],
        type = snapshot['type'],
        msgId = snapshot.documentID;
}
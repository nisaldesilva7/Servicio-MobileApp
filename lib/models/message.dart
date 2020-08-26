import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  final Timestamp dateTime;
  String msg;
  num user;
  String msgId;

  Messages(this.dateTime,this.msg,this.user);

  Map<String, dynamic> toJson() => {
    'timestamp': dateTime,
    'msg': msg,
    'user': user,
  };

  Messages.fromSnapshot(DocumentSnapshot snapshot) :
        msg = snapshot['msg'],
        user = snapshot['user'],
        dateTime = snapshot['timestamp'],
        msgId = snapshot.documentID;
}
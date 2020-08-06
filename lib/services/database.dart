import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //Collection reference
  final CollectionReference userCollection = Firestore.instance.collection('Customers');

  Future updateUserData(String name, String email, String telNum) async {
    print('update user data');
    return await userCollection.document(uid).setData({
      'name': name,
      'email': email,
      'tel_num': telNum,
      'user_id': uid,
    });
  }

  //get users stream.



}
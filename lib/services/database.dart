import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //Collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String name, String sugar, int age) async {
    print('update user data');
    return await userCollection.document(uid).setData({
      'name': name,
      'gender': sugar,
      'age': age,
      'user_id': uid,
    });
  }

  //get users stream.

}
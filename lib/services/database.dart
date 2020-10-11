import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //Collection reference
  final CollectionReference userCollection = Firestore.instance.collection('Customers');

  Future updateUserData(String name, String email, String telNum) async {
    print('update user data');
    String photo;
    return await userCollection.document(uid).setData({
      'name': name,
      'email': email,
      'tel_num': telNum,
      'user_id': uid,
      'Photo': 'https://firebasestorage.googleapis.com/v0/b/servicio-11f11.appspot.com/o/images%2Fno_dp.png?alt=media&token=f83a02f3-e9f3-4cc9-83b7-d62c596938bb',
    });
  }

  //get users stream.



}
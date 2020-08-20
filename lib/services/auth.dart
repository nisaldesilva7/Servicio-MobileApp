import 'package:firebase_auth/firebase_auth.dart';
import 'package:servicio/models/user.dart';
import 'package:servicio/services/database.dart';

class AuthServices {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String error = '';

  //create user object
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  Future<String> getCurrentUID() async {
    var result = (await _auth.currentUser()).uid;
    print(result);
    return result;
  }


  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  //Sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
      
    } catch (e) {
      error = e.message;
      print(error);
      return null;
    }
  }



  //Sign in Email and pass
  Future signInWithEmail(String email,String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if(result.user.isEmailVerified){
        print('Email verified');
        FirebaseUser user = result.user;
        await user.reload();
        return _userFromFirebaseUser(user);
      }else{
        print('email not verfied');
        return null;
      }
    }catch(e){
      error = e.message;
      print(error);
      return null;
    }
  }


  //Reg with email and pass
  Future registerWithEmail(String email,String password, String name, String phone) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      sendVerificationMail();
      FirebaseUser user = result.user;
      //create a new doc for newly registered user
      await DatabaseService(uid: user.uid).updateUserData(name, email, phone);
      print('auth ok');
      return _userFromFirebaseUser(user);

    }catch(e){
      error = e.message;
      print(error);
      return null;
    }
  }


  //forgot password
  Future forgotPassword(String email) async {
    try {
     await _auth.sendPasswordResetEmail(email: email);
    } catch(e) {
      error = e.message;
      print(error);
    }
  }

  //send verification mail
  Future sendVerificationMail() async {
    var user = await _auth.currentUser();
    user.sendEmailVerification();
  }

  //check Verification
  Future checkVerification() async {
    var user = await _auth.currentUser();
    if(user.isEmailVerified) {
      return null;
    }
  }


  //reset password
  Future resetPasswordUser() async {
      //TODO
  }



  //sign out
  Future signOut() async {
      try {
        return await _auth.signOut();
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
  }
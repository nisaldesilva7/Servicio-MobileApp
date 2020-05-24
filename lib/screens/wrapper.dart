import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicio/screens/authenticate/authenticate.dart';
import 'package:servicio/screens/home/home.dart';
import 'package:servicio/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    //return either home or auth widget
    if (user == null) {
      return Authenticate();
    }else{
      return Home();
    }
  }
}

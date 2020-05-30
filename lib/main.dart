import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicio/models/user.dart';
import 'package:servicio/screens/wrapper.dart';
import 'package:servicio/services/auth.dart';
import 'package:servicio/testing/logUI.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthServices().user,
        child: MaterialApp(
      home: Wrapper(),
//      home: HomePage(),

      ),
    );
  }
}



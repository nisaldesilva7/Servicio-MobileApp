import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicio/models/user.dart';
import 'package:servicio/screens/splash_loading/splash_loading.dart';
import 'package:servicio/screens/wrapper.dart';
import 'package:servicio/services/auth.dart';
import 'package:servicio/router.dart' as router;
import 'package:servicio/services/service_locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return StreamProvider<User>.value(
      value: AuthServices().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.genarteRoute,
      home: Wrapper(),
//      home: HomePage(),
//      home: FormScreen(),
//      home: Scrolling(),
//      home: ForgotPassword(),

          theme: ThemeData(primarySwatch: Colors.indigo,),

      ),

    );
  }
}



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicio/models/user.dart';
import 'package:servicio/screens/splash_loading/splash_loading.dart';
import 'package:servicio/services/auth.dart';
import 'package:servicio/router.dart' as router;
import 'package:servicio/testing/logUI.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return StreamProvider<User>.value(
      value: AuthServices().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.genarteRoute,
//      home: Wrapper(),
//      home: VehiclePage(),
//      home: FormScreen(),
//      home: Scrolling(),
//      home: ForgotPassword(),
        home: SplashScreen(),
    
          theme: ThemeData(primarySwatch: Colors.indigo,),

      ),

    );
  }
}



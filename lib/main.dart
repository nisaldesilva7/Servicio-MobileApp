import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicio/models/user.dart';
import 'package:servicio/screens/authenticate/forgot_password.dart';
import 'package:servicio/screens/help.dart';
import 'package:servicio/screens/history.dart';
import 'package:servicio/screens/mybookings.dart';
import 'package:servicio/screens/myprofile.dart';
import 'package:servicio/screens/notifications.dart';
import 'package:servicio/screens/offers.dart';
import 'package:servicio/screens/search.dart';
import 'package:servicio/screens/service_page/servicePage.dart';
import 'package:servicio/screens/splash_loading/splash_loading.dart';
import 'package:servicio/screens/wrapper.dart';
import 'package:servicio/services/auth.dart';
import 'package:servicio/testing/dep/scrollCheck.dart';
import 'package:servicio/testing/formSample.dart';
import 'package:servicio/testing/logUI.dart';
import 'package:servicio/testing/selectimage.dart';


var routes = <String, WidgetBuilder>{
  "/wrapper": (BuildContext context) => Wrapper(),
  "/forgotPassword": (BuildContext context) => ForgotPassword(),
  "/profile": (BuildContext context)=>  MyProfile("My Profile"),
  "/bookings": (BuildContext context)=>  MyBookings("My Bookings"),
  "/service": (BuildContext context)=> ServicePage(),
  "/image": (BuildContext context)=> SelectImages(),
  "/notifications": (BuildContext context)=>  Notifications("Notifications"),
  "/offers": (BuildContext context)=>  Offers("Offers"),
  "/search": (BuildContext context)=>  Search("Search"),
  "/feedback": (BuildContext context)=>  HelpAndFeedback("Help and Feedback"),
};




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return StreamProvider<User>.value(
      theme: new ThemeData(primarySwatch: Colors.indigo),
      value: AuthServices().user,
      child: MaterialApp(
//      home: Wrapper(),
//      home: HomePage(),
//      home: FormScreen(),
//      home: Scrolling(),
//      home: ForgotPassword(),
        home: SplashScreen(),
    
//    routes: routes,

          routes: <String, WidgetBuilder>{
            "profile": (BuildContext context)=> new MyProfile("My Profile "),
            "bookings": (BuildContext context)=> new MyBookings("My Bookings"),
            "history": (BuildContext context)=> new History("Recent Activities"),
            "notifications": (BuildContext context)=> new Notifications("Notifications"),
            "offers": (BuildContext context)=> new Offers("Offers"),
            "search": (BuildContext context)=> new Search("Search"),
            "feedback": (BuildContext context)=> new HelpAndFeedback("Help and Feedback"),
          }
      ),

    );
  }
}



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicio/models/user.dart';
import 'package:servicio/screens/help.dart';
import 'package:servicio/screens/history.dart';
import 'package:servicio/screens/mybookings.dart';
import 'package:servicio/screens/myprofile.dart';
import 'package:servicio/screens/notifications.dart';
import 'package:servicio/screens/offers.dart';
import 'package:servicio/screens/search.dart';
import 'package:servicio/screens/wrapper.dart';
import 'package:servicio/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return StreamProvider<User>.value(
      value: AuthServices().user,
      child: MaterialApp(
          theme: new ThemeData(primarySwatch: Colors.indigo),
          home: Wrapper(),
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



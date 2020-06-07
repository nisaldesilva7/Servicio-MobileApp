import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:servicio/constant/constant.dart';
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
import 'package:servicio/screens/side_nav/my_vehicles.dart';
import 'package:servicio/screens/splash_loading/splash_loading.dart';
import 'package:servicio/screens/wrapper.dart';
import 'package:servicio/services/auth.dart';
import 'package:servicio/testing/selectimage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
        return StreamProvider<User>.value(
          value: AuthServices().user,
          child: MaterialApp(
            title: 'Fluter Profile Page',
            debugShowCheckedModeBanner: false,
            theme: new ThemeData(
              primaryColor: Color(0xff0082CD),
    
              primaryColorDark: Color(0xff0082CD)),
    //      home: Wrapper(),
    //      home: HomePage(),
    //      home: FormScreen(),
    //      home: Scrolling(),
    //      home: ForgotPassword(),
            home: SplashScreen(),
            
    
          //theme: ThemeData(primarySwatch: Colors.indigo),

          routes: <String, WidgetBuilder>{
            //SPLASH_SCREEN: (BuildContext context) => new MapScreen(),
        
            "/image": (BuildContext context)=> SelectImages(),
            "/wrapper": (BuildContext context) => Wrapper(),
            "/forgotPassword": (BuildContext context) => ForgotPassword(),
            "/service": (BuildContext context)=> ServicePage(),
            "/profile":(BuildContext context)=> MyProfile("My Profile"),
            "/bookings": (BuildContext context)=> new MyBookings("My Bookings"),
            "/history": (BuildContext context)=> new History("Recent Activities"),
            "/notifications": (BuildContext context)=> new Notifications("Notifications"),
            "/offers": (BuildContext context)=> new Offers("Offers"),
            "/search": (BuildContext context)=> new Search("Search"),
            "/feedback": (BuildContext context)=> new HelpAndFeedback("Help and Feedback"),
            "/vehicle": (BuildContext context)=> MyVehicles(),

          }
      ),

    );
  }
}



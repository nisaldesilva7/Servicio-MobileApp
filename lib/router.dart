import 'package:flutter/material.dart';
import 'package:servicio/screens/authenticate/forgot_password.dart';
import 'package:servicio/screens/bookings/book_service.dart';
import 'package:servicio/screens/help.dart';
import 'package:servicio/screens/history.dart';
import 'package:servicio/screens/mybookings.dart';
import 'package:servicio/screens/myprofile.dart';
import 'package:servicio/screens/notifications.dart';
import 'package:servicio/screens/offers.dart';
import 'package:servicio/screens/service_page/servicePage.dart';
import 'package:servicio/screens/service_page/service_detail_view.dart';
import 'package:servicio/screens/side_nav/my_vehicles/addNew_vehicle.dart';
import 'package:servicio/screens/side_nav/my_vehicles/my_vehicles.dart';
import 'package:servicio/screens/wrapper.dart';
import 'package:servicio/testing/selectimage.dart';

Route<dynamic> genarteRoute(RouteSettings settings){
  switch(settings.name){
    case '/image':
      return MaterialPageRoute(builder: (context) => SelectImages());
    case '/wrapper':
      return MaterialPageRoute(builder: (context) => Wrapper());
    case '/forgotPassword':
      return MaterialPageRoute(builder: (context) => ForgotPassword());
    case '/service':
      return MaterialPageRoute(builder: (context) => ServicePage());
    case '/profile':
      return MaterialPageRoute(builder: (context) => MyProfile("My Profile "));
    case '/bookings':
      return MaterialPageRoute(builder: (context) => MyBookings("My Bookings"));
    case '/history':
      return MaterialPageRoute(builder: (context) => History("Recent Activities"));
    case '/notifications':
      return MaterialPageRoute(builder: (context) => Notifications("Notifications"));
    case '/offers':
      return MaterialPageRoute(builder: (context) => Offers("Offers"));
//  case /search:
//        return MaterialPageRoute(builder: (context) => Search("Search"));
    case '/feedback':
      return MaterialPageRoute(builder: (context) => HelpAndFeedback("Help and Feedback"));
    case '/vehicle':
      return MaterialPageRoute(builder: (context) => MyVehicles());
    case '/addnewvehicle':
      return MaterialPageRoute(builder: (context) => AddNewVehicle());
    case '/bookservice':
      return MaterialPageRoute(builder: (context) => BookService());
    case '/servicedetailpage':
      return MaterialPageRoute(builder: (context) => ServiceDetailPage());

  }
}
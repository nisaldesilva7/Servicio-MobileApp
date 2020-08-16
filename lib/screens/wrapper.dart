import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicio/screens/authenticate/authenticate.dart';
import 'package:servicio/screens/home/home.dart';
import 'package:servicio/models/user.dart';
import 'package:servicio/screens/splash_loading/splash_loading.dart';

class Wrapper extends StatefulWidget {

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {


    final user = Provider.of<User>(context);
    print(user);

    //return either home or auth widget
    if (isLoading == true) {
      return SplashScreen();
    }
    else {
      if (user == null) {
        return Authenticate();
      }
      else {
        return Home();
      }
    }
  }
}

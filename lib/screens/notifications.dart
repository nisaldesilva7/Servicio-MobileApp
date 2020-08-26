import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Notifications extends StatefulWidget{


  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var rating = 0.0;


  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Offers"),
      ),
      body: new  Center(
          child: SmoothStarRating(
            rating: rating,
            isReadOnly: false,
            size: 40,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            defaultIconData: Icons.star_border,
            starCount: 5,
            borderColor: Color(0xffe3830e),
            color: Color(0xffe3830e),
            allowHalfRating: true,
            spacing: 2.0,
            onRated: (value) {
              print("rating value -> $value");
              // print("rating value dd -> ${value.truncate()}");
            },
          )
      ),
    );
  }
}
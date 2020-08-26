import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Offers extends StatefulWidget{


  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  var rating = 3.0;


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
            size: 80,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            defaultIconData: Icons.star_border,
            starCount: 5,
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
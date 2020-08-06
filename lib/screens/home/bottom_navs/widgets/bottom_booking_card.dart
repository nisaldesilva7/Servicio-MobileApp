import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BottomBookingCard extends StatelessWidget {
  final Color cardColor;
  final loadingPercent;
  final String title;
  final String subtitle;

  BottomBookingCard({
    this.cardColor,
    this.loadingPercent,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(15.0),
        height: 200,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(22.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w700,),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12.0, color: Colors.white54, fontWeight: FontWeight.w400,),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

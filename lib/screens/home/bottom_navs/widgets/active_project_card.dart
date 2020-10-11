import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ActiveProjectsCard extends StatelessWidget {
  final Color cardColor;
  final double loadingPercent;
  final String title;
  final String subtitle;
  final String model;
  final String serviceType;


  ActiveProjectsCard({
    this.cardColor,
    this.loadingPercent,
    this.title,
    this.subtitle,
    this.model,
    this.serviceType
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7.0),
        padding: EdgeInsets.all(15.0),
        height: 200,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(22.0),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Opacity(
                opacity: 0.1,
                child: Icon(
                  Icons.directions_car,
                  size: 100,
                  color: Colors.white,
                )),
            ),
            Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircularPercentIndicator(
                        animation: true,
                        radius: 75.0,
                        percent: loadingPercent,
                        lineWidth: 5.0,
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: Colors.white10,
                        progressColor: Colors.white,
                        center: Text(
                          '${(loadingPercent*100).round()}%',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        subtitle,
                        style: GoogleFonts.ubuntu(
                          fontSize: 25,
                          color: Colors.white
                        )
                      ),
                      Text(
                          model,
                          style: GoogleFonts.ubuntu(
                              fontSize: 15,
                              color: Colors.white
                          )
                      ),
                      Spacer(),
                      Text(
                          serviceType,
                          style: GoogleFonts.bebasNeue(
                              fontSize: 35,
                              color: Colors.white
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

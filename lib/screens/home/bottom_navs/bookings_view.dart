import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:servicio/screens/bookings/UpcomingBookings.dart';
import 'package:servicio/screens/home/bottom_navs/theme/light_colors.dart';
import 'package:servicio/screens/home/bottom_navs/widgets/active_project_card.dart';
import 'package:servicio/screens/home/bottom_navs/widgets/bottom_booking_card.dart';
import 'package:servicio/screens/home/bottom_navs/widgets/task_column.dart';
import 'package:servicio/screens/home/bottom_navs/widgets/top_container.dart';

class HomePage extends StatelessWidget {


  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          fontFamily: 'Lobster',
          color: Colors.indigo,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }
   String temp = '3';

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  showProgress () {
    return ActiveProjectsCard(
      cardColor: LightColors.kGreen,
      loadingPercent: 0.25,
      title: 'Medical App',
      subtitle: '9 hours progress',
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TopContainer(
                height: 110,
                width: width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircularPercentIndicator(
                              radius: 80.0,
                              lineWidth: 5.0,
                              animation: true,
                              percent: 0.5,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Colors.blueGrey,
                              backgroundColor: Colors.grey[100],
                              center: CircleAvatar(
                                backgroundColor: LightColors.kBlue,
                                radius: 22.0,
                                backgroundImage: AssetImage(
                                  'assets/booing.png',
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text('My Bookings', textAlign: TextAlign.start, style: TextStyle(fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.w800,),),
                                ),
                                Container(
                                  child: Text('Dashboard', textAlign: TextAlign.start, style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w400,),),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ]
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
//                    Container(
//                      color: Colors.transparent,
//                      padding: EdgeInsets.symmetric(
//                          horizontal: 20.0, vertical: 10.0),
//                      child: Column(
//                        children: <Widget>[
//                          Row(
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              subheading('My Tasks'),
////                              GestureDetector(
////                                onTap: () {
////                                  Navigator.push(
////                                    context,
////                                    MaterialPageRoute(
////                                        builder: (context) => CalendarPage()),
////                                  );
////                                },
////                                child: calendarIcon(),
////                              ),
//                            ],
//                          ),
//                          SizedBox(height: 15.0),
//                          TaskColumn(
//                            icon: Icons.alarm,
//                            iconBackgroundColor: LightColors.kRed,
//                            title: 'To Do',
//                            subtitle: '5 tasks now. 1 started',
//                          ),
//                          SizedBox(height: 15.0,),
//                          TaskColumn(
//                            icon: Icons.blur_circular,
//                            iconBackgroundColor: LightColors.kDarkYellow,
//                            title: 'In Progress',
//                            subtitle: '1 tasks now. 1 started',
//                          ),
//                          SizedBox(height: 15.0),
//                          TaskColumn(
//                            icon: Icons.check_circle_outline,
//                            iconBackgroundColor: LightColors.kBlue,
//                            title: 'Done',
//                            subtitle: '18 tasks now. 13 started',
//                          ),
//                        ],
//                      ),
//                    ),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
//                          Center(child: subheading('Active Booking')),
//                          SizedBox(height: 5.0),
                          GestureDetector(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UpcomingBookings()));
                            },
                            child: Row(
                              children: <Widget>[
                                if(temp == '1')
                                  ActiveProjectsCard(
                                    cardColor: LightColors.indigoLight,
                                    loadingPercent: 0.00,
                                    title: 'Vehicle Reached',
                                    subtitle: 'In the queue',
                                  ),
                                if(temp == '2')
                                  ActiveProjectsCard(
                                    cardColor: LightColors.indigoLight,
                                    loadingPercent: 0.25,
                                    title: 'SERVICE TYPE',
                                    subtitle: '5 hours progress',
                                  ),
                                if(temp == '3')
                                  ActiveProjectsCard(
                                    cardColor: LightColors.indigoLight,
                                    loadingPercent: 0.50,
                                    title: 'SERVICE TYPE',
                                    subtitle: '5 hours progress',
                                  ),
                                if(temp == '4')
                                  ActiveProjectsCard(
                                    cardColor: LightColors.indigoLight,
                                    loadingPercent: 1.00,
                                    title: 'SERVICE TYPE',
                                    subtitle: '5 hours progress',
                                  ),

                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              BottomBookingCard(
                                cardColor: LightColors.kGreen,
                                loadingPercent: 0.25,
                                title: 'UPCOMING BOOKINGS',
                                subtitle: '9 hours progress',
                              ),
                              SizedBox(width: 20.0),
                              BottomBookingCard(
                                cardColor: Colors.lightBlue,
                                loadingPercent: 0.6,
                                title: 'PREVIOUS BOOKINGS',
                                subtitle: '20 hours progress',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

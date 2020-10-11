import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:servicio/models/ongoingBooking.dart';
import 'package:servicio/screens/home/bottom_navs/bookings_views/booking_progress.dart';
import 'package:servicio/screens/home/bottom_navs/bookings_views/pending_bookings.dart';
import 'package:servicio/services/auth.dart';
import 'bookings_views/upcoming_bookings.dart';
import 'package:servicio/screens/home/bottom_navs/bookings_views/prev_bookings.dart';
import 'package:servicio/screens/home/bottom_navs/theme/light_colors.dart';
import 'package:servicio/screens/home/bottom_navs/widgets/active_project_card.dart';
import 'package:servicio/screens/home/bottom_navs/widgets/top_container.dart';

class BookingsPage extends StatefulWidget {



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

  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {

  final AuthServices _auth = AuthServices();

  Text subheading(String title) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.montserrat(
//        fontWeight: FontWeight.w800 ,
          color: Colors.white,
          fontSize: 20
      )
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
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Container(
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
                                progressColor: Colors.grey,
                                backgroundColor: Colors.grey[100],
                                center: Icon(CupertinoIcons.home,color: Colors.white, size: 45,),
//                              center: CircleAvatar(
//                                backgroundColor: LightColors.kBlue,
//                                radius: 30.0,
//                                backgroundImage: AssetImage(
//                                  'assets/calendar.png',
//                                ),
//                              ),
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
              Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text('Active Bookings', style: GoogleFonts.quicksand(fontSize: 17,color: Colors.indigoAccent),),
                    ),
                    SizedBox(height: 5.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: StreamBuilder(
                          stream: getUsersTripsStreamSnapshots(context),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Center(child: const CircularProgressIndicator(strokeWidth: 1,));
                            if (snapshot.data == null) return Center(child: Text("No Active Bookings currently"));
                            return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (BuildContext context, int index) =>
                                      progressCard(context, snapshot.data.documents[index])
                              );
                          }
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0,bottom: 8),
                      child: Text('Details of Bookings', style: GoogleFonts.quicksand(fontSize: 17,color: Colors.indigoAccent),),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UpcomingBookings()));
                            },
                            child: _buildWikiCategory(FontAwesomeIcons.list,
                                "UPCOMING BOOKINGS", Colors.blue.withOpacity(0.7)),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PrevBookings()));
                            },
                            child: _buildWikiCategory(
                                FontAwesomeIcons.backward, "PREVIOUS BOOKINGS", Colors.greenAccent),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PendingBookings()));
                            },
                            child: _buildWikiCategory(
                                FontAwesomeIcons.fileDownload, "PENDING BOOKINGS", Color(0xff8484ad)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              WorkoutView(),
            ],
          ),
        ),
      ),
    );

  }

  Widget progressCard(BuildContext context, DocumentSnapshot document) {
    final onBookings = OnBooking.fromSnapshot(document);
    print(onBookings.id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,MaterialPageRoute(builder: (context) => BookingProgress(
          bookingProgress: onBookings.progressStage, bookingId: onBookings.id, serviceID: onBookings.serviceId, custId: onBookings.custId
        )));
      },
      child: Row(
        children: <Widget>[
          if(onBookings.progressStage == 0)
            Container(
                child: Center(
                    child: Text("                     Your Booking Has initialized\n               please be on time at ${onBookings.serviceName}".toUpperCase(),
                      style: GoogleFonts.montserrat(fontSize: 14,color: Colors.red),
                    )
                ),
            ),
          SizedBox(height: 30,),
          if(onBookings.progressStage == 1)
            ActiveProjectsCard(
              cardColor: Color(0xFF84ace8),
              loadingPercent: 0.10,
              title: 'Vehicle Reached',
              subtitle: onBookings.vehicleDetails['brand'],
              model: onBookings.vehicleDetails['model'],
              serviceType: onBookings.serviceType,

            ),
          if(onBookings.progressStage == 2)
            ActiveProjectsCard(
              cardColor: Color(0xFF4371b5),
              loadingPercent: 0.25,
              title: 'process started ',
              subtitle: onBookings.vehicleDetails['brand'],
              model: onBookings.vehicleDetails['model'],
              serviceType: onBookings.serviceType,

            ),
          if(onBookings.progressStage == 3)
            ActiveProjectsCard(
              cardColor: Color(0xFF235194),
              loadingPercent: 0.70,
              title: 'process finished',
              subtitle: onBookings.vehicleDetails['brand'],
              model: onBookings.vehicleDetails['model'],
              serviceType: onBookings.serviceType,

            ),
          if(onBookings.progressStage == 4)
            ActiveProjectsCard(
              cardColor: Color(0xFF103a78),
              loadingPercent: 0.9,
              title: 'ready to pickup',
              subtitle: onBookings.vehicleDetails['brand'],
              model: onBookings.vehicleDetails['model'],
              serviceType: onBookings.serviceType,
            ),
          if(onBookings.progressStage == 5)
            ActiveProjectsCard(
              cardColor: Color(0xFF52368a),
              loadingPercent: 1.00,
              title: 'completed',
              subtitle: onBookings.vehicleDetails['brand'],
              model: onBookings.vehicleDetails['model'],
              serviceType: onBookings.serviceType,

            ),
          if(onBookings.progressStage == 6)
            Column(
              children: <Widget>[
                SizedBox(height: 20,),
                Text("            Thank you! for rating and review\n                                 ${onBookings.serviceName}".toUpperCase(),
                  style: GoogleFonts.montserrat(fontSize: 14,color: Colors.red),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Stack _buildWikiCategory(IconData icon, String label, Color color) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(26.0),
          alignment: Alignment.centerRight,
          child: Opacity(
              opacity: 0.3,
              child: Icon(
                icon,
                size: 40,
                color: Colors.white,
              )),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(height: 16.0),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        )
      ],
    );
  }


  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(BuildContext context) async* {
    final uid = await _auth.getCurrentUID();
    yield* Firestore.instance.collection('Customers').document(uid).collection('ongoing').snapshots();
  }
}


class WorkoutView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => PrevBookings()));
        },
        child: Padding(
          padding: const EdgeInsets.only(
              left: 15, right: 15, bottom: 18),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.orangeAccent,
                Colors.blue
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(68.0),
                  bottomRight: Radius.circular(8.0),
                  topRight: Radius.circular(68.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    offset: Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Previous Bookings',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      letterSpacing: 0.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Manage your all vehicles at one place\nTrack your Vehicle History',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        letterSpacing: 0.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(left: 4),
//                         child: Icon(
//                           Icons.timer,
//                           color: FitnessAppTheme.white,
//                           size: 16,
//                         ),
//                       ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 4.0),
//                          child: Text(
//                            'Click to view',
//                            textAlign: TextAlign.center,
//                            style: GoogleFonts.quicksand(
//
//                              fontWeight: FontWeight.w500,
//                              fontSize: 14,
//                              letterSpacing: 0.0,
//                              color: Colors.white,
//                            ),
//                          ),
//                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black54
                                      .withOpacity(0.4),
                                  offset: Offset(8.0, 8.0),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.chevron_right,
                              color: Colors.red,
                              size: 38,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicio/models/booking.dart';
import 'package:servicio/models/service.dart';
import 'package:servicio/models/vehicle.dart';
import 'package:servicio/services/auth.dart';

class PendingBookings extends StatefulWidget{

  @override
  _PendingBookingsState createState() => _PendingBookingsState();
}

class _PendingBookingsState extends State<PendingBookings> {

  final AuthServices _auth = AuthServices();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          height: 90,
          padding: const EdgeInsets.only(top: 20.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )),
          child: ListTile(
            leading: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Pending Bookings".toUpperCase(),
              style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(90.0),
      ),
//      backgroundColor: Color(0xfff5f2f2),
      body: Container(
//          padding: EdgeInsets.only(top: 10),
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/image/chat-background-1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: getUsersServicesStreamSnapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> querySnapshot) {
                  if (!querySnapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  if (querySnapshot.connectionState == ConnectionState.waiting)
                    return Center(child: const CircularProgressIndicator());
                  else {
                    final list = querySnapshot.data.documents;
                    print(list);
                    return ListView.builder(
                      itemCount: list.length,
//                            scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index) {
                        return buildList(context,list[index]);
                      },
                    );
                  }
                }
            ),
          )
      ),
    );
  }

  Widget buildList(BuildContext context, DocumentSnapshot document) {
    final bookingDoc = Bookings.fromSnapshot(document);
    print(bookingDoc);
    List date = bookingDoc.date.toString().split('T');



    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.indigo,
          Colors.blue
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(50.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              offset: Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      width: double.infinity,
      height: 175,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 20),
      child: GestureDetector(
        onTap: () {
//          Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetailPage(service: serviceDoc)));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    bookingDoc.serviceType.toUpperCase(),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                  SizedBox(height: 6,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.home, color: Colors.white, size: 20,),
                      SizedBox(width: 5,),
                      Text(
                          bookingDoc.serviceName,
                          style: GoogleFonts.quicksand(color: Colors.white, fontSize: 13, letterSpacing: .4)),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.date_range, color: Colors.white, size: 20,),
                      SizedBox(width: 5,),
                      Text(
                          date[0],
                          style: TextStyle(color: Colors.white, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  SizedBox(height: 6,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.access_time, color: Colors.white, size: 20,),
                      SizedBox(width: 5,),
                      Text(
                          date[1],
                          style: TextStyle(color: Colors.white, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  SizedBox(height: 6,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.airport_shuttle, color: Colors.white, size: 20,),
                      SizedBox(width: 5,),
                      Text(
                          bookingDoc.vehicleId,
                          style: TextStyle(color: Colors.white, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Icon(Icons.chevron_right, size: 40, color: Colors.white,),
            )
          ],
        ),
      ),
    );

  }


  Stream<QuerySnapshot> getUsersServicesStreamSnapshots() async* {
    print('under stream');
    final uid = await _auth.getCurrentUID();
    yield* Firestore.instance.collection("Customers").document(uid)
        .collection('Bookings')
        .where('BookingStatus',isEqualTo: 'Pending')
        .snapshots();
  }
}
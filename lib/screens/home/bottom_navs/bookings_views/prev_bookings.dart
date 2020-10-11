import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicio/models/booking.dart';
import 'package:servicio/models/service.dart';
import 'package:servicio/screens/service_page/service_detail_view.dart';
import 'package:servicio/services/auth.dart';


class PrevBookings extends StatefulWidget{

  @override
  _PrevBookingsState createState() => _PrevBookingsState();
}

        class _PrevBookingsState extends State<PrevBookings> {

        final AuthServices _auth = AuthServices();

        @override
        Widget build(BuildContext context){
        return new Scaffold(
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
              "Previous Bookings".toUpperCase(),
              style: GoogleFonts.quicksand(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(90.0),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
//          decoration: BoxDecoration(
////              borderRadius: BorderRadius.circular(12.0),
//            image: DecorationImage(
//              image: AssetImage(
//                  'assets/image/chat-background-1.jpg'),
//              fit: BoxFit.cover,
//            ),
//          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: getUsersServicesStreamSnapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
                  if (!querySnapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  if (querySnapshot.connectionState == ConnectionState.waiting)
                    return Center(child: const CircularProgressIndicator());
//                  if (querySnapshot.hasData == null)
//                    return Text('ccc');
                  else {
                    final list = querySnapshot.data.documents;
                    print(list);
                    return ListView.builder(
                      itemCount: list.length,
//                            scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
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

//    DocumentSnapshot snapshot = await Firestore.instance.collection('Services').document().get();
//                              var channelName = snapshot['channelName'];
//                              print(channelName);
    return FutureBuilder<Object>(
      future:     getUsersTripsStreamSnapshots(bookingDoc.serviceId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final service = Service.fromSnapshot(snapshot.data);
        return GestureDetector(
          onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetailPage(service: service)));
          },
          child: Container(
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
            height: 150,
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
                          bookingDoc.serviceType,
                          style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                        SizedBox(height: 6,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.home, color: Colors.white, size: 20,),
                            SizedBox(width: 5,),
                            Text(
                                bookingDoc.serviceName,
                                style: TextStyle(color: Colors.grey[300], fontSize: 13, letterSpacing: .3)),
                          ],
                        ),
                        SizedBox(height: 6,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.directions_car, color: Colors.white, size: 20,),
                            SizedBox(width: 5,),
                            Text(
                                 bookingDoc.vehicleDetails['brand'],
                                style: TextStyle(color: Colors.white, fontSize: 13, letterSpacing: .3)),
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
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Icon(Icons.chevron_right, size: 40, color: Colors.white,),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

        Future<DocumentSnapshot> getUsersTripsStreamSnapshots(String serviceID) async {
//          final uid = await _auth.getCurrentUID();
          return Firestore.instance.collection('Services').document(serviceID).get();
        }

  Stream<QuerySnapshot> getUsersServicesStreamSnapshots() async* {
    print('under stream');
    final uid = await _auth.getCurrentUID();
    yield* Firestore.instance.collection("Customers").document(uid)
        .collection('Completed')
//        .where('BookingStatus',isEqualTo: 'Accepted')
        .snapshots();
  }
}
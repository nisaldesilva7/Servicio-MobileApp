import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicio/models/booking.dart';
import 'package:servicio/models/service.dart';
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
              color: Colors.indigo,
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
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(90.0),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
            padding: EdgeInsets.only(top: 10),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
                stream: getUsersServicesStreamSnapshots(),
//                        stream: Firestore.instance.collection("Services").where('searchKey', isEqualTo: 'K').snapshots(),
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
            )
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, DocumentSnapshot document) {
    final bookingDoc = Bookings.fromSnapshot(document);
    print(bookingDoc);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 110,
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
                    style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 18),),
                  SizedBox(height: 6,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.indigo, size: 20,),
                      SizedBox(width: 5,),
                      Text(
                          'location of service',
                          style: TextStyle(color: Colors.blue, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  SizedBox(height: 6,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.format_list_bulleted, color: Colors.indigo, size: 20,),
                      SizedBox(width: 5,),
                      Text(
                          '{serviceDoc.serviceTypes[0]}..'.toUpperCase(),
                          style: TextStyle(color: Colors.white10, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Icon(Icons.chevron_right, size: 40, color: Colors.indigo,),
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
        .collection('Completed')
//        .where('BookingStatus',isEqualTo: 'Accepted')
        .snapshots();
  }
}
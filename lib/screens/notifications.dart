import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicio/models/service.dart';
import 'package:servicio/services/auth.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Notifications extends StatefulWidget{


  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var rating = 0.0;
  final db = Firestore.instance;
  final AuthServices _auth = AuthServices();


  Future<QuerySnapshot> getNotificationStatus() async {
    print('notifictions query');
    final uid = await _auth.getCurrentUID();
    await Firestore.instance.collection("Messaging").document(uid)
        .collection('Services')
        .where('read',isEqualTo: true)
        .getDocuments();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Latest Notifications"),
      ),
      body: FutureBuilder(
        future: getNotificationStatus(),
        builder: (context, snapshot) {
          String serviceID = snapshot.data.documentID;
          return FutureBuilder(
              future: getUsersTripsStreamSnapshots(serviceID),
              builder: (context, snap) {
                if (snap.connectionState != ConnectionState.done) {
                  //print('project snapshot data is: ${snap.data}');
                  return Text("loading");
                } else {
                  if (snap.hasError) {
                    return Text(snap.error.toString());
                  }
                  else {
                    if (snap.hasData) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.indigo,
                            Colors.blue
                          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: Offset(1.1, 1.1),
                                blurRadius: 10.0),
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff267bc9),
                        ),
                        width: double.infinity,
                        height: 90,
                        margin: EdgeInsets.symmetric(vertical: 4 , horizontal: 1),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
//          Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetailPage(service: serviceDoc)));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 1),
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.person, color: Colors.white,),
                                              Text(snap.data, style: GoogleFonts.quicksand(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w600),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 9),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.comment, color: Colors.white, size: 20,),
                                        SizedBox(width: 6,),
                                        Text(
                                          'reviewsInfo.comment',
                                          style: GoogleFonts.quicksand(fontSize: 15,color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Text("No DAta");
                    }
                  }
                }
//        print('inside data${snapshot.data}');
//        final service = Service.fromSnapshot(snapshot.data);
//        return Text('hii');
              }
          );
        }
      ),
    );
  }

  Future<DocumentSnapshot> getUsersTripsStreamSnapshots(String uid) async {
    print('getUsersTripsStreamSnapshots$uid');
    return await Firestore.instance.collection('Services').document(uid).get();
  }
}
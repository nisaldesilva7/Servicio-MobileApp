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

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Latest Notifications"),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: getNotificationStatus(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
                if (!querySnapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                if (querySnapshot.connectionState == ConnectionState.waiting)
                  return Center(child: const CircularProgressIndicator());
                else {
                  final list = querySnapshot.data.documents;
                  print(list);
                  return ListView.builder(
                    controller: ScrollController(),
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return buildList(context,list[index]);
                    },
                  );
                }
              }
          ),
        ],
      ),
    );


  }

  Stream<QuerySnapshot> getNotificationStatus() async* {
    print('notifictions query');
    final uid = await _auth.getCurrentUID();
    yield* Firestore.instance.collection("Messaging").document(uid)
        .collection('Services')
        .where('read',isEqualTo: true)
        .snapshots();
  }



Widget buildList(BuildContext context, DocumentSnapshot document) {
  String serviceID = document.documentID;

  return FutureBuilder<Object>(
      future: getUsersTripsStreamSnapshots(serviceID),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final service = Service.fromSnapshot(snapshot.data);
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
                                Text(service.serviceName, style: GoogleFonts.quicksand(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w600),),
                              ],
                            ),
                          ),
//                          Spacer(),
//                          SmoothStarRating(
//                            color: Colors.white,
//                            borderColor: Colors.white,
//                            rating: reviewsInfo.rate,
//                            isReadOnly: false,
//                            size: 20,
//                            filledIconData: Icons.star,
//                            halfFilledIconData: Icons.star_half,
//                            defaultIconData: Icons.star_border,
//                            starCount: 5,
//                            allowHalfRating: true,
//                            spacing: 2.0,
//                            onRated: (value) {
//                              print("rating value -> $value");
//                              // print("rating value dd -> ${value.truncate()}");
//                            },
//                          ),
                        ],
                      ),
                      SizedBox(height: 9),
                      Row(
                        children: <Widget>[
                          Icon(Icons.comment, color: Colors.white, size: 20,),
                          SizedBox(width: 6,),
                          Text(
                            service.telephone.toString(),
                            style: GoogleFonts.quicksand(fontSize: 15,color: Colors.white),
                          )
                        ],
                      ),
//                  SizedBox(height: 6,),
//                  Row(
//                    children: <Widget>[
//                      Icon(Icons.format_list_bulleted, color: Colors.white, size: 20,),
//                      SizedBox(width: 5,),
//                      Text(
//                          '{serviceDoc.serviceTypes[0]}..'.toUpperCase(),
//                          style: TextStyle(color: Colors.white, fontSize: 13, letterSpacing: .3)),
//                    ],
//                  ),
                    ],
                  ),
                ),
//            SizedBox(width: 10),
//            Padding(
//              padding: const EdgeInsets.only(top: 20),
//              child: Icon(Icons.chevron_right, size: 40, color: Colors.white,),
//            )
              ],
            ),
          ),
        );
      }
  );
}



  Future<DocumentSnapshot> getUsersTripsStreamSnapshots(String uid) async {
    return Firestore.instance.collection('Servides').document(uid).get();
  }
}
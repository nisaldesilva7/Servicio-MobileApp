import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicio/models/booking.dart';
import 'package:servicio/models/reviews.dart';
import 'package:servicio/models/vehicle.dart';
import 'package:servicio/services/auth.dart';


class VehiclePage extends StatefulWidget {
  final Vehicle serviceInfo;
  const VehiclePage({Key key, this.serviceInfo}) : super(key: key);

  @override
  _VehiclePageState createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> with SingleTickerProviderStateMixin{

  TabController controller;
  final AuthServices _auth = AuthServices();

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.transparent,
//        elevation: 0,
//      ),
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(left: 15.0),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    color: Color(0xFFEEB139),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
//              SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    widget.serviceInfo.brand.toUpperCase(),
                    style: TextStyle(
                        color: Color(0xFF434C68).withOpacity(0.7),
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cabin',
                        letterSpacing: 0.05
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Image.asset('assets/image/3.jpg',
                    fit: BoxFit.cover,
                    height: 175.0,
                    width: MediaQuery.of(context).size.width - 30.0
                ),
                Text(widget.serviceInfo.model.toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'Cabin',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(widget.serviceInfo.year,
                  style: TextStyle(fontFamily: 'Cabin', fontSize: 14.0, fontWeight: FontWeight.bold, color: Color(0xFF434C68)),
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 0.75,
                  width: MediaQuery.of(context).size.width - 30.0,
                  color: Color(0xFF434C68).withOpacity(0.4),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(Icons.shutter_speed, color: Color(0xFF434C68).withOpacity(0.4)),
                          SizedBox(height: 5.0),
                          Text(widget.serviceInfo.mileage,
                            style: TextStyle(fontFamily: 'Cabin', fontSize: 20.0, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        children: <Widget>[
                          Icon(CupertinoIcons.circle_filled, color: Color(0xFF434C68).withOpacity(0.4)),
                          SizedBox(height: 5.0),
                          Text(widget.serviceInfo.tireSize,
                            style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                          )

                        ],
                      ),
//                      SizedBox(width: 10.0),
//                      Column(
//                        children: <Widget>[
//                          Icon(Icons.network_cell, color: Color(0xFF434C68).withOpacity(0.4)),
//                          SizedBox(height: 5.0),
//                          Text('443',
//                            style: TextStyle(
//                                fontFamily: 'Oswald',
//                                fontSize: 20.0,
//                                fontWeight: FontWeight.bold
//                            ),
//                          )
//
//                        ],
//                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 0.75,
                  width: MediaQuery.of(context).size.width - 30.0,
                  color: Color(0xFF434C68).withOpacity(0.4),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.view_headline, size: 35.0, color: Color(0xFF434C68).withOpacity(0.4)),
                    SizedBox(width: 20.0),
                    Text('Repairs & Services'.toUpperCase(),
                      style: TextStyle(
                          color: Color(0xFF434C68).withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          fontFamily: 'Oswald'
                      ),),
                    SizedBox(width: 20.0),

                  ],
                ),
                Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: getVehicleServices(context),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
                          if (!querySnapshot.hasData)
                            return Center(child: CircularProgressIndicator());
                          if (querySnapshot.connectionState == ConnectionState.waiting)
                            return const CircularProgressIndicator();
                          else {
                            final list = querySnapshot.data.documents;
                            print(list);
                            return ListView.builder(
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
                    )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }



  Widget buildList(BuildContext context, DocumentSnapshot document) {
    final serviceInfo = Bookings.fromSnapshot(document);
    print(serviceInfo);
    List date = serviceInfo.date.toString().split('T');

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xff5b7ccf),
      ),
      width: double.infinity,
      height: 120,
      margin: EdgeInsets.only(top: 5,right: 15),
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 20),
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
                  Text(
                    serviceInfo.serviceType.toUpperCase(),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                  SizedBox(height: 6,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.home, color: Colors.white, size: 20,),
                      SizedBox(width: 5,),
                      Text(
                          serviceInfo.serviceName,
                          style: TextStyle(color: Colors.white, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  SizedBox(height: 6,),
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
//                  Row(
//                    children: <Widget>[
//                      Icon(Icons.format_list_bulleted, color: Colors.white, size: 20,),
//                      SizedBox(width: 5,),
//                      Text(
//                          serviceInfo.serviceId.toUpperCase(),
//                          style: TextStyle(color: Colors.white, fontSize: 13, letterSpacing: .3)),
//                    ],
//                  ),
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

  Stream<QuerySnapshot> getVehicleServices(BuildContext context) async* {
    final uid = await _auth.getCurrentUID();
    yield* Firestore.instance
        .collection('Customers')
    .document(uid)
    .collection('Completed')
        .where('Vehicle', isEqualTo: widget.serviceInfo.vehicleId )
//        .limit(20)
        .snapshots();
  }
}

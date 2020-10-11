import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:servicio/models/customer.dart';
import 'package:servicio/screens/home/bottom_navs/theme/light_colors.dart';
import 'package:servicio/screens/home/bottom_navs/widgets/top_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servicio/screens/myprofile.dart';
import 'package:servicio/screens/side_nav/my_vehicles/my_vehicles.dart';
import 'package:servicio/services/auth.dart';

class ProfileThreePage extends StatefulWidget {


  @override
  _ProfileThreePageState createState() => _ProfileThreePageState();
}

class _ProfileThreePageState extends State<ProfileThreePage> {
  final AuthServices _auth = AuthServices();


  @override
  Widget build(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  TopContainer(
                    height: 125,
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
                                  radius: 90.0,
                                  lineWidth: 5.0,
                                  animation: true,
                                  percent: 0.5,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Colors.blueAccent ,
                                  backgroundColor: LightColors.kDarkYellow,
                                  center: FutureBuilder(
                                    future: getUsersTripsStreamSnapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 100),
                                          child: Center(child: CircularProgressIndicator()),
                                        );
                                      }
                                      final customer = Customer.fromSnapshot(snapshot.data);
                                      return GestureDetector(
                                        onTap: () => _showImageDialog(context, customer.photo),
                                        child: InkWell(
                                          child: CircleAvatar(
                                            radius: 38,
                                              backgroundColor: Colors.black26,
                                              backgroundImage: customer.photo == null ? AssetImage('assets/image/no_dp.png'):
                                              NetworkImage(
                                                customer.photo,
                                              )
                                          ),
                                          onTap: () {
                                            return Navigator.of(context).pushNamed("/image");
                                          },
                                        ),
                                      );
                                    }
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            'My Profile ',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 22.0, color: Colors.white,fontFamily: 'Cabin', fontWeight: FontWeight.w800,),
                                          ),
                                          _getEditIcon(),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        'Dashboard',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w400,),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ]),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyVehicles()));
                          },
                          child: _buildWikiCategory(FontAwesomeIcons.car,
                              "My Vehicles".toUpperCase(), Colors.deepOrange.withOpacity(0.7)),
                        ),
                      ),
//                      const SizedBox(width: 10.0),
//                      Expanded(
//                        child: _buildWikiCategory(FontAwesomeIcons.lock,
//                            "My private notes", Colors.blue.withOpacity(0.6)),
//                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  FutureBuilder(
                     future:  getUsersTripsStreamSnapshots(),
                     builder: (context, snapshot) {
                       if (!snapshot.hasData) {
                         return Padding(
                           padding: const EdgeInsets.only(top: 100),
                           child: Center(child: CircularProgressIndicator()),
                         );
                       }
                       final customer = Customer.fromSnapshot(snapshot.data);
                       return Container(
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(25.0),
                         ),
                         child: Column(
                           children: <Widget>[
                             ListTile(title: Center(child: Text(customer.name.toUpperCase(),style: GoogleFonts.ubuntu(fontSize: 25,color: Colors.indigo),))),
                             Divider(),
                             ListTile(
                               title: Text("Email"),
                               subtitle: Text(customer.email),
                               leading: Icon(Icons.email),
                             ),
                             ListTile(
                               title: Text("Phone"),
                               subtitle: Text(customer.number),
                               leading: Icon(Icons.phone),
                             ),
                           ],
                         ),
                       );
                     }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//  Widget test(BuildContext context) {
//    return new FutureBuilder(
//        future:  getUsersTripsStreamSnapshots(),
//        builder: (context, snapshot) {
//          if (!snapshot.hasData) {
//            return new Text("Loading");
//          }
//          var userDocument = snapshot.data;
//          return new Text(userDocument["email"]);
//        }
//    );
//  }

  Future<DocumentSnapshot> getUsersTripsStreamSnapshots() async {
    final uid = await _auth.getCurrentUID();
    return Firestore.instance.collection('Customers').document(uid).get();
  }



  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 20.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 25.0,
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
//        Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile(user: userDoc)));

      },
    );
  }

  _showImageDialog(BuildContext context, String image) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                child: Image.asset(image, fit: BoxFit.contain)
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
//                const SizedBox(width: 10.0),
//                IconButton(
//                  color: Colors.white,
//                  icon: Icon(Icons.share),
//                  onPressed: () {},
//                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Stack _buildWikiCategory(IconData icon, String label, Color color) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(30.0),
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
              const SizedBox(height: 10.0),
              Text(
                label,
                style: GoogleFonts.quicksand(
                  color: Colors.white,
                  fontSize: 20.0

                ),
              )
            ],
          ),
        )
      ],
    );
  }

}



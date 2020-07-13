
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servicio/screens/service_page/service_detail_view.dart';

class MainView extends StatelessWidget {
  static final String path = "lib/src/pages/travel/travel_home.dart";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          HomeScreenTop(),
          homeScreenBottom,
        ],

      ),
    );
  }
}

class HomeScreenTop extends StatefulWidget {
  @override
  _HomeScreenTopState createState() => _HomeScreenTopState();
}

class _HomeScreenTopState extends State<HomeScreenTop> {
  final TextStyle dropdownMenuLabel =
  TextStyle(color: Colors.white, fontSize: 16);
  final TextStyle dropdownMenuItem =
  TextStyle(color: Colors.black, fontSize: 18);
  List<String> locations = ['Colombo', 'Gampaha'];
  var selectedLocationIndex = 0;
  bool isflightSelected = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 350,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.blue])),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.white,),
                      SizedBox(width: 16,),
                      PopupMenuButton(
                        onSelected: (index) {
                          setState(() {
                            selectedLocationIndex = index;
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Text(
                              locations[selectedLocationIndex],
                              style: dropdownMenuLabel,
                            ),
                            Icon(Icons.keyboard_arrow_down, color: Colors.white,)
                          ],
                        ),
                        itemBuilder: (BuildContext context) =>
                        <PopupMenuItem<int>>[
                          PopupMenuItem(
                            child: Text(locations[0], style: dropdownMenuItem,),
                            value: 0,
                          ),
                          PopupMenuItem(
                            child: Text(locations[1], style: dropdownMenuItem,),
                            value: 1,
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.settings, color: Colors.white,)
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                    width: 250,
                    child: Text(
                      "Where do you want to FIND ?",
                      style: TextStyle(fontFamily: 'OpenSans', fontSize: 24, color: Colors.white, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: TextField(
                      controller: TextEditingController(text: locations[0]),
                      cursorColor: Theme.of(context).primaryColor,
                      style: dropdownMenuItem,
                      decoration: InputDecoration(
                          suffixIcon: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: Icon(Icons.search),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          setState(() {
                            isflightSelected = true;
                          });
                        },
                        child: ChoiceChip(
                            Icons.supervised_user_circle, "Services", isflightSelected)),
                    SizedBox(width: 20,),
                    InkWell(
                        onTap: () {
                          setState(() {
                            isflightSelected = false;
                          });
                        },
                        child: ChoiceChip(
                            CupertinoIcons.gear_solid, "Repair Centers", !isflightSelected)),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChoiceChip extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isflightSelected;
  ChoiceChip(this.icon, this.text, this.isflightSelected);
  @override
  _ChoiceChipState createState() => _ChoiceChipState();
}

class _ChoiceChipState extends State<ChoiceChip> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: widget.isflightSelected
          ? BoxDecoration(
          color: Colors.white.withOpacity(.15),
          borderRadius: BorderRadius.all(Radius.circular(20)))
          : null,
      child: Row(
        children: <Widget>[
          Icon(widget.icon, size: 20, color: Colors.white,
          ),
          SizedBox(width: 8,),
          Text(widget.text, style: TextStyle(color: Colors.white, fontSize: 14))
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height);

    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    var firstControlPoint = Offset(size.width / 4, size.height - 53);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondEndPoint = Offset(size.width, size.height - 90);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 14);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

final Widget homeScreenBottom = Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text("Nearby Service Centers",
              style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w700)),
          Spacer(),
          Builder(
              builder: (BuildContext context) => Text(
                "View All",
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).primaryColor),
              ))
        ],
      ),
    ),
    Container(
        height: 210,
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('Services').limit(3).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
              if (!querySnapshot.hasData)
                return Text('No Data');
              if (querySnapshot.connectionState == ConnectionState.waiting)
                return const CircularProgressIndicator();
              else {
                final list = querySnapshot.data.documents;
                print(list);
                return ListView.builder(
                  itemCount: list.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CityCard(ServiceList: list[index],);
                  },
                );
              }
            }
        )
    ),
  ],
);



class CityCard extends StatelessWidget {

  // ignore: non_constant_identifier_names
  final DocumentSnapshot ServiceList ;
  // ignore: non_constant_identifier_names
  CityCard({Key key, this.ServiceList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetailPage(service: ServiceList)));
       },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Stack(
            children: <Widget>[
              Container(
                  width: 160,
                  height: 210,
                  child: Image(
                    image: ExactAssetImage(
                        'assets/image/3.jpg'),
                    fit: BoxFit.cover,
                  )
              ),
              Positioned(
                left: 0,
                bottom: 0,
                width: 160,
                height: 60,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black, Colors.black12])),
                ),
              ),
              Positioned(
                left: 10,
                bottom: 10,
                width: 145,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          ServiceList["Service_Name"],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1),
                        ),
                        Text(
                          'Service Types',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          ServiceList["Rating"],
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

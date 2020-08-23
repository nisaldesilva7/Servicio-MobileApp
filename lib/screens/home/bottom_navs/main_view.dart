
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servicio/models/service.dart';
import 'package:servicio/screens/home/bottom_navs/search.dart';
import 'package:servicio/screens/service_page/service_detail_view.dart';
import 'package:servicio/services/auth.dart';
import 'package:servicio/shared/SliderImages.dart' as assets;

class MainView extends StatefulWidget {
  static final String path = "lib/src/pages/travel/travel_home.dart";

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final AuthServices _auth = AuthServices();
  List userFavourites ;

  @override
  void initState()  {
    super.initState();
    getUserFavs();
  }


  getUserFavs() async {
    final AuthServices _auth = AuthServices();
    final uid = await _auth.getCurrentUID();
    DocumentSnapshot result = await Firestore.instance.collection('Customers').document(uid).get();
    List favs = result.data['Favs'];
    print('xxxxxxxx$favs');
    setState(() {
      userFavourites = favs;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          HomeScreenTop(),
          homeScreenBottom,
          SizedBox(height: 15.0,),
          SlideBar(),
          Column(
          children: <Widget>[
            Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
               child: Row(
               mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                 Text("Favourite Service Centers",
                    style: TextStyle(color: Colors.black87, fontSize: 15, fontFamily: 'icomoon', fontWeight:FontWeight.w400)),
                  Icon(Icons.favorite,color: Colors.redAccent,)
              ],
            ),
          ),
          Container(
              height: 210,
              child: StreamBuilder<QuerySnapshot>(
                  stream: getUsersServicesStreamSnapshots(userFavourites),
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
                          return cityCard(context, list[index]);
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
                    colors: [Colors.indigo, Colors.blue])
            ),
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
                      GestureDetector(
                          onTap: () {

                          },
                          child: Icon(Icons.settings, color: Colors.white,))
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                    width: 250,
                    child: Text(
                      "Where do you want to FIND ?",
                      style: TextStyle(fontFamily: 'Cabin', fontSize: 24, color: Colors.white, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(height: 25,),
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
              style: TextStyle(color: Colors.black87, fontSize: 15, fontFamily: 'icomoon', fontWeight:FontWeight.w400)),
          Spacer(),
          Builder(
                builder: (BuildContext context) => GestureDetector(
                  onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchView()));
                      },
                  child: Text(
                    "View All",
                    style: TextStyle(
                        fontSize: 14, color: Theme.of(context).primaryColor),
                  ),
                )),

        ],
      ),
    ),
    Container(
        height: 210,
        child: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance.collection('Services').where('').limit(3).getDocuments(),
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
                    return cityCard(context, list[index]);
                  },
                );
              }
            }
        )
    ),
  ],
);




//
// Widget favouriteCardList = Column(
//  children: <Widget>[
//    Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//      child: Row(
//        mainAxisSize: MainAxisSize.max,
//        children: <Widget>[
//          Text("Favourite Service Centers",
//              style: TextStyle(color: Colors.black87, fontSize: 15, fontFamily: 'icomoon', fontWeight:FontWeight.w400)),
//        ],
//      ),
//    ),
//    Container(
//        height: 210,
//        child: StreamBuilder<QuerySnapshot>(
//            stream: getUsersServicesStreamSnapshots(userFavourites),
//            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
//              if (!querySnapshot.hasData)
//                return Text('No Data');
//              if (querySnapshot.connectionState == ConnectionState.waiting)
//                return const CircularProgressIndicator();
//              else {
//                final list = querySnapshot.data.documents;
//                print(list);
//                return ListView.builder(
//                  itemCount: list.length,
//                  scrollDirection: Axis.horizontal,
//                  itemBuilder: (context, index) {
//                    return cityCard(context, list[index]);
//                  },
//                );
//              }
//            }
//        )
//    ),
//  ],
//);
//



Stream<QuerySnapshot> getUsersServicesStreamSnapshots(List favs) async* {
  print('under stream $favs');
  yield* Firestore.instance.collection("Services").where('Service_Id', whereIn: favs).snapshots();
}


Widget getTextWidgets(List<String> strings)
{
  return new Row(children: strings.map((item) => new Text('$item ...'.toUpperCase(),
    style: TextStyle(
        color: Colors.grey,
        fontSize: 13,
        fontWeight: FontWeight.normal),
  )).toList().sublist(0,1));
}


Widget cityCard(BuildContext context, DocumentSnapshot serviceList) {

  final serviceDoc = Service.fromSnapshot(serviceList);
  print(serviceDoc.searchKey);

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetailPage(service: serviceDoc)));
       },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Stack(
            children: <Widget>[
              Container(
                  width: 170,
                  height: 210,
                  child: Image.network(
                    serviceDoc.photo,
                    fit: BoxFit.cover,
                  ),
              ),
              Positioned(left: 0, bottom: 0, width: 170, height: 60,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black, Colors.black12])),
                ),
              ),
              Positioned(left: 10, bottom: 10, width: 155,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          serviceDoc.serviceName.toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'OpenSans', fontWeight: FontWeight.w800, letterSpacing: 1),
                        ),
                         SingleChildScrollView(
                           scrollDirection: Axis.horizontal,
                             child: getTextWidgets(serviceDoc.serviceTypes)
                         )
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          serviceDoc.rating.toString(),
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

class SlideBar extends StatelessWidget {
  final List<String> images = [assets.images[0],assets.images[2],assets.images[1], assets.images[3]];

  @override
  Widget build(BuildContext context) {
      return images != null ? CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 4),
          autoPlayAnimationDuration: Duration(milliseconds: 100),
          autoPlayCurve: Curves.easeInOutCubic,
          enlargeCenterPage: true,
//        onPageChanged: callbackFunction,
          scrollDirection: Axis.horizontal,

        ),
        items: images.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return  ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 1.0),
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Image.network(
                    i,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ): CircularProgressIndicator();
  }
}



import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicio/models/service.dart';
import 'package:servicio/screens/home/bottom_navs/main_menu.dart';
import 'package:servicio/screens/home/bottom_navs/search.dart';
import 'package:servicio/screens/service_page/service_detail_view.dart';
import 'package:servicio/screens/app_settings.dart';
import 'package:servicio/screens/side_nav/my_vehicles/addNew_vehicle.dart';
import 'package:servicio/screens/side_nav/my_vehicles/my_vehicles.dart';
import 'package:servicio/services/auth.dart';
import 'package:servicio/shared/SliderImages.dart' as assets;
import 'package:servicio/shared/card_colors.dart';


class MainView extends StatefulWidget {
  static final String path = "lib/src/pages/travel/travel_home.dart";

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final AuthServices _auth = AuthServices();
  List userFavourites ;
  bool vehiclesNull = true;

  @override
  void initState()  {
    super.initState();
    getUserFavs();
    checkVehicleNull();
  }

  checkVehicleNull() async {
    final AuthServices _auth = AuthServices();
    final uid = await _auth.getCurrentUID();
    QuerySnapshot result = await Firestore.instance.collection('Customers').document(uid).collection('Vehicles').getDocuments();
    print('zzzzzzzzzz${result.documents}');
    if(result.documents.length == 0){
     vehiclesNull = false;
   }
   else{
     vehiclesNull = true;
   }
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

  final TextStyle dropdownMenuLabel =
  TextStyle(color: Colors.white, fontSize: 16);
  final TextStyle dropdownMenuItem =
  TextStyle(color: Colors.black, fontSize: 18);
  List<String> locations = ['Colombo', 'Gampaha'];
  var selectedLocationIndex = 0;
  bool isflightSelected = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          vehiclesNull == false ? Container(
            height: 47,
            color: Color(0xff9bf500),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Text("Please Add a Vehicel before start Booking", style: GoogleFonts.roboto(),),
                  Spacer(),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewVehicle()));
                      },
                      child: Icon(Icons.add,size: 25,color: Colors.indigo,)),

                ],
              ),
            ),
          ): Container(),
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 350,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.indigo,Colors.blue])
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,right: 16.0,bottom: 16.0,),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.location_on,color: Colors.white,),
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
                                  Icon(Icons.keyboard_arrow_down,
                                    color: Colors.white,)
                                ],
                              ),
                              itemBuilder: (BuildContext context) =>
                              <PopupMenuItem<int>>[
                                PopupMenuItem(
                                  child: Text(
                                    locations[0],style: dropdownMenuItem,),
                                  value: 0,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    locations[1],style: dropdownMenuItem,),
                                  value: 1,
                                ),
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.settings),
                              onPressed: () {
                                Navigator.push(context,MaterialPageRoute(
                                    builder: (context) => AppSettings()));
                              },
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                          width: 250,
                          child: Text(
                            "Find Services And Repair centers Easily",
                            style: TextStyle(
                                fontFamily: 'Cabin',fontSize: 24,color: Colors
                                .white,fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(height: 25,),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(
                              builder: (context) => SearchView()));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: TextField(
                              controller: TextEditingController(text: 'Serach'),
                              enabled: false,
                              cursorColor: Theme
                                  .of(context)
                                  .primaryColor,
                              style: dropdownMenuItem,
                              decoration: InputDecoration(
                                  suffixIcon: Material(
                                    elevation: 2.0,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30)),
                                    child: Icon(Icons.search),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 25,vertical: 13)
                              ),
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
                                  Icons.supervised_user_circle,"Services",
                                  isflightSelected)),
                          SizedBox(width: 20,),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  isflightSelected = false;
                                });
                              },
                              child: ChoiceChip(
                                  CupertinoIcons.gear_solid,"Repair Centers",
                                  !isflightSelected)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          homeScreenBottom,
          SizedBox(height: 15.0,),
          SlideBar(),
          WorkoutView(),
          Column(
          children: <Widget>[
            Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
               child: Row(
               mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                 Text("Favourites",
                    style: GoogleFonts.quicksand(color: Colors.black87, fontSize: 15, fontWeight:FontWeight.w400)),
                  Spacer(),
                  Icon(Icons.favorite,color: Colors.redAccent,size: 20,)
              ],
            ),
          ),
          Container(
              height: 210,
//              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: StreamBuilder<QuerySnapshot>(
                  stream: getUsersServicesStreamSnapshots(userFavourites).asBroadcastStream(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
                    if (!querySnapshot.hasData)
                      return Center(child: const CircularProgressIndicator());
                    if (querySnapshot.connectionState == ConnectionState.waiting)
                      return Center(child: const CircularProgressIndicator());
                    else {
                      final list = querySnapshot.data.documents;
                      print(list);
                      return ListView.builder(
                        itemCount: list.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return cityCard(context, list[index], 'user_type');
                        },
                      );
                    }
                  }
              )
          ),
        ],
      ),
          isflightSelected == true ?   serviceCenters : repairCenters

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
                  padding: const EdgeInsets.only(left:16.0,right:16.0,bottom:16.0,),
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
                      IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AppSettings()));

                        },
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                    width: 250,
                    child: Text(
                      "Find Services And Repair centers Easily",
                      style: TextStyle(fontFamily: 'Cabin', fontSize: 24, color: Colors.white, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchView()));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: TextField(
                        controller: TextEditingController(text: 'Search'),
                        enabled: false,
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
              style: GoogleFonts.quicksand(color: Colors.black87, fontSize: 15, fontWeight:FontWeight.w400)),
          Spacer(),
          Builder(
                builder: (BuildContext context) => GestureDetector(
                  onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu()));
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
                    return cityCard(context, list[index], 'user_type');
                  },
                );
              }
            }
        )
    ),
  ],
);


final Widget repairCenters =  Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text("Repair Centers",
              style: GoogleFonts.quicksand(color: Colors.black87, fontSize: 15, fontWeight:FontWeight.w400)),
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
            future: Firestore.instance.collection('Services').where('user_type', isEqualTo: 'garage').limit(10).getDocuments(),
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
                    return cityCard(context, list[index], 'user_type');
                  },
                );
              }
            }
        )
    ),
  ],
);


final Widget serviceCenters =  Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text("Service Centers",
              style: GoogleFonts.quicksand(color: Colors.black87, fontSize: 15, fontWeight:FontWeight.w400)),
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
            future: Firestore.instance.collection('Services').where('user_type', isEqualTo: 'service').limit(10).getDocuments(),
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
                    return cityCard(context, list[index], 'user_type');
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


Widget cityCard(BuildContext context, DocumentSnapshot serviceList, String userType) {

  final serviceDoc = Service.fromSnapshot(serviceList);
  print(serviceDoc.telephone.toString());

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
                  width: 180,
                  height: 210,
                  child: Image.network(
                    serviceDoc.photo,
                    fit: BoxFit.cover,
                  ),
              ),
              Positioned(left: 0, bottom: 0, width: 180, height: 60,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black54, Colors.transparent])),
                ),
              ),
              Positioned(left: 10, bottom: 10, width: 165,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          serviceDoc.serviceName.toUpperCase(),
                          style: GoogleFonts.quicksand(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 1),
                        ),
                         SingleChildScrollView(
                           scrollDirection: Axis.horizontal,
                             child: Text(serviceDoc.city,
                             style: GoogleFonts.quicksand(color: Colors.white),)
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



class WorkoutView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
       GestureDetector(
         onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => MyVehicles()));

         },
         child: Padding(
           padding: const EdgeInsets.only(
               left: 15, right: 15, top: 16, bottom: 18),
           child: Container(
             decoration: BoxDecoration(
               gradient: LinearGradient(colors: [
                 FitnessAppTheme.nearlyDarkBlue,
                     Colors.blue
               ], begin: Alignment.topLeft, end: Alignment.bottomRight),
               borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(8.0),
                   bottomLeft: Radius.circular(8.0),
                   bottomRight: Radius.circular(8.0),
                   topRight: Radius.circular(68.0)),
               boxShadow: <BoxShadow>[
                 BoxShadow(
                     color: FitnessAppTheme.grey.withOpacity(0.6),
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
                     'My Vehicles',
                     textAlign: TextAlign.left,
                     style: TextStyle(
                       fontFamily: FitnessAppTheme.fontName,
                       fontWeight: FontWeight.normal,
                       fontSize: 14,
                       letterSpacing: 0.0,
                       color: FitnessAppTheme.white,
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 8.0),
                     child: Text(
                       'Manage your all vehicles at one place\nTrack your Vehicle History',
                       textAlign: TextAlign.left,
                       style: GoogleFonts.quicksand(
                         fontWeight: FontWeight.normal,
                         fontSize: 17,
                         letterSpacing: 0.0,
                         color: FitnessAppTheme.white,
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
                         Padding(
                           padding: const EdgeInsets.only(left: 4.0),
                           child: Text(
                             'Click to view',
                             textAlign: TextAlign.center,
                             style: GoogleFonts.quicksand(

                               fontWeight: FontWeight.w500,
                               fontSize: 14,
                               letterSpacing: 0.0,
                               color: FitnessAppTheme.white,
                             ),
                           ),
                         ),
                         Expanded(
                           child: SizedBox(),
                         ),
                         Container(
                           decoration: BoxDecoration(
                             color: FitnessAppTheme.nearlyWhite,
                             shape: BoxShape.circle,
                             boxShadow: <BoxShadow>[
                               BoxShadow(
                                   color: FitnessAppTheme.nearlyBlack
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


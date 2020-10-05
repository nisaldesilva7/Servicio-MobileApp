
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicio/models/reviews.dart';
import 'package:servicio/screens/bookings/book_service.dart';
import 'package:servicio/models/service.dart';
import 'package:servicio/screens/bookings/view_service_schedule.dart';
import 'package:servicio/screens/chatui.dart';
import 'package:servicio/screens/service_page/complaint_service.dart';
import 'package:servicio/services/service_locator.dart';
import 'package:servicio/services/urlService.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:servicio/services/auth.dart';


class ServiceDetailPage extends StatefulWidget {

  final Service service;
  const ServiceDetailPage({Key key, this.service}) : super(key: key);

  @override
  _ServiceDetailPageState createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  bool isFav = false;
  final String number = "123456789";
  final AuthServices _auth = AuthServices();
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();


  checkStatus() async {
    final uid = await _auth.getCurrentUID();
    print('length${widget.service.favs.length}');
    for(int i=0; i<widget.service.favs.length;i++){
      if(widget.service.favs[i] == uid){
        print('autorun');
        setState(() {
          isFav = true;
        });
      }
      print('no==');

    }
  }


  @override
  void initState() {
    checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
//        backgroundColor: Colors.transparent,
        backgroundColor: Color(0x20000000),
        elevation: 0,
        title: Text(widget.service.serviceName.toUpperCase()),
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.report),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Complaint(service: widget.service)));
            },
          ),
        IconButton(
          color: Colors.white,
          icon: Icon(Icons.message),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBox(service: widget.service)));
            },
        ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.call),
            onPressed: () => _service.call(widget.service.telephone),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
              foregroundDecoration: BoxDecoration(
                  color: Colors.black26
              ),
              height: 400,
              child: Image.network(widget.service.photo, fit: BoxFit.cover)

          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0,bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 230),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:16.0),
                  child: Text(
                    widget.service.serviceName.toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 28.0,fontFamily: 'MyFlutterApp', fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 16.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.location_city, color: Colors.white,),
                          SizedBox(width: 5,),
                          Text(widget.service.city.toUpperCase(), style:GoogleFonts.teko(fontSize: 30,color: Colors.white),),
                        ],
                      ),
                    Spacer(),
                    isFav == true ? IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.favorite, color: Colors.red,),
                      onPressed: () async {
                        setState(() {
                          isFav = false;
                        });
                        final uid = await _auth.getCurrentUID();
                        await Firestore.instance.collection("Customers").document(uid).updateData({"Favs": FieldValue.arrayRemove([widget.service.serviceId])});
                        await Firestore.instance.collection("Services").document(widget.service.serviceId).updateData({"Favs": FieldValue.arrayRemove([uid])});
                        print('succes collection');
                      },
                    ):
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.favorite_border),
                      onPressed: () async {
                        setState(() {
                          isFav = true;
                        });
                        final uid = await _auth.getCurrentUID();
                        await Firestore.instance.collection("Customers").document(uid).updateData({"Favs": FieldValue.arrayUnion([widget.service.serviceId])});
                        await Firestore.instance.collection("Services").document(widget.service.serviceId).updateData({"Favs": FieldValue.arrayUnion([uid])});
                        print('succes collection');
                      },
                    )

                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                showStars(widget.service.rating),
                               ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _launchMapsUrl(6.90893,79.8616667);
                            },
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 150,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            color: Colors.indigo[400],
                                            borderRadius: BorderRadius.circular(12.0)),
                                        child: Center(child: Text.rich(TextSpan(children: [
                                          WidgetSpan(
                                              child: Icon(Icons.location_on, size: 22.0, color: Colors.grey[200],)
                                          ),
                                          TextSpan(
                                              text: "View Location"
                                          )
                                        ]), style: TextStyle(color: Colors.grey[200], fontSize: 17.0),)
                                        )
                                    ),
                                  ],
                                ),
//                                Text("     Click to view".toUpperCase(), style: GoogleFonts.roboto(fontSize: 10,color: Colors.grey[400])),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.all(1),
                        crossAxisCount: 4,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 0.0,
                        children: widget.service.serviceTypes
                            .map(
                              (serviceTypes) => Column(
                            children: <Widget>[
                              Container(
                                height: 45.0,
                                width: 100.0,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6.0,
                                  horizontal: 6.0,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.indigo[400],
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Center(
                                  child: Text(
                                    serviceTypes.toString().toUpperCase(),
                                    style: TextStyle(color: Colors.white,fontFamily: 'cabin', fontSize: 11.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).toList(),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                          color: Colors.purple,
                          textColor: Colors.white,
                          child: Text("Book Now".toUpperCase(), style: GoogleFonts.bebasNeue(
                            fontSize: 30,
                          ),),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 32.0,
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BookService(serviceInfo: widget.service)));
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.description, color: Colors.indigo,),
                          SizedBox(width: 5,),
                          Text("Description".toUpperCase(), style: GoogleFonts.montserrat(fontSize: 20,color: Colors.black54)),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                          widget.service.description, textAlign: TextAlign.justify, style: GoogleFonts.quicksand(fontSize: 14)),
                      const SizedBox(height: 20.0),
                      Row(
                        children: <Widget>[
                          Icon(CupertinoIcons.location_solid, color: Colors.indigo,),
                          SizedBox(width: 5,),
                          Text("ADdress".toUpperCase(), style: GoogleFonts.montserrat(fontSize: 20,color: Colors.black54)),
                        ],
                      ),
                      const SizedBox(height: 10.0),

                      Text(
                          widget.service.address1, textAlign: TextAlign.justify, style: GoogleFonts.quicksand(fontSize: 14)),
                      Text(
                          widget.service.address2, textAlign: TextAlign.justify, style: GoogleFonts.quicksand(fontSize: 14)),
                      const SizedBox(height: 25.0),
                      Row(
                        children: <Widget>[
                          Icon(CupertinoIcons.location_solid, color: Colors.indigo,),
                          SizedBox(width: 5,),
                          Text(
                              'REVIEWS',
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.montserrat(fontSize: 20,color: Colors.black54)
                          ),
                        ],
                      ),
                      Container(
                          child: Column(
                            children: <Widget>[

                              StreamBuilder<QuerySnapshot>(
                                  stream: getReviews(context),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
                                    if (!querySnapshot.hasData)
                                      return Center(child: CircularProgressIndicator());
                                    if (querySnapshot.connectionState == ConnectionState.waiting)
                                      return Center(child: const CircularProgressIndicator());
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
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget buildList(BuildContext context, DocumentSnapshot document) {
    final reviewsInfo = Reviews.fromSnapshot(document);
    print(Reviews);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xff267bc9),
      ),
      width: double.infinity,
      height: 84,
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
                      Icon(Icons.comment, color: Colors.white, size: 20,),
                      SizedBox(width: 6,),
                      Text(
                        reviewsInfo.comment,
                        style: GoogleFonts.roboto(fontSize: 15,color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(height: 6,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.white, size: 20,),
                      SizedBox(width: 6,),
                      SmoothStarRating(
                           color: Colors.white,
                           borderColor: Colors.white,
                           rating: reviewsInfo.rate,
                           isReadOnly: false,
                           size: 20,
                           filledIconData: Icons.star,
                           halfFilledIconData: Icons.star_half,
                           defaultIconData: Icons.star_border,
                           starCount: 5,
                           allowHalfRating: true,
                           spacing: 2.0,
                           onRated: (value) {
                             print("rating value -> $value");
                             // print("rating value dd -> ${value.truncate()}");
                    },
                  ),
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

  Stream<QuerySnapshot> getReviews(BuildContext context) async* {
    final uid = await _auth.getCurrentUID();
    yield* Firestore.instance
        .collection('Reviews')
        .where('serviceID', isEqualTo: widget.service.serviceId )
        .limit(20)
        .snapshots();
  }

  Widget showStars(num rating){
    print(rating);
      return Row(
        children: [
          for (num i = 0; i < rating.round(); i++) Icon(Icons.star, color: Colors.purple, size: 30,),
          for (num i = 0; i < (5-rating.round()); i++) Icon(Icons.star_border, color: Colors.purple,size: 30,)
        ],
      );
  }
}

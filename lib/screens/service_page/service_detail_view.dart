
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicio/screens/bookings/book_service.dart';
import 'package:servicio/models/service.dart';
import 'package:servicio/screens/bookings/view_service_schedule.dart';
import 'package:servicio/screens/chatui.dart';
import 'package:servicio/services/service_locator.dart';
import 'package:servicio/services/urlService.dart';
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
          icon: Icon(Icons.message),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBox()));
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text(
                        "8.4/85 reviews",
                        style: TextStyle(color: Colors.white, fontSize: 13.0),
                      ),
                    ),
                    Spacer(),
                    isFav == true ? IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.favorite),
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
                                Text.rich(TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(Icons.location_on, size: 16.0, color: Colors.grey,)
                                  ),
                                  TextSpan(
                                      text: "Show location"
                                  )
                                ]), style: TextStyle(color: Colors.grey, fontSize: 12.0),)
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text("Categories", style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0
                              ),),
                              Text("Showing Tabs",style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey
                              ),)
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      GridView.count(
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
                                height: 50.0,
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
                                    style: TextStyle(color: Colors.white,fontFamily: 'cabin', fontSize: 13.0),
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
                      Text("Description".toUpperCase(), style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0
                      ),),
                      const SizedBox(height: 10.0),
                      Text(
                          widget.service.description, textAlign: TextAlign.justify, style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0
                      ),),
                      const SizedBox(height: 10.0),
                      Text(
                        "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ratione architecto autem quasi nisi iusto eius ex dolorum velit! Atque, veniam! Atque incidunt laudantium eveniet sint quod harum facere numquam molestias?", textAlign: TextAlign.justify, style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0),
                      ),
                      SizedBox(height: 10.0,),
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

  Widget showStars(num rating){
    print(rating);
      return Row(
        children: [
          for (num i = 0; i < rating.round(); i++) Icon(Icons.star, color: Colors.purple,),
          for (num i = 0; i < (5-rating.round()); i++) Icon(Icons.star_border, color: Colors.purple,)
        ],
      );
  }
}

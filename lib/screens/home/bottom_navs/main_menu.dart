import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicio/models/service.dart';
import 'package:servicio/screens/service_page/service_detail_view.dart';
import 'package:servicio/services/auth.dart';
import 'package:servicio/widget/stub_data.dart';

class MainMenu extends StatefulWidget {

  MainMenu({Key key}) : super(key: key);
  _MainMenuState createState() => _MainMenuState();

}

class _MainMenuState extends State<MainMenu> {

  final AuthServices _auth = AuthServices();

  final TextStyle dropdownMenuItem =
  TextStyle(color: Colors.black, fontSize: 10);

  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);
  final List<HotelCard> hotel = StubData().hotels;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[200],
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Container(
                height: 95,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2.0, 2.0),
                              color: Colors.blue,
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextField(
                            onChanged: (val) {},
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: "What do you need?",
                                hintStyle: TextStyle(
                                    color: Colors.indigo, fontSize: 14),
                                border: InputBorder.none,
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 7)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Container(
                    padding: EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: getUsersServicesStreamSnapshots(context),
//                        stream: Firestore.instance.collection("Services").where('searchKey', isEqualTo: 'K').snapshots(),
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
            ],
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getUsersServicesStreamSnapshots(BuildContext context) async* {
    final uid = await _auth.getCurrentUID();
    yield* Firestore.instance.collection("Services").snapshots();
  }

  Widget buildList(BuildContext context, DocumentSnapshot document) {
    final serviceDoc = Service.fromSnapshot(document);
    print(serviceDoc);

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetailPage(service: serviceDoc)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 110,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 17, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 75,
              height: 75,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(width: 3, color: Colors.red),
                image: DecorationImage(
                    image: NetworkImage('${serviceDoc.photo}'),
                    fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    serviceDoc.serviceName,
                    style: TextStyle(color: primary, fontWeight: FontWeight.bold, fontSize: 18),),
                  SizedBox(height: 6,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.indigo, size: 20,),
                      SizedBox(width: 5,),
                      Text(
                          'location of service',
                          style: TextStyle(color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  SizedBox(height: 6,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.format_list_bulleted, color: Colors.indigo, size: 20,),
                      SizedBox(width: 5,),
                      Text(
                          'Categories',
                          style: TextStyle(color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

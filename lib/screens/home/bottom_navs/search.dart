import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicio/models/service.dart';
import 'package:servicio/screens/home/bottom_navs/filter/filter_categories.dart';
import 'package:servicio/screens/service_page/service_detail_view.dart';
import 'package:servicio/screens/side_nav/my_vehicles/my_vehicles.dart';
import 'package:servicio/services/searchservice.dart';




class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => new _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  QuerySnapshot serviceInfo;

  var queryResultSet = [];
  var tempSearchStore = [];


  final doc = Firestore.instance.collection("Services").getDocuments();


  initiateSearch(value) {

    if (value.length == 0) {
      setState(() {
        //Should load all services
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue = value.substring(0, 1).toUpperCase() + value.substring(1);
    print('hiiiiiiiii${value.substring(0)}');

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        serviceInfo = docs;
        print(docs.documents);
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
          print('helooo$queryResultSet \n');
        }
        queryResultSet.forEach((element) {
          if (element['Service_Name'].startsWith(capitalizedValue)) {
            setState(() {
              tempSearchStore.add(element);
              print('tempsearch  $queryResultSet \n');
            });
          }
        });
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['Service_Name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx$tempSearchStore');
    return new Scaffold(
      backgroundColor: Colors.indigo,
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:15,vertical: 8),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Filter()));
              },
              child: _buildWikiCategory(FontAwesomeIcons.filter,
                  "Filtered by Categories", Colors.orangeAccent.withOpacity(0.8)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:5,bottom: 20.0, right: 5.0 ,left: 5.0),
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
                    blurRadius: 15.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextField(
                  onChanged: (val) async {
                    await initiateSearch(val);
                    print(val.length);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "What do you need?",
                      hintStyle:
                      TextStyle(color: Colors.indigo, fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 7)
                  ),
                ),
              ),
            ),

          ),
          SizedBox(height: 10.0),
          GridView.count(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              primary: false,
              shrinkWrap: true,
              children: tempSearchStore.map((element) {
                return buildResultCard(context,element,serviceInfo.documents[0]);
              }).toList()
          )
        ]
        )
    );
  }
}

Widget buildResultCard(BuildContext context,data, DocumentSnapshot serviceInfo) {

  final serviceDoc = Service.fromElement(data);
  return GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetailPage(service: serviceDoc)));
    },
    child: Card(
//      shadowColor: Colors.grey,
//      elevation: 10.0,
        color: Color(0xFF333f8f),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          height: 50,
            child: Center(
                child: Text(data['Service_Name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                )
            )
        )
    ),
  );
}
Stack _buildWikiCategory(IconData icon, String label, Color color) {
  return Stack(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(26.0),
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
            const SizedBox(height: 16.0),
            Text(
              label,
              style: GoogleFonts.quicksand(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      )
    ],
  );
}

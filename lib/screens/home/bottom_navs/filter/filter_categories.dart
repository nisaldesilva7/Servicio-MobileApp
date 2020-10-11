import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicio/screens/home/bottom_navs/filter/filtered_list.dart';

class Filter  extends StatefulWidget {
  @override
  _FilterState  createState() => _FilterState();
}

class _FilterState  extends State<Filter> {
  TextEditingController textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.only(top:15.0,bottom: 25,left: 165),
//            child: Text("Categories".toUpperCase(), style: GoogleFonts.quicksand(color: Colors.indigoAccent,fontSize: 15),),
//          ),
          Container(
//            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 2.0,right: 2),
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(3.0),
              children: <Widget>[
                makeFilterItem("Full Service", Icons.build, Colors.indigo,'assets/image/fullservice.jpg' ),
                makeFilterItem("Oil Change", FontAwesomeIcons.oilCan, Colors.amber, 'assets/image/oil.jpg'),
                makeFilterItem("Body Painting", Icons.format_paint, Colors.orangeAccent, 'assets/image/painting.jpg'),
                makeFilterItem("Engine Checkup", FontAwesomeIcons.userCheck, Colors.blue, 'assets/image/engine.jpg'),
                makeFilterItem("Wheel Alignment", Icons.adjust, Colors.blue, 'assets/image/wheel.jpg'),
                makeFilterItem("Interior Clean", FontAwesomeIcons.car, Colors.blue, 'assets/image/interior.jpg'),
                makeFilterItem("Collision Repairs", FontAwesomeIcons.carCrash, Colors.blue, 'assets/image/collisions.jpg'),
                makeFilterItem("Body Wash", Icons.local_car_wash, Colors.blue, 'assets/image/wash.jpg'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card makeFilterItem(String title, IconData icon, Color color, String image) {
    return Card(
        elevation: 1.0,
        margin:  EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            image: DecorationImage(
              image: AssetImage(
                  image),
              fit: BoxFit.cover,
            ),

          ),
          child:  InkWell(
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => FilterList(searchType: title,),));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                      icon,
                      size: 40.0,
                      color: Colors.white,
                    )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title.toUpperCase(),
                      style: GoogleFonts.barlow(fontSize: 18.0, color: Colors.white)),
                )
              ],
            ),
          ),
        ));
  }
//  Card makeFilterItem1(String title, IconData icon) {
//    return Card(
//        elevation: 1.0,
//        margin: new EdgeInsets.all(8.0),
//        child: Container(
//          decoration: BoxDecoration(color: Color.fromRGBO(79, 190, 222, 1.0)),
//          child: new InkWell(
//            onTap: () {
//              Navigator.push(context,MaterialPageRoute(builder: (context) => FilterList(searchType:"Body Wash",),));
//            },
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              mainAxisSize: MainAxisSize.min,
//              verticalDirection: VerticalDirection.down,
//              children: <Widget>[
//                SizedBox(height: 50.0),
//                Center(
//                    child: Icon(
//                      icon,
//                      size: 40.0,
//                      color: Colors.black,
//                    )),
//                SizedBox(height: 20.0),
//                new Center(
//                  child: new Text(title,
//                      style:
//                      new TextStyle(fontSize: 18.0, color: Colors.black)),
//                )
//              ],
//            ),
//          ),
//        ));
//  }
//  Card makeFilterItem2(String title, IconData icon) {
//    return Card(
//        elevation: 1.0,
//        margin: new EdgeInsets.all(8.0),
//        child: Container(
//          decoration: BoxDecoration(color: Color.fromRGBO(245, 244, 54, 1.0)),
//          child: new InkWell(
//            onTap: () {
//              Navigator.push(context,MaterialPageRoute(builder: (context) => FilterList(searchType:"Interior Clean",),));
//            },
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              mainAxisSize: MainAxisSize.min,
//              verticalDirection: VerticalDirection.down,
//              children: <Widget>[
//                SizedBox(height: 50.0),
//                Center(
//                    child: Icon(
//                      icon,
//                      size: 40.0,
//                      color: Colors.black,
//                    )),
//                SizedBox(height: 20.0),
//                new Center(
//                  child: new Text(title,
//                      style:
//                      new TextStyle(fontSize: 18.0, color: Colors.black)),
//                )
//              ],
//            ),
//          ),
//        ));
//  }
//  Card makeFilterItem3(String title, IconData icon) {
//    return Card(
//        elevation: 1.0,
//        margin: new EdgeInsets.all(8.0),
//        child: Container(
//          decoration: BoxDecoration(color: Color.fromRGBO(243, 123, 107, 1.0)),
//          child: new InkWell(
//            onTap: () {
//              Navigator.push(context,MaterialPageRoute(builder: (context) => FilterList(searchType:"Engine Checkup",),));
//            },
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              mainAxisSize: MainAxisSize.min,
//              verticalDirection: VerticalDirection.down,
//              children: <Widget>[
//                SizedBox(height: 50.0),
//                Center(
//                    child: Icon(
//                      icon,
//                      size: 40.0,
//                      color: Colors.black,
//                    )),
//                SizedBox(height: 20.0),
//                new Center(
//                  child: new Text(title,
//                      style:
//                      new TextStyle(fontSize: 18.0, color: Colors.black)),
//                )
//              ],
//            ),
//          ),
//        )
//        );
//  }

/*await _db.collection('Services').limit(limit).where('Service_Types',
				arrayContains: string).getDocuments().then((result){
//do stuff with the result
}*/
/*var query = firestore
        .collection(path)
        .where('things', arrayContains: thingId)
        .where('serverTimestamp', isGreaterThan: lastUpdatedAt)
        .orderBy('serverTimestamp', descending: true); */
}
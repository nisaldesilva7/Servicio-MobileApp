import 'package:flutter/material.dart';
import 'package:servicio/screens/filter_list.dart';

class Filter  extends StatefulWidget {
  @override
  _FilterState  createState() => _FilterState();
}

class _FilterState  extends State<Filter> {
  TextEditingController textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SERVICIO"),
        elevation: .1,
        backgroundColor: Color.fromRGBO(16, 110, 161, 1.0),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            makeFilterItem("Full Service", Icons.build),
            makeFilterItem1("Body Wash", Icons.build),
            makeFilterItem2("Interior Clean", Icons.build),
            makeFilterItem3("Engine Checkup", Icons.build),
          ],
        ),
      ),
    );
  }

  Card makeFilterItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(114, 234, 148, 1.0)),
          child: new InkWell(
            onTap: () {
               Navigator.push(context,MaterialPageRoute(builder: (context) => FilterList(searchType:"Full Service",),
              ));
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
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
  Card makeFilterItem1(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(79, 190, 222, 1.0)),
          child: new InkWell(
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => FilterList(searchType:"Body Wash",),
              ));
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
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
  Card makeFilterItem2(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(245, 244, 54, 1.0)),
          child: new InkWell(
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => FilterList(searchType:"Interior Clean",),
              ));
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
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
  Card makeFilterItem3(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(243, 123, 107, 1.0)),
          child: new InkWell(
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => FilterList(searchType:"Engine Checkup",),
              ));
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
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
  
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
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final geo = Geoflutterfire();
  List temp = List();
  Stream<List<DocumentSnapshot>> stream;

  @override
  void initState() {
    super.initState();
    _locationFilterResults();
//    _saveLocation();
    }

    void _saveLocation(){
      GeoFirePoint myLocation = geo.point(latitude: 40.7128, longitude: 74.0060);
      Firestore.instance.
          collection('Locations')
          .add({'name': 'new york', 'position': myLocation.data});
      print("Succesfully save location");
    }

    void _locationFilterResults(){
      GeoFirePoint center = geo.point(latitude: 6.9294, longitude: 79.8542);
      var collectionReference = Firestore.instance.collection('Locations');
      double radius = 1000;
      String field = 'position';
      Stream<List<DocumentSnapshot>> stream = geo.collection(collectionRef: collectionReference)
          .within(center: center, radius: radius, field: field);

      stream.forEach((element) {print("list of $element");});
      print("STREAM $stream");

      stream.listen((List<DocumentSnapshot> documentList) {
        print(documentList.length);
        _updateMarkers(documentList);
      });
    }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    documentList.forEach((DocumentSnapshot document) {
      String name = document.data['name'];
      GeoPoint point = document.data['position']['geopoint'];
      setState(() {
        temp.add(name);

      });
//      temp.add(point);

      print(temp);
      print("Location of filtered ${point.latitude}");
      print("Location name  ${document.data['name']}");
//      _addMarker(point.latitude, point.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Locations"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
              Text(temp.toString()),
            RaisedButton(
              child: Text('Clicj'),
              onPressed: () async {
                DocumentSnapshot snapshot= await Firestore.instance.collection('Services').document('0nrI9jGS0YbRIjdKp3CtbOOLYYL2').get();
                var channelName = snapshot['City'];
                print(channelName);
              },
            )
          ],
        ),
      ),
    ) ;
  }
}
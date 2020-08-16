import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HelpAndFeedback extends StatefulWidget {
  @override
  _HelpAndFeedbackState createState() => _HelpAndFeedbackState();
}

class _HelpAndFeedbackState extends State<HelpAndFeedback> {
  List countries = [];
  List filteredCountries = [];
  bool isSearching = false;

  getCountries() async {
    var response = await Firestore.instance
        .collection('Services')
        .getDocuments();
    print('BYE${response.documents}');

   var res = response.documents;

//    var response = await Dio().get('https://restcountries.eu/rest/v2/all');
    return response.documents;
  }

  @override
  void initState() {
    getCountries().then((data) {
      setState(() {
        countries = filteredCountries = data;
        print('BYE$countries');
//        print('${countries[]["Service_Name"]}');
      });
    });
    super.initState();
  }

  void _filterCountries(value) {
    setState(() {
      filteredCountries = countries
          .where((Service_Name) =>
          Service_Name['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: !isSearching
            ? Text('All Countries')
            : TextField(
          onChanged: (value) {
            _filterCountries(value);
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: "Search Country Here",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        actions: <Widget>[
          isSearching
              ? IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                this.isSearching = false;
                filteredCountries = countries;
              });
            },
          )
              : IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                this.isSearching = true;
              });
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: filteredCountries.length > 0
            ? ListView.builder(
            itemCount: filteredCountries.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
//                  Navigator.of(context).pushNamed(Country.routeName,
//                      arguments: filteredCountries[index]);
                },
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 8),
                    child: Text(
                      filteredCountries[index]['Service_Name'],
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              );
            })
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicio/models/customer.dart';
import 'package:servicio/services/auth.dart';

import 'home/bottom_navs/image_change/customer_dp.dart';

class EditProfile extends StatefulWidget {

  @override
  MapScreenState createState() => MapScreenState();

}

class MapScreenState extends State<EditProfile>
    with SingleTickerProviderStateMixin {

  final AuthServices _auth = AuthServices();
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  int _currentIndex = 0;

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  String uid;
  String photo;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Profile", style: GoogleFonts.barlow(),),
      ),
      body: new Container(
        color: Colors.white,
        child: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FutureBuilder<Object>(
                  future: getCustomerdetailsStreamSnapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final customer = Customer.fromSnapshot(snapshot.data);
                    return new Container(
                      height: 160.0,
                      color: Colors.white,
                      child: new Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Stack(
                                fit: StackFit.loose,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          width: 140.0,
                                          height: 140.0,
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image:  DecorationImage(
                                              image:  NetworkImage(
                                                  customer.photo),
                                              fit: BoxFit.cover,),
                                          )),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerDp(customerPhoto: photo, uid: uid,)));                                },
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 90.0,right: 100.0),
                                        child: new Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            new CircleAvatar(
                                              backgroundColor: Colors.red,
                                              radius: 25.0,
                                              child: new Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                  ),
                                ]
                            ),
                          )
                        ],
                      ),
                    );
                  }
                ),
                FutureBuilder(
                  future: getCustomerdetailsStreamSnapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final customer = Customer.fromSnapshot(snapshot.data);
                      photo = customer.photo;
                      uid = customer.userId;
                      return Container(
                        color: Color(0xffFFFFFF),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0,right: 25.0,top: 25.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'User Information(Click to Edit)',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          _status
                                              ? _getEditIcon()
                                              : new Container(),
                                        ],
                                      )
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0,right: 25.0,top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Name',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0,right: 25.0,top: 2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Flexible(
                                        child: TextField(
                                          controller: controller1,
                                          decoration: InputDecoration(
                                            hoverColor: Colors.indigo,
                                            hintText: customer.name,
                                          ),
                                          enabled: !_status,
                                          autofocus: !_status,

                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0,right: 25.0,top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Mobile',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0,right: 25.0,top: 2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                       Flexible(
                                        child: TextField(
                                          controller: controller2,
                                          decoration: InputDecoration(
                                              hintText: customer.number),
                                          enabled: !_status,
                                        ),
                                      ),
                                    ],
                                  )),
                              !_status ? _getActionButtons() : new Container(),
                            ],
                          ),
                        ),
                      );
                    }
                )
              ],
            ),
          ],
        ),
      ),

//      bottomNavigationBar: BottomNavigationBar(
//        currentIndex: _currentIndex,
//        type: BottomNavigationBarType.fixed,
//        iconSize: 30,
//        backgroundColor: Colors.white,
//        items: [
//          BottomNavigationBarItem(
//              icon: Icon(Icons.home),
//              title: new Text("Home"),
//              backgroundColor: Colors.teal
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.search),
//            title: new Text("Search"),
//            backgroundColor: Colors.teal,
//            //activeIcon: Icon(Icons.accessibility),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.message),
//            title: new Text("Notifications"),
//            backgroundColor: Colors.teal,
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.offline_bolt),
//            title: new Text("Offers"),
//            backgroundColor: Colors.teal,
//          ),
//        ],
//
//        onTap: (index){
//          setState((){
//            _currentIndex =index;
//          });
//        },
//      ) ,
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child:  RaisedButton(
                    child:  Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () async {
                      String name = controller1.text.toString();
                      String tel = controller2.text.toString();
                      print('QQQQQQQ   $name, $tel');
                      final uid = await _auth.getCurrentUID();
                      Firestore.instance
                          .collection('Customers')
                          .document(uid)
                          .updateData({
                            'name': name,
                            'tel_num': tel,
                      });
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 18.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 22.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }


  Future<DocumentSnapshot> getCustomerdetailsStreamSnapshots() async {
    final uid = await _auth.getCurrentUID();
    return Firestore.instance.collection('Customers').document(uid).get();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicio/models/service.dart';
import 'package:servicio/services/auth.dart';

class Complaint extends StatefulWidget {
  final Service service;
  Complaint({Key key, this.service}) : super(key: key);

  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {

  final db = Firestore.instance;

  final AuthServices _auth = AuthServices();


  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = '';

  String _complaint = '';
  bool _isSolved = false ;
  DateTime _dateOfComplaint = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints'),
      ) ,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipper2(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.indigo[200], Colors.indigo[200]])),
                ),
              ),
              ClipPath(
                clipper: WaveClipper3(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.indigo[300], Colors.indigo[300]])),
                ),
              ),
              ClipPath(
                clipper: WaveClipper1(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 40,),
                      Icon(CupertinoIcons.info, color: Colors.white, size: 60,),
                      SizedBox(height: 20,),
                      Text(
                        "Add Complaint for \n${widget.service.serviceName}".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.indigo[700], Colors.indigo[400]])),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 35.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Please enter your complaint below'.toUpperCase(), style: GoogleFonts.alice(
                      color: Colors.grey
                  )),
                  SizedBox(height: 15.0, width:15.0),
                  _buildComplaint(),
                  SizedBox(height: 15.0),
//                  _builSolvedState(),
                  SizedBox(height: 15.0),
//                  _buildDate(),
                  SizedBox(height: 20.0),

                  RaisedButton(
                    padding: const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                    color: Colors.indigo,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), bottomRight: Radius.circular(30.0))),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        final uid = await _auth.getCurrentUID();
                        db.collection('Complains')
                            .add(
                            {
                              'complain': _complaint,
                              'date' : _dateOfComplaint,
                              'is_resolved': _isSolved,
                              'user_id': uid,
                              'service_id': widget.service.serviceId,
                            }
                        );
//                          await _showMyDialog();
                        Navigator.pop(context);
                      }
                      else{
                        _customAlertDialog(context, 'Please enter your complaint'.toUpperCase());
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("Send".toUpperCase(), style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),),
                        const SizedBox(width: 40.0),
                        Icon(FontAwesomeIcons.arrowRight, size: 18.0, color: Colors.white,)
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                      error,
                      style: TextStyle(
                        color: Colors.black,
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplaint() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Complaint', icon: Icon(Icons.airport_shuttle, color: Colors.indigo,),),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Message is Required';
        }
        return null;
      },
      onChanged: (value) {
        setState(() => _complaint = value);
      },
    );
  }

//  Widget _builSolvedState() {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.start,
//      children: <Widget>[
//        Icon(FontAwesomeIcons.checkSquare, size: 25.0, color: Colors.indigo,),
//        SizedBox(width: 20),
//        DropdownButton(
//          items: solvedState.map((value) => DropdownMenuItem(
//            child: Text(
//              value,
//              style: TextStyle(color: Colors.indigo),
//            ),
//            value: value,
//          )
//          ).toList(),
//          onChanged: (selectedServiceType) {
//            print('$selectedServiceType');
//            setState(() {
//              selectedType = selectedServiceType;
//            });
//          },
//          value: selectedType,
//          isExpanded: false,
//          hint: Text('Choose your state',
//            style: TextStyle(color: Colors.indigo),
//          ),
//        )
//      ],
//    );
//  }
//  Widget _buildDate() {
//    return TextFormField(
//      decoration: InputDecoration(labelText: 'Date', icon: Icon(Icons.airport_shuttle, color: Colors.indigo,),),
//      validator: (date value) {
//        if (value.isEmpty) {
//          return 'Enter your date';
//        }
//        return null;
//      },
//      onChanged: (value) {
//        setState(() => _complaint = value);
//      },
//    );
//  }

  _customAlertDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Material(
              type: MaterialType.transparency,
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Icon(
                        Icons.warning,
                        color: Colors.red,
                        size: 50,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'WARNING',
                        style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Divider(),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15.0),
                      ),
                      Divider(),
                      SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('OK'),
                          onPressed: () => Navigator.pop(context, true),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }



}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 100);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}



class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
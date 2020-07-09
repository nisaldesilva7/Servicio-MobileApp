import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//      child: Text(widget.serviceInfo['ratings']),
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:servicio/screens/bookings/select_date_time/notifcation_dialog.dart';
import 'package:servicio/screens/home/bottom_navs/main_view.dart';
import 'package:servicio/screens/home/home.dart';
import 'package:servicio/services/auth.dart';

class BookService extends StatefulWidget {

  final DocumentSnapshot serviceInfo;
  const BookService({Key key, this.serviceInfo}) : super(key: key);

  @override
  _BookServiceState createState() => _BookServiceState();
}

class _BookServiceState extends State<BookService> {

  final db = Firestore.instance;
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();




  String _serviceType = '';
  String _vehicleType = '';
  String _dateandtime = '';


  bool loading = false;
  String error = '';


  DateTime selectedDate = DateTime.now();
  final DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80.0),
            Stack(
              children: <Widget>[
                Positioned(
                  left: 20.0,
                  top: 15.0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(20.0)),
                    width: 70.0,
                    height: 20.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    "BOOKING FORM",
                    style:
                    TextStyle(color: Colors.grey[700],fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    _buildName(),
                    SizedBox(height: 15.0),
                    _datetime(),
//                    _buildEmail(),
                    SizedBox(height: 15.0),
                    _buildVehicleType(),
                    SizedBox(height: 15.0),
//                    _buildRePassword(),
                    SizedBox(height: 15.0),
                    //_buildURL(),
//                    _buildPhoneNumber(),
                    SizedBox(height: 20.0),
                    //_buildCalories(),

                    Text(error, style: TextStyle(color: Colors.black,)),
                    const SizedBox(height: 60.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        padding: const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                        color: Colors.indigo,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), bottomLeft: Radius.circular(30.0))),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            final uid = await _auth.getCurrentUID();
                            db.collection('Bookings').add(
                                {
                                  'ServiceType': _serviceType,
                                  'VehicleType': _vehicleType,
                                  'Date': _dateandtime,
                                  'EndDate': _dateandtime,
                                  'CustName': 'Nisal',
                                  'CustId': uid,
                                }
                            );
                            await _showMyDialog();
                            Navigator.pop(context);
                          }

                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Book".toUpperCase(),
                              style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                            const SizedBox(width: 40.0),
                            Icon(FontAwesomeIcons.arrowRight, size: 18.0,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Service Type', icon: Icon(Icons.person, color: Colors.white,),),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }
        if (value.length < 4) {
          return 'Name is too short';
        }
        return null;
      },
      onChanged: (value) {
        setState(() => _serviceType = value);
      },
    );
  }

  Widget _buildVehicleType() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Vehicle Type', icon: Icon(Icons.person, color: Colors.white,),),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }
        return null;
      },
      onChanged: (value) {
        setState(() => _vehicleType = value);
      },
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('BOOKING DONE!'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  Widget _datetime() {
    return Column(
        children: <Widget>[
          RaisedButton(
          color: Colors.indigo,
          child: Text('Choose date & time for the Booking',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            showDateTimeDialog(context, initialDate: selectedDate,
                onSelectedDate: (selectedDate) {
                  setState(() {
                    this.selectedDate = selectedDate;
                  });
                  print(dateFormat.format(selectedDate));
                  _dateandtime = dateFormat.format(selectedDate);
                });
          },
           ),
          Text(dateFormat.format(selectedDate),
            style: TextStyle(fontSize: 15, color: Colors.black54),

          ),
        ],
      );
  }



}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//      child: Text(widget.serviceInfo['ratings']),
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:servicio/models/service.dart';
import 'package:servicio/screens/bookings/select_date_time/notifcation_dialog.dart';
import 'package:servicio/screens/bookings/view_service_schedule.dart';
import 'package:servicio/services/auth.dart';

class BookService extends StatefulWidget {

  final Service serviceInfo;
  const BookService({Key key, this.serviceInfo}) : super(key: key);

  @override
  _BookServiceState createState() => _BookServiceState();
}

class _BookServiceState extends State<BookService> {

  final db = Firestore.instance;
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  String _serviceType ;
  String _description ;
  String _dateandtime  ;
  var selectedVehicle,selectedType;

  bool loading = false;
  String error = '';

  List<String> _serviceTypes = <String>[
    'AC Repair',
    'Full Service',
    'Body Wash',
    'Repair'
  ];

  DateTime selectedDate = DateTime.now();
  DateTime _nisalwanttime = DateTime.now();
  final DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
  final DateFormat ShowDateTime = DateFormat('  kk:mm:ss\nEEE d MMM');

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      _buildServiceType(),
                      SizedBox(height: 15.0),
                      _vehicle(),
                      SizedBox(height: 15.0),
                      _datetime(),
                      SizedBox(height: 15.0),
                      _buildName(),
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
                            if (_formKey.currentState.validate() && selectedVehicle != null && selectedType != null) {
                              if (_dateandtime != null) {
                                final uid = await _auth.getCurrentUID();
                                db.collection('Services')
                                    .document('${widget.serviceInfo.serviceId}')
                                    .collection('Bookings')
                                    .add(
                                    {
                                      'ServiceType': selectedType,
                                      'BookingStatus': 'Pending',
                                      'Date': _dateandtime,
                                      'EndDate': _dateandtime,
                                      'CustName': 'Nisal',
                                      'CustId': uid,
                                      'ServiceId': widget.serviceInfo.serviceId,
                                      'Vehicle': selectedVehicle,
                                      'Description': _description,
                                      'DateTime': _nisalwanttime,

                                    }
                                )
                                    .then((docRef) {
                                  var temp = docRef.documentID;
                                  print('hello ${docRef.documentID}');
                                  db.collection('Customers').document('$uid')
                                      .collection('Bookings').document('$temp')
                                      .setData(
                                      {
                                        'ServiceType': selectedType,
                                        'BookingStatus': 'Pending',
                                        'Date': _dateandtime,
                                        'EndDate': _dateandtime,
                                        'CustName': 'Nisal',
                                        'CustId': uid,
                                        'ServiceId': widget.serviceInfo
                                            .serviceId,
                                        'Vehicle': selectedVehicle,
                                        'Description': _description,
                                      }
                                  );
                                }
                                );
                                await _showMyDialog();
                                Navigator.pop(context);
                              }
                              else{
                                _customAlertDialog(context, 'Please Select Date And Time for the Booking'.toUpperCase());

                              }
                            }
                            else{
                              _customAlertDialog(context, 'Please Select a Vehicle and Service Type'.toUpperCase());
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Book".toUpperCase(), style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),),
                              const SizedBox(width: 40.0),
                              Icon(FontAwesomeIcons.arrowRight, size: 18.0, color: Colors.white,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
    return Padding(
      padding: const EdgeInsets.only(right: 25.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: 2,
        decoration: InputDecoration(labelText: 'Description', icon: Icon(Icons.description, color: Colors.indigo,),),
        validator: (String value) {
          return null;
        },
        onChanged: (value) {
          setState(() => _description = value);
        },
      ),
    );
  }

  Widget _buildServiceType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(FontAwesomeIcons.checkSquare, size: 25.0, color: Colors.indigo,),
        SizedBox(width: 50.0),
        DropdownButton(
          items: widget.serviceInfo.serviceTypes.map((value) => DropdownMenuItem(
            child: Text(
              value,
              style: TextStyle(color: Colors.indigo),
            ),
            value: value,
          )
          ).toList(),
          onChanged: (selectedServiceType) {
            print('$selectedServiceType');
            setState(() {
              selectedType = selectedServiceType;
            });
          },
          value: selectedType,
          isExpanded: false,
          hint: Text('Choose Service Type',
            style: TextStyle(color: Colors.indigo),
          ),
        )
      ],
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: Text('BOOKING DONE!',style: TextStyle(color: Colors.indigo),),
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


  Widget _datetime() {
    return Column(
        children: <Widget>[
          RaisedButton(
          color: Colors.indigo,
          child: Text('Choose date & time ',
            style: TextStyle(color: Colors.white, fontFamily: 'cabin'),
          ),
          onPressed: () async {
            showDateTimeDialog(context, initialDate: selectedDate,
                onSelectedDate: (selectedDate) {
                  setState(() {
                    this.selectedDate = selectedDate;
                    print(this.selectedDate);
                  });
                  print(dateFormat.format(selectedDate));
                  _dateandtime = dateFormat.format(selectedDate);
                  _nisalwanttime = selectedDate;
                });
          },
           ),
          _dateandtime != null ? Text('Selected Date and Time',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15 , color: Colors.grey[800]),
          ): Container(),

          _dateandtime != null ? Text('${ShowDateTime.format(selectedDate)}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, color: Colors.grey[800], fontWeight: FontWeight.w800),
          ): Container(),

        ],
      );
  }

Widget _vehicle(){
  return StreamBuilder<QuerySnapshot>(
      stream: getUsersVehiclesStreamSnapshots(context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading.....");
        }
        else {
          List<DropdownMenuItem> currencyItems = [];
          for (int i = 0; i < snapshot.data.documents.length; i++) {
            DocumentSnapshot snap = snapshot.data.documents[i];
            currencyItems.add(
              DropdownMenuItem(
                child: Text(
                  snap.data['brand'],
                  style: TextStyle(color: Colors.indigo),
                ),
                value: "${snap.documentID}",
              ),
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(FontAwesomeIcons.car, size: 25.0, color: Colors.indigo),
              SizedBox(width: 50.0),
              DropdownButton(
                items: currencyItems,
                onChanged: (currencyValue) {
                  final snackBar = SnackBar(
                    content: Text('Selected Vehicle is $currencyValue',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                  setState(() {
                    selectedVehicle = currencyValue;
                  });
                },
                value: selectedVehicle,
                isExpanded: false,
                hint: new Text("Choose Your Vehicle", style: TextStyle(color: Colors.indigo),),
              ),
            ],
          );
        }
      }
  );
}
  Container _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 32.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        color: Colors.blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              widget.serviceInfo.serviceName.toUpperCase(),
              style:TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: FloatingActionButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceSchedule()));
              },
              tooltip: 'View Schedule',
              child: Icon(Icons.calendar_today),
            )
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "cccccccccccccccc",
              style:TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "kkkkkkkkkkkkkk",
              style: TextStyle(color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
  Stream<QuerySnapshot> getUsersVehiclesStreamSnapshots(BuildContext context) async* {
    final uid = await _auth.getCurrentUID();
    yield* Firestore.instance.collection('Customers').document(uid).collection('Vehicles').snapshots();
  }

}

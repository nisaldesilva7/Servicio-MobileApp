import 'package:flutter/material.dart';
import 'package:servicio/models/vehicle.dart';


class VehiclePage extends StatefulWidget {
  final Vehicle serviceInfo;
  const VehiclePage({Key key, this.serviceInfo}) : super(key: key);

  @override
  _VehiclePageState createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> with SingleTickerProviderStateMixin{

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.transparent,
//        elevation: 0,
//      ),
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(left: 15.0),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    color: Color(0xFFEEB139),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
//              SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    widget.serviceInfo.brand,
                    style: TextStyle(
                        color: Color(0xFF434C68).withOpacity(0.7),
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cabin',
                        letterSpacing: 0.05
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Image.asset('assets/image/3.jpg',
                    fit: BoxFit.cover,
                    height: 175.0,
                    width: MediaQuery.of(context).size.width - 30.0
                ),
                Text(widget.serviceInfo.model.toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'Cabin',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(widget.serviceInfo.year,
                  style: TextStyle(fontFamily: 'Cabin', fontSize: 14.0, fontWeight: FontWeight.bold, color: Color(0xFF434C68)),
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 0.75,
                  width: MediaQuery.of(context).size.width - 30.0,
                  color: Color(0xFF434C68).withOpacity(0.4),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(Icons.shutter_speed, color: Color(0xFF434C68).withOpacity(0.4)),
                          SizedBox(height: 5.0),
                          Text('1000KMs',
                            style: TextStyle(fontFamily: 'Cabin', fontSize: 20.0, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        children: <Widget>[
                          Icon(Icons.timer, color: Color(0xFF434C68).withOpacity(0.4)),
                          SizedBox(height: 5.0),
                          Text('3.2',
                            style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                          )

                        ],
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        children: <Widget>[
                          Icon(Icons.network_cell, color: Color(0xFF434C68).withOpacity(0.4)),
                          SizedBox(height: 5.0),
                          Text('443',
                            style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                          )

                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 0.75,
                  width: MediaQuery.of(context).size.width - 30.0,
                  color: Color(0xFF434C68).withOpacity(0.4),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Icon(Icons.view_headline, size: 35.0, color: Color(0xFF434C68).withOpacity(0.4)),
                    SizedBox(width: 70.0),
                    Text('Repairs & Services'.toUpperCase(),
                      style: TextStyle(
                          color: Color(0xFF434C68).withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          fontFamily: 'Oswald'
                      ),),
                    SizedBox(width: 80.0),
                  ],
                ),
                Center(child: Text("list view for service history of \n${widget.serviceInfo.vehicleId}"))
              ],
            )
          ],
        ),
      ),
    );
  }
}

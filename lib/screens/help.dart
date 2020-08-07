import 'package:flutter/material.dart';
import 'package:servicio/services/urlService.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:servicio/services/service_locator.dart';

class HelpAndFeedback extends StatefulWidget{

  final String title;

  HelpAndFeedback(this.title);

  @override
  _HelpAndFeedbackState createState() => _HelpAndFeedbackState();
}

class _HelpAndFeedbackState extends State<HelpAndFeedback> {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

  final String number = "123456789";
  final String email = "dancamdev@example.com";

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Help & Feedback"),
      ),
      body: Column(
        children: <Widget>[
          new Center(
            child: new Text(widget.title),
          ),
          RaisedButton(
            child: Text(
              "call $number",
            ),
            onPressed: () => _service.sendEmail(email),
          ),
        ],
      ),

    );
  }
}
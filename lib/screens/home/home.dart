import 'package:flutter/material.dart';
import 'package:servicio/services/auth.dart';

class Home extends StatelessWidget {

  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Servicio HOMEPAGE'),
        backgroundColor: Colors.blue[600],
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.call_missed_outgoing),
              label: Text(
                  'LOGOUT',
                  style: TextStyle(
                    color: Colors.grey[100],

                  ),
              ),
          )
        ],
      ),
    );
  }
}

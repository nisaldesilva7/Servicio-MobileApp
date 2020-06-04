import 'package:flutter/material.dart';
import 'package:servicio/services/auth.dart';


class ForgotPassword extends StatefulWidget {

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  
  final AuthServices _auth = AuthServices();
  String _email = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Forgot Password'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.grey[300],
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          children: <Widget>[

            Form(
                key: _formKey,
                child: _buildEmail(),
            ),
            SizedBox(height: 30.0),
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
              color: Colors.blue[600],
              child: Text(
                'Send Verfication Email',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _auth.forgotPassword(_email);
              },

            ),
            SizedBox(height: 20.0,),
            Row(
              children: <Widget>[
                Text('Go back to SIGN IN page'),

              ],
            )


          ],
        ),
      ),
    );
  }


  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email', icon: Icon(Icons.mail, color: Colors.white,),),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }
        if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }
        return null;
      },
      onChanged: (val) {
        setState(() => _email = val);
      },
    );
  }
}

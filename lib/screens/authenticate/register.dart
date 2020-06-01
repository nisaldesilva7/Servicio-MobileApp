import 'package:flutter/material.dart';
import 'package:servicio/services/auth.dart';
import 'package:servicio/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _repassword = '';
  String _name = '';
  String _url;
  String _phoneNumber;
  String _calories;

  bool loading = false;
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        backgroundColor: Colors.blue[800],
        title: Text('Sign Up to Servicio'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.people, color: Colors.white,),
            label: Text(
                'SIGN IN',
                style: TextStyle(
                  color: Colors.white,
                ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 35.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0),
                _buildName(),
                SizedBox(height: 15.0),
                _buildEmail(),
                SizedBox(height: 15.0),
                _buildPassword(),
                SizedBox(height: 15.0),
                _buildRePassword(),
                SizedBox(height: 15.0),
                //_buildURL(),
                _buildPhoneNumber(),
                SizedBox(height: 20.0),
                //_buildCalories(),

                RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                  color: Colors.blue[600],
                  child: Text(
                    'SIGN-UP',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmail(_email, _password, _name, _phoneNumber);
                      if (result == null){
                        setState(() {
                          error = 'Enter Valid Email';
                          loading = false;
                        });
                      }
                    }
                  },
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
      ),
    );
  }


  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name', icon: Icon(Icons.person, color: Colors.white,),),
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
        setState(() => _name = value);
      },
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

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password', icon: Icon(Icons.lock, color: Colors.white,),),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required';
        }
        if(value.length < 6) {
          return 'Password should be length more than 6 chars';
        }
        return null;
      },
      onChanged: (value) {
        setState(() => _password = value);
      },
    );
  }

  Widget _buildRePassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Re-enter Password', icon: Icon(Icons.lock, color: Colors.white,),),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: (String value) {
        if (value != _password) {
          return 'Password does not match';
        }
        return null;
      },
      onChanged: (val) {
        setState(() => _repassword = val);
      },
    );
  }

  Widget _buildURL() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Url'),
      keyboardType: TextInputType.url,
      validator: (String value) {
        if (value.isEmpty) {
          return 'URL is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _url = value;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone number' , icon: Icon(Icons.phone, color: Colors.white,),),
      keyboardType: TextInputType.phone,
      validator: (String value) {
//        setState(() {});
        if (value.isEmpty) {
          return 'Phone number is Required';
        }
        if (value.length != 10) {
          return 'Enter valid number';
        }
        return null;
      },
      onChanged: (value) {
        setState(() => _phoneNumber = value);
      },
    );
  }

  Widget _buildCalories() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Calories'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int calories = int.tryParse(value);

        if (calories == null || calories <= 0) {
          return 'Calories must be greater than 0';
        }

        return null;
      },
      onSaved: (String value) {
        _calories = value;
      },
    );
  }



}

//
//Form(
//key: _formKey,
//child: Column(
//children: <Widget>[
//SizedBox(height: 20.0),
//TextFormField(
//decoration: InputDecoration(
//hintText: 'Email',
//fillColor: Colors.white,
//filled: true,
//),
//validator: (val) => val.isEmpty ? 'Enter an Email' : null,
//onChanged: (val) {
//setState(() => email = val);
//},
//),
//SizedBox(height: 20.0),
//TextFormField(
//decoration: InputDecoration(
//hintText: 'Password',
//fillColor: Colors.white,
//filled: true,
//),
//obscureText: true,
//validator: (val) => val.length < 6 ? 'Passowrd should be length more thana 6 chars' : null,
//onChanged: (val) {
//setState(() => password = val);
//},
//),
//SizedBox(height: 20.0),
//RaisedButton(
//color: Colors.blue[600],
//child: Text(
//'SIGN-UP',
//style: TextStyle(color: Colors.white),
//),
//onPressed: () async {
//if (_formKey.currentState.validate()) {
//setState(() => loading = true);
//dynamic result = await _auth.registerWithEmail(email, password);
//if (result == null){
//setState(() {
//error = 'Enter Valid Email';
//loading = false;
//});
//}
//}
//},
//),
//SizedBox(height: 20.0),
//Text(
//error,
//style: TextStyle(
//color: Colors.black,
//)
//),
//],
//),
//),
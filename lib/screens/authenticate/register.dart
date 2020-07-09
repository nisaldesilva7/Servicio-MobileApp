import 'package:flutter/cupertino.dart';
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.people, color: Colors.white,),
            label: Text('SIGN IN', style: TextStyle(color: Colors.white,),),
          )
        ],
      ),

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
                      Icon(CupertinoIcons.car, color: Colors.white, size: 60,),
                      SizedBox(height: 20,),
                      Text(
                        "Register with Servicio",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 30),
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
      ],
      ),
    );
  }


  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name', icon: Icon(Icons.person, color: Colors.indigo,),),
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
      decoration: InputDecoration(
        labelText: 'Email',
        icon: Icon(Icons.mail, color: Colors.indigo,),
      ),
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
      decoration: InputDecoration(labelText: 'Password', icon: Icon(Icons.lock, color: Colors.indigo,),),
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
      decoration: InputDecoration(labelText: 'Re-enter Password', icon: Icon(Icons.lock, color: Colors.indigo,),),
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
      decoration: InputDecoration(labelText: 'Phone number' , icon: Icon(Icons.phone, color: Colors.indigo,),),
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

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

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
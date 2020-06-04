import 'package:flutter/material.dart';
import './dep/animations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[600],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: FadeAnimation(
                      1,
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/image/1.png"),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                  1,
                  Text(
                    "WELOCOME TO SERVICIO",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                FadeAnimation(
                  1,
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                          onChanged: (val) {
//                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (val) => val.length < 6 ? 'Passowrd should be length more thana 6 chars' : null,
                          obscureText: true,
                          onChanged: (val) {
//                            setState(() => password = val);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Center(
                  child: FadeAnimation(
                    1,
                      FlatButton(
                        onPressed: () {
                          /*...*/
                        },
                        child: Text(
                          "Forget Password",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ),
                ),
                SizedBox(height: 10.0),
                FadeAnimation(
                  1,
                  ButtonTheme(
                    minWidth: 150.0,
                    height: 40.0,
                    child: Center(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        color: Colors.blue[900],
                        child: Text('Sign in',
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                        onPressed: () {},
//                        sign in function
//                        async {
//                          if (_formKey.currentState.validate()) {
//                            setState(() => loading = true);
//                            dynamic result = await _auth.signInWithEmail(email, password);
//                            if (result == null){
//                              setState(() {
//                                error = 'Could not Sign In';
//                                loading = false;
//                              });
//                            }
//                          }
//                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
//error for sign in
//                Text(
//                    error,
//                    style: TextStyle(
//                      color: Colors.black,
//                    )
//                ),
                FadeAnimation(
                  1,
                  Center(
                    child: FlatButton(
                      onPressed: () {
//                        toggle between sign up and sign in
//                        widget.toggleView();
                        },
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}



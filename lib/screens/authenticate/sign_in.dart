import 'package:flutter/material.dart';
import 'package:servicio/services/auth.dart';
import 'package:servicio/shared/loading.dart';
import 'package:servicio/testing/dep/animations.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    return loading ? Loading()  : Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[700],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: FadeAnimation(1,
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/image/2.png"),
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
                SizedBox(height: 15.0),
                FadeAnimation(
                  1,
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.transparent,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              //hintText: 'Email',
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              //hintText: 'Password',
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            validator: (val) => val.isEmpty ? 'Enter the password' : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                Center(
                  child: FadeAnimation(
                    1,
                    FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/forgotPassword");
                      },
                      child: Text("Forgot Password", style: TextStyle(color: Colors.white,),),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                FadeAnimation(1,
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 50.0,
                    child: Center(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                        color: Colors.blue[900],
                        child: Text('SIGN IN',
                          style: TextStyle(color: Colors.white, fontSize: 17.0, letterSpacing: 2.0),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            print("ok");
                            setState(() => loading = true);
                            dynamic result = await _auth.signInWithEmail(email, password);
                            if (result == null){
                              setState(() {
                                error = 'Could not Sign In';
                                print(error);
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                FadeAnimation(2,
                   Center(
                    child: Text(
                        error,
                        style: TextStyle(
                          color: Colors.white,
                        )
                    ),
                  ),
                ),
                SizedBox(height: 35.0),
                FadeAnimation(1,
                  Center(
                    child: FlatButton(
                      onPressed: () {
                      //toggle between sign up and sign in
                        widget.toggleView();
                      },
                      child: Text("Create My Account",
                        style: TextStyle(
                          fontSize: 15.0,
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

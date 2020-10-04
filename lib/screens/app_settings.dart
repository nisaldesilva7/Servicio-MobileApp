import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicio/screens/myprofile.dart';
import 'package:servicio/shared/SliderImages.dart';
import 'package:servicio/services/auth.dart';

class AppSettings extends StatefulWidget {
  static final String path = "lib/src/pages/settings/settings1.dart";

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  bool _dark;
  final AuthServices _auth = AuthServices();

  @override
  void initState() {
    super.initState();
    _dark = true;
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        backgroundColor: _dark ? null : Colors.grey[100],
        appBar: AppBar(
          elevation: 0,
          brightness: _getBrightness(),
          iconTheme: IconThemeData(color: _dark ? Colors.white : Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(color: _dark ? Colors.white : Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.moon),
              onPressed: () {
                setState(() {
                  _dark = !_dark;
                });
              },
            )
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.indigo,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                      },
                      title: Text(
                        "Edit My profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
//                      leading: CircleAvatar(
//                        backgroundImage: CachedNetworkImageProvider(avatars[0]),
//                      ),
                      trailing: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.lock_outline,
                            color: Colors.purple,
                          ),
                          title: Text("Change Password"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            _changePasswordDialog(context);                       },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.delete,
                            color: Colors.indigo,
                          ),
                          title: Text("Delete Account"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            _auth.deleteUser();
                           },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.mail_outline,
                            color: Colors.indigo,
                          ),
                          title: Text("Send Verfication mail"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            _auth.sendVerificationMail();
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Notification Settings",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  SwitchListTile(
                    activeColor: Colors.indigo,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text("Received notification"),
                    onChanged: (val) {},
                  ),
                  SwitchListTile(
                    activeColor: Colors.indigo,
                    contentPadding: const EdgeInsets.all(0),
                    value: false,
                    title: Text("Received newsletter"),
                    onChanged: null,
                  ),
                  SwitchListTile(
                    activeColor: Colors.indigo,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text("Received Offer Notification"),
                    onChanged: (val) {},
                  ),
                  SwitchListTile(
                    activeColor: Colors.indigo,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text("Received App Updates"),
                    onChanged: null,
                  ),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
//            Positioned(
//              bottom: -20,
//              left: -20,
//              child: Container(
//                width: 80,
//                height: 80,
//                alignment: Alignment.center,
//                decoration: BoxDecoration(
//                  color: Colors.indigo,
//                  shape: BoxShape.circle,
//                ),
//              ),
//            ),
//            Positioned(
//              bottom: 00,
//              left: 00,
//              child: IconButton(
//                icon: Icon(
//                  FontAwesomeIcons.powerOff,
//                  color: Colors.white,
//                ),
//                onPressed: () {
//                  //log out
//                },
//              ),
//            )
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }

  Future _changePasswordDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AlertDialog(
            title: Text('Enter your Email to Verify and revice password change Email', style: GoogleFonts.poppins(color: Colors.indigo,fontSize: 15),),
            content: TextField(
              controller: controller,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                onPressed: () async {
                  await _auth.changePassword(controller.text.toString());
                  Navigator.of(context).pop();
                },
                child: Text('Change Password', style: GoogleFonts.poppins(color: Colors.indigo,fontSize: 15),),

              )
            ],
          ),
        );
      },
    );
  }
}

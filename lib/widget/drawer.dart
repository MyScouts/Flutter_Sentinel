import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Drawer buildDrawer(context, userName) {
  return new Drawer(
      child: SafeArea(
          child: Column(children: <Widget>[
    Padding(padding: EdgeInsets.only(top: 21.5)),
    Image.asset('images/logo_black.png'),
    Padding(padding: EdgeInsets.only(top: 6.4)),
    Text('Version 0.0.3',
        style: GoogleFonts.roboto(fontSize: 13.0, color: Color(0xffACB1C0))),
    Expanded(
        child: Container(
            margin: EdgeInsets.only(left: 24.0),
            padding: EdgeInsets.only(top: 29.5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Logged in as',
                      style: GoogleFonts.openSans(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                  Text(userName ?? 'No Account',
                      style: GoogleFonts.openSans(fontSize: 17)),
                  GestureDetector(
                      onTap: () => logOut(context),
                      child: Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(top: 650.0),
                          child: Text('Sign out',
                              style: GoogleFonts.openSans(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))))
                ])))
  ])));
}

logOut(BuildContext context) async {
  SharedPreferences dataLogin;
  dataLogin = await SharedPreferences.getInstance();
  await dataLogin.clear();
  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
}

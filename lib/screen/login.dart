import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<LoginPage> {
  SharedPreferences loginApp;
  bool userLogin;

  @override
  void initState() {
    super.initState();
    checkOnLoginApp();
  }

  String emailApp = 'admin@gmail.com';
  String passWordApp = 'admin123';
  String email;
  String passWord;

//
  String _errEmail = 'Tên đăng nhập không hợp lệ!';
  String _errPass = 'Mật khẩu không hợp lệ!';

//
  bool _chkEmail = false;
  bool _chkPass = false;

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return Scaffold(
        backgroundColor: Color(0xff003CA2),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(top: 124.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff002057), Color(0xff003CA2)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Column(children: <Widget>[
                  Image.asset('images/logo.png'),
                  Container(
                      padding:
                          EdgeInsets.only(top: 36.0, right: 30.0, left: 30.0),
                      margin:
                          EdgeInsets.only(top: 103.0, right: 20.0, left: 20.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          color: Colors.white),
                      child: Column(children: <Widget>[
                        Text('Welcome back',
                            style: GoogleFonts.openSans(
                                fontSize: 34.0, fontWeight: FontWeight.bold)),
                        Text('Login your account',
                            style: GoogleFonts.roboto(
                                fontSize: 17.0, color: Color(0xffACB1C0))),
                        Container(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Column(children: <Widget>[
                              TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Email',
                                      errorText:
                                          _chkEmail == true ? _errEmail : null,
                                      hintStyle: GoogleFonts.roboto(
                                          fontSize: 17.0,
                                          color: Color(0xffACB1C0)),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffF1F2F6)),
                                          borderRadius:
                                              BorderRadius.circular(6.0)),
                                      filled: true),
                                  onChanged: (text) => email = text),
                              Padding(padding: EdgeInsets.only(top: 10.0)),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    errorText:
                                        _chkPass == true ? _errPass : null,
                                    hintStyle: GoogleFonts.roboto(
                                        fontSize: 17.0,
                                        color: Color(0xffACB1C0)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffF1F2F6)),
                                        borderRadius:
                                            BorderRadius.circular(6.0)),
                                    filled: true),
                                onChanged: (text) => passWord = text,
                              )
                            ])),
                        Padding(padding: EdgeInsets.only(top: 40.0)),
                        SizedBox(
                            width: double.infinity,
                            child: FlatButton(
                                onPressed: checkLogin,
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.0),
                                    child: Text('Sign in',
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Colors.white))),
                                textColor: Colors.white,
                                color: Color((0xff007AFF)))),
                        Container(
                            padding: EdgeInsets.only(top: 47.0, bottom: 26.0),
                            child: Text('Forgot your password?',
                                style: GoogleFonts.roboto(fontSize: 17.0)))
                      ]))
                ]))));
  }

  void checkLogin() => setState(() {
        if (email.length < 6 ||
            !email.contains('@gmail.com') ||
            email.toLowerCase() != emailApp)
          _chkEmail = true;
        else
          _chkEmail = false;
        if (passWord.length < 6 || passWord != passWordApp)
          _chkPass = true;
        else
          _chkPass = false;

        if (_chkPass == false && _chkEmail == false) {
          loginApp.setBool('data_login', false);
          loginApp.setString('email', email);
          Navigator.pushReplacementNamed(context, '/home');
        }
      });

  void checkOnLoginApp() async {
    loginApp = await SharedPreferences.getInstance();
    userLogin = (loginApp.getBool('data_login') ?? true);
    print(userLogin);
    if (userLogin == false) Navigator.pushReplacementNamed(context, '/home');
  }
}

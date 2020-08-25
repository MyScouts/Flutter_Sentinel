import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class StyleApp {
  Color colorBlue = Color(0xff007AFF);
  Color colorWhite = Colors.white;
  Color colorBlack = Colors.black;

  Color appBarCorlor = Color(0xffF7F8FA);
  Color hintText = Color(0xff707070);
  Color colorBrown = Color(0xffACB1C0);
  Color colorRed = Color(0xffFF2D55);

//  AppBar
  Widget textTitle(text, color) => Text(text.toString(),
      style: GoogleFonts.roboto(
          fontSize: 17.0, color: color, fontWeight: FontWeight.bold));

  Icon iconBack(color) => Icon(Icons.arrow_back_ios, color: color);

//  End Appbar
  TextStyle styleNameHead =
      GoogleFonts.openSans(fontSize: 17.0, fontWeight: FontWeight.bold);
  TextStyle listNameHead = TextStyle();
  TextStyle updatedStyle =
      GoogleFonts.openSans(fontSize: 13.0, color: Color(0xffACB1C0));

  TextStyle countStyle(color) => GoogleFonts.openSans(
      fontSize: 12.0, fontWeight: FontWeight.bold, color: color);

  ClipRRect imageSmaill(imagePath) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: imagePath != null
            ? Image.file(File(imagePath),
                width: 66.0, height: 66.0, fit: BoxFit.fill)
            : Image.asset('images/img_product.png'));
  }

//

//    TextFeild Style
  TextStyle textInput = TextStyle(color: Color(0xffACB1C0), fontSize: 13.0);
  BorderSide borderside = BorderSide(width: 1.0, color: Color(0xffEAECEF));

  TextStyle lableTextName() => TextStyle(fontSize: 13.0, color: hintText);

  TextStyle hintTextName() => TextStyle(fontSize: 17.0, color: hintText);

//End TextFeidStyle

//Button Stylye
  Widget buttonText(buttonText) => Text(buttonText,
      style: GoogleFonts.openSans(fontSize: 14.0, color: colorWhite));

//End Button Style

//Head Page
  Image imgHead(imgPath) => imgPath != null
      ? Image(
          image: FileImage(File(imgPath)),
          width: double.infinity,
          fit: BoxFit.fill,
          height: 289.0)
      : Image.asset('images/product_detail.png',
          width: double.infinity, fit: BoxFit.fill);
  var formatter = new DateFormat('E, MMM dd, hh-mm-ss');

  Widget dateHead(updated) =>
      Text("Updated: ${formatter.format(updated).toUpperCase()}",
          style: GoogleFonts.openSans(fontSize: 13.0, color: Colors.white));

  Widget nameHeadPage(headName) => Text(headName,
      style: GoogleFonts.openSans(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white));
  Widget titleHead(name) => Text(name,
      style: GoogleFonts.openSans(
          fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white));

  Widget countName(name) => Text(name,
      style: GoogleFonts.openSans(fontSize: 11, color: Colors.white));

//End headPage

//Choice Text
  Widget choiceText(name, color) =>
      Text(name, style: GoogleFonts.openSans(fontSize: 17, color: color));
//End choice
}

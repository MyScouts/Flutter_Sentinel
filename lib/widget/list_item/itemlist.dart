import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sentinel_app/widget/stlye.dart';

class ItemList extends StatelessWidget {
  String nameHead;
  DateTime updated;
  Widget numCount;
  String imgPath;

  ItemList({this.nameHead, this.updated, this.numCount, this.imgPath});

  StyleApp styleApp = new StyleApp();

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMEd().format(updated).toUpperCase();
    return Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.0, color: Color(0xffEAECEF)))),
            margin: EdgeInsets.zero,
            child: Row(children: <Widget>[
              Container(
                  padding: EdgeInsets.only(bottom: 17.0),
                  child: styleApp.imageSmaill(imgPath)),
              Container(
                  padding: EdgeInsets.only(left: 10.5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(nameHead, style: styleApp.styleNameHead),
                        Text('UPDATED: $date', style: styleApp.updatedStyle),
                        Container(
                            padding: EdgeInsets.only(top: 14.5, bottom: 17.0),
                            child: Row(children: <Widget>[
                              Text('COUNT ', style:styleApp.countStyle(styleApp.colorBlack)),
                              numCount
                            ]))
                      ])),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                    Icon(Icons.arrow_forward_ios, color: styleApp.colorBrown)
                  ]))
            ])));
  }
}

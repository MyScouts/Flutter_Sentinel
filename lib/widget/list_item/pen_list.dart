import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sentinel_app/sentinel_database/dao/taken_image_dao.dart';

class PenList extends StatelessWidget {
  String sitename;
  DateTime updated;
  String imagePath;
  int id;
  BuildContext context;

  PenList({this.sitename, this.updated, this.imagePath, this.id, this.context});

  int index;
  bool viewSible = true;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMEd().format(updated).toUpperCase();

    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: [
          IconSlideAction(
            icon: FontAwesomeIcons.trash,
            color: Colors.red,
            onTap: _onDelete,
          )
        ],
        child: Container(
            padding: EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.0, color: Color(0xffEAECEF)))),
            margin: EdgeInsets.zero,
            child: Stack(children: [
              Row(children: <Widget>[
                Container(
                    padding: EdgeInsets.only(bottom: 17.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: imagePath == null
                            ? Image.asset('images/img_product.png')
                            : Image.file(File(imagePath),
                                width: 66.0, height: 66.0, fit: BoxFit.fill))),
                Container(
                    padding: EdgeInsets.only(left: 10.5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(sitename,
                              style: GoogleFonts.openSans(
                                  fontSize: 13.0, color: Color(0xffACB1C0))),
                          Text('Updated: ${date.toString().toUpperCase()}',
                              style: GoogleFonts.openSans(
                                  fontSize: 17.0, fontWeight: FontWeight.bold)),
                          Container(
                              padding: EdgeInsets.only(top: 14.5, bottom: 17.0),
                              child: Row(children: <Widget>[
                                Text('COUNT ',
                                    style: GoogleFonts.openSans(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold)),
                                Text('NOT YET COUNTED',
                                    style: GoogleFonts.openSans(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff007AFF)))
                              ]))
                        ]))
              ])
            ])));
  }

  void _onDelete() {
    final takenImageDao = Provider.of<TakenImageDao>(context, listen: false);
    takenImageDao.deleteTakenById(id);
    print('delete');
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sentinel_app/sentinel_database/dao/pen_dao.dart';
import 'package:sentinel_app/sentinel_database/database/my_database.dart';

class GetAllPenSiteId extends StatelessWidget {
  int siteId;

  GetAllPenSiteId({this.siteId});

  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<PenDao>(context, listen: false);
    return FutureBuilder(
      future: _data.getAllPenSiteId(siteId),
      builder: (BuildContext context, AsyncSnapshot<List<Pen>> snapshot) {
        return Text(
            snapshot.data == null ? '0' : snapshot.data.length.toString(),
            style: GoogleFonts.openSans(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.white));
      },
    );
  }
}

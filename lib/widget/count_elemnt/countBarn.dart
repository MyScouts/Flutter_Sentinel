import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentinel_app/sentinel_database/dao/barn_dao.dart';
import 'package:sentinel_app/sentinel_database/database/my_database.dart';
import 'package:google_fonts/google_fonts.dart';

class CountBarn extends StatelessWidget {
  int siteId;
  Color color;

  CountBarn({this.siteId, this.color});

  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<BarnDao>(context);
    return FutureBuilder(
      future: _data.getAllBarnsBySiteId(siteId),
      builder: (BuildContext context, AsyncSnapshot<List<Barn>> snapshot) {
        return Text(
            snapshot.data == null ? '0' : snapshot.data.length.toString(),
            style: GoogleFonts.openSans(
                fontSize: 13.0, fontWeight: FontWeight.bold, color: color));
      },
    );
  }
}

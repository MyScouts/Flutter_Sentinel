import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sentinel_app/sentinel_database/dao/pen_dao.dart';

class CountOfPen extends StatelessWidget {
  int barnId;

  CountOfPen({this.barnId});

  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<PenDao>(context);
    return FutureBuilder(
      future: _data.getCountPenBarnId(barnId),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return Text(
            snapshot.data.toString().isEmpty ? '0' : snapshot.data.toString(),
            style: GoogleFonts.openSans(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Color(0xff007AFF)));
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sentinel_app/sentinel_database/dao/taken_image_dao.dart';

class LastPenCount extends StatelessWidget {
  int penId;
  Color color;

  LastPenCount({this.penId, this.color});

  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<TakenImageDao>(context);
    return FutureBuilder(
      future: _data.getCountPenBarnId(penId),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return Text(snapshot.data == 0 ? '0' : snapshot.data.toString(),
            style: GoogleFonts.openSans(
                fontSize: 12.0, fontWeight: FontWeight.bold, color: color));
      },
    );
  }
}

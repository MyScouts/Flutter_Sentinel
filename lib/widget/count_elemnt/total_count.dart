import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sentinel_app/sentinel_database/dao/barn_dao.dart';
import 'package:sentinel_app/sentinel_database/dao/pen_dao.dart';
import 'package:sentinel_app/sentinel_database/dao/taken_image_dao.dart';
import 'package:sentinel_app/sentinel_database/database/my_database.dart';

class TotalCount extends StatelessWidget {
  int siteId;
  Color color;

  TotalCount({this.siteId, this.color});

  @override
  Widget build(BuildContext context) {
    final _barnDao = Provider.of<BarnDao>(context, listen: false);
    final _penDao = Provider.of<PenDao>(context, listen: false);
    final _takenIamge = Provider.of<TakenImageDao>(context, listen: false);
    return FutureBuilder(
      future: _barnDao.getAllBarnsBySiteId(siteId),
      builder: (BuildContext context, AsyncSnapshot<List<Barn>> barnSnap) {
        return FutureBuilder(
          future: _penDao.getAllPenSiteId(siteId),
          builder: (BuildContext context, AsyncSnapshot<List<Pen>> pennap) {
            return FutureBuilder(
              future: _takenIamge.getAllTakenSiteId(siteId),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TakenImage>> snapshot) {
                int countBarn =
                    barnSnap.data != null ? barnSnap.data.length : 0;
                int countPen = pennap.data != null ? pennap.data.length : 0;
                int countTaken =
                    snapshot.data != null ? snapshot.data.length : 0;
                return Text('${countBarn + countPen + countTaken}',
                    style: GoogleFonts.openSans(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: color));
              },
            );
          },
        );
      },
    );
  }
}

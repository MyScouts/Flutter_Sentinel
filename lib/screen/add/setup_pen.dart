import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sentinel_app/sentinel_database/dao/barn_dao.dart';
import 'package:sentinel_app/sentinel_database/dao/pen_dao.dart';
import 'package:sentinel_app/sentinel_database/database/my_database.dart';
import 'package:sentinel_app/widget/list_item/item_pen.dart';
import 'package:sentinel_app/widget/stlye.dart';
import 'setup_barn.dart';

class SetupPen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SetupPensState();
}

class SetupPensState extends State<SetupPen> {
  Map _penNameController = Map();
  StyleApp _styleApp = StyleApp();

  @override
  Widget build(BuildContext context) {
    ScreenPenArgument _arg = ModalRoute.of(context).settings.arguments;
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: Color(0xffF7F8FA),
                elevation: 0.5,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            final _data =
                                Provider.of<BarnDao>(context, listen: false);
                            _arg.idBarn.map((e) => _data.deleteBarnById(e));
                            Navigator.pop(context);
                          },
                          child: _styleApp.iconBack(Colors.black)),
                      _styleApp.textTitle('Setup pen', _styleApp.colorBlack),
                      GestureDetector(
                          onTap: () => addOnPen(_arg.barnName, _arg.numPen,
                              _arg.idBarn, _arg.idSite),
                          child:
                              _styleApp.textTitle('Done', _styleApp.colorRed))
                    ])),
            body: Container(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _arg.barnName.length,
                    itemBuilder: (context, index) => itemPen(
                        index, _arg.numPen, _arg.barnName, _arg.idBarn, _penNameController)))));
  }



  Future<void> addOnPen(
      List barnName, List numPen, List idBarn, int idSite) async {
    final _database = Provider.of<PenDao>(context, listen: false);
    DateTime _updated = DateTime.now();
    for (int i = 0; i < idBarn.length; i++)
      for (int j = 0; j < int.parse(numPen[i]); j++) {
        int _idBarn = idBarn[i];
        int _count = j + 1;
        final key = '[$_idBarn,$_count]';
        String name = _penNameController[key].text.trim();
        Pen pen = new Pen(
            updated: _updated,
            penName: name,
            idBarn: idBarn[i],
            idSite: idSite);
        _database.insertPen(pen);
      }
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }
}

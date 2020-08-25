import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:sentinel_app/sentinel_database/dao/barn_dao.dart';
import 'package:sentinel_app/sentinel_database/dao/site_dao.dart';
import 'package:sentinel_app/sentinel_database/database/my_database.dart';
import 'package:sentinel_app/widget/stlye.dart';

import 'add_site.dart';

class SetupBarn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SetupBarnState();
}

class _SetupBarnState extends State<SetupBarn> {
  StyleApp _styleApp = StyleApp();
  var _barnNameController = [];
  var _numPenController = [];
  var barnName = [];
  var numPens = [];
  var idBarn = [];

  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    ScreenSetupBarnArgument _args = ModalRoute.of(context).settings.arguments;
    for (int i = 0; i < _args.numBarn; i++) {
      _barnNameController.add(TextEditingController());
      _numPenController.add(TextEditingController(text: '1'));
    }
    int idSite = _args.idSite;
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        home: Scaffold(
            appBar: AppBar(
                backgroundColor: _styleApp.appBarCorlor,
                elevation: 0.5,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            final _data =
                                Provider.of<SiteDao>(context, listen: false);
                            _data.deleteSiteById(_args.idSite);
                            Navigator.pop(context);
                          },
                          child:
                              Icon(Icons.arrow_back_ios, color: Colors.black)),
                      _styleApp.textTitle('Statup Barn', _styleApp.colorBlack),
                      GestureDetector(
                          onTap: () => onAddBarn(idSite, _args.numBarn),
                          child:
                              _styleApp.textTitle('Next', _styleApp.colorRed))
                    ])),
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: 21.0, vertical: 21.0),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _args.numBarn,
                    itemBuilder: (context, index) => itemCount(index)))));
  }

  Widget itemCount(int index) {
    final count = index + 1;
    return Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Container(
            decoration:
                BoxDecoration(border: Border(bottom: _styleApp.borderside)),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Barn $count Name', style: _styleApp.lableTextName()),
                Text('Number of Pens', style: _styleApp.lableTextName())
              ]),
              Row(children: [
                Flexible(
                    child: TextField(
                        textCapitalization: TextCapitalization.words,
                        controller: _barnNameController[index],
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'BAN $count ',
                            hintStyle: _styleApp.hintTextName()))),
                Flexible(
                    child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _numPenController[index],
                            textAlign: TextAlign.right,
                            autofocus: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '1',
                                hintStyle: _styleApp.hintTextName()))))
              ])
            ])));
  }

  Future<void> onAddBarn(int idSite, int numBarn) async {
    DateTime now = DateTime.now();

    final database = Provider.of<BarnDao>(context, listen: false);
    for (int i = 0; i < numBarn; i++) {
      Barn barn = new Barn(
          barnName: _barnNameController[i].text.trim(),
          updated: now,
          idSite: idSite,
          penCount: int.parse(_numPenController[i].text.trim()));
      final id = await database.insertBarn(barn);
      print(barn.toString());
      idBarn.add(id);
    }
    for (int i = 0; i < idBarn.length; i++) {
      print('idBarn[$i]: ${idBarn[i]}');
    }
    onSendScreen(idSite);
  }

  void onSendScreen(int idSite) {
    for (int i = 0; i < _barnNameController.length; i++) {
      barnName.add(_barnNameController[i].text.trim());
      numPens.add(_numPenController[i].text.trim());
    }
    Navigator.pushNamed(context, '/setup_pen',
        arguments: ScreenPenArgument(
            barnName: barnName,
            numPen: numPens,
            idBarn: idBarn,
            idSite: idSite));
  }
}

class ScreenPenArgument {
  var barnName = [];
  var numPen = [];
  var idBarn = [];
  var idSite;

  ScreenPenArgument({this.barnName, this.numPen, this.idBarn, this.idSite});
}

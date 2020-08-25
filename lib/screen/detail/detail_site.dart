import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:sentinel_app/screen/add/add_site.dart';
import 'package:sentinel_app/sentinel_database/dao/barn_dao.dart';
import 'package:sentinel_app/sentinel_database/database/my_database.dart';
import 'package:sentinel_app/widget/count_elemnt/countPen.dart';
import 'package:sentinel_app/widget/count_elemnt/getAllPenSiteId.dart';
import 'package:sentinel_app/widget/count_elemnt/total_count.dart';
import 'package:sentinel_app/widget/dialog/delete_dialog.dart';
import 'package:sentinel_app/widget/dialog/rename_dialog.dart';
import 'package:sentinel_app/widget/stlye.dart';
import '../../widget/list_item/itemlist.dart';
import '../home.dart';

class MyPopUpItem {
  MyPopUpItem({this.title, this.color});

  String title;
  Color color;
}

List<MyPopUpItem> choices = <MyPopUpItem>[
  MyPopUpItem(title: 'Rename Site', color: Colors.black),
  MyPopUpItem(title: 'Delete Site', color: Color(0xffFF2D55)),
];

class DetailSite extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DetailSiteState();
}

class _DetailSiteState extends State<DetailSite> {
  int lisSize;
  StyleApp _styleApp = StyleApp();

  @override
  Widget build(BuildContext context) {
    HomeToSite _arg = ModalRoute.of(context).settings.arguments;
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
                child: Column(children: <Widget>[
          Container(
              height: 289.0,
              child: Stack(children: <Widget>[
                ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(Colors.black45, BlendMode.srcOver),
                    child: _styleApp.imgHead(_arg.site.imagePath)),
                Container(
                    padding:
                        EdgeInsets.only(left: 15.0, right: 15.0, top: 50.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/home'),
                              child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: _styleApp
                                      .iconBack(_styleApp.colorWhite))),
                          PopupMenuButton(
                              onSelected: choiceOption,
                              itemBuilder: (BuildContext context) {
                                return choices.map((MyPopUpItem choice) {
                                  return PopupMenuItem<MyPopUpItem>(
                                      value: choice,
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              right: 83.0, left: 20.0),
                                          child: _styleApp.choiceText(
                                              choice.title, choice.color)));
                                }).toList();
                              },
                              icon: Icon(Icons.more_vert,
                                  color: _styleApp.colorWhite))
                        ])),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _styleApp.nameHeadPage(_arg.site.siteName),
                                  _styleApp.dateHead(_arg.site.updated)
                                ])
                          ]),
                          Padding(padding: EdgeInsets.only(bottom: 35.0)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Row(children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TotalCount(
                                              siteId: _arg.site.id,
                                              color: Colors.white),
                                          _styleApp.countName('Total Count')
                                        ]),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 22.0)),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GetAllPenSiteId(siteId: _arg.site.id),
                                          _styleApp.countName('Pen')
                                        ])
                                  ])
                                ]),
                                Column(children: [
                                  Container(
                                      child: Row(children: [
                                    FlatButton(
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    18.0)),
                                        color: _styleApp.colorBlue,
                                        onPressed: () =>
                                            _addBarnFunc(_arg.site.id),
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.5,
                                                horizontal: 17.5),
                                            child: _styleApp
                                                .buttonText('ADD BARN')))
                                  ]))
                                ])
                              ]),
                          Padding(padding: EdgeInsets.only(bottom: 15.0))
                        ]))
              ])),
          Expanded(child: _streamDetailSite(context, _arg.site))
        ]))));
  }

  choiceOption(MyPopUpItem choice) {
    HomeToSite _arg = ModalRoute.of(context).settings.arguments;
    DeleteDialog delete = DeleteDialog(
        context: context,
        site: _arg.site,
        key: 'Site',
        nameHead: _arg.site.siteName);
    RenameDiaglog renameDiaglog = RenameDiaglog(
        context: context,
        site: _arg.site,
        key: 'Site',
        nameHead: _arg.site.siteName);
    if (choice == choices[0]) {
      renameDiaglog.renameAlertDialog();
    } else {
      delete.deleteAlertDialog();
    }
  }

  StreamBuilder<List<Barn>> _streamDetailSite(BuildContext context, Site site) {
    final database = Provider.of<BarnDao>(context);
    return StreamBuilder(
      stream: database.watchAllBarnSiteId(site.id),
      builder: (BuildContext context, AsyncSnapshot<List<Barn>> snapshot) {
        final barns = snapshot.data ?? List();
        barnCount(barns.length);
        return Container(
            child: ListView.builder(
                itemCount: barns == null ? 0 : barns.length,
                itemBuilder: (BuildContext context, int index) {
                  Barn barn = barns[index];
                  return InkWell(
                      onTap: () => goToBarn(barn, site),
                      child: ItemList(
                          nameHead: barn.barnName,
                          updated: barn.updated,
                          imgPath: barn.imagePath,
                          numCount: CountOfPen(barnId: barn.id)));
                }));
      },
    );
  }

  barnCount(totalCount) => lisSize = totalCount;

  _addBarnFunc(int idSite) => Navigator.pushNamed(context, '/setup_barn',
      arguments: ScreenSetupBarnArgument(numBarn: 1, idSite: idSite));

  goToBarn(Barn barn, Site site) => Navigator.pushNamed(context, '/detail_barn',
      arguments: SiteToBarn(barn: barn, site: site));
}

class SiteToBarn {
  Site site;
  Barn barn;

  SiteToBarn({this.site, this.barn});
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sentinel_app/screen/add/setup_barn.dart';
import 'package:sentinel_app/screen/detail/detail_site.dart';
import 'package:sentinel_app/sentinel_database/dao/barn_dao.dart';
import 'package:sentinel_app/sentinel_database/dao/pen_dao.dart';
import 'package:sentinel_app/sentinel_database/database/my_database.dart';
import 'package:sentinel_app/widget/count_elemnt/last_pen_count.dart';
import 'package:sentinel_app/widget/dialog/delete_dialog.dart';
import 'package:sentinel_app/widget/dialog/rename_dialog.dart';
import 'package:sentinel_app/widget/stlye.dart';
import '../../widget/list_item/itemlist.dart';

class DetailBarn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DetailBarnState();
  }
}

class _DetailBarnState extends State<DetailBarn> {
  StyleApp _styleApp = new StyleApp();
  var _img;

  @override
  Widget build(BuildContext context) {
    var _imagePath;
    SiteToBarn _arg = ModalRoute.of(context).settings.arguments;
    if (_arg.barn.imagePath != null && _arg.barn.imagePath == _img ||
        _img == null) {
      _imagePath = _arg.barn.imagePath;
    } else {
      _imagePath = _img;
    }
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
                child: _styleApp.imgHead(_imagePath)),
            Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 50.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: _styleApp.iconBack(_styleApp.colorWhite))),
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
                          icon: Icon(Icons.more_vert, color: Colors.white))
                    ])),
            Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: <
                        Widget>[
                  Row(children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _styleApp.titleHead(_arg.site.siteName),
                          _styleApp.nameHeadPage(_arg.barn.barnName),
                          Container(margin: EdgeInsets.only(top: 11.0)),
                          _styleApp.countName('Barn Count')
                        ])
                  ]),
                  Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                        FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0)),
                            color: Color(0xff007AFF),
                            onPressed: (){},
                            child: Container(
                                child: Row(children: [
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: FaIcon(FontAwesomeIcons.minus,
                                      color: Colors.white, size: 14.0)),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  color: Colors.white,
                                  child: Text(_arg.barn.id.toString())),
                              Container(
                                  margin: EdgeInsets.only(left: 10),
//                                            child: Image.asset('images/count.png'),
                                  child: FaIcon(FontAwesomeIcons.plus,
                                      color: Colors.white, size: 14.0))
                            ]))),
                        FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0)),
                            color: Color(0xff007AFF),
                            onPressed: () =>
                                setState(() => getImage(_arg.site.siteName)),
                            child: Container(
                                child: _styleApp.buttonText('TAKE PHOTOS'))),
                        FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0)),
                            color: _styleApp.colorBlue,
                            onPressed: () => _addBarnFunc(_arg.barn.barnName,
                                _arg.barn.id, _arg.barn.idSite),
                            child: Container(
                                child: _styleApp.buttonText('ADD PEN')))
                      ]))
                ]))
          ])),
      Expanded(
        child: _streamBuildBarn(context, _arg.barn, _arg.site),
      )
    ]))));
  }

  StreamBuilder<List<Pen>> _streamBuildBarn(
      BuildContext context, Barn barn, Site site) {
    final database = Provider.of<PenDao>(context, listen: false);
    return StreamBuilder(
        stream: database.watchAllPenWithBarnId(barn.id),
        builder: (BuildContext mcontext, AsyncSnapshot<List<Pen>> snapshot) {
          final pens = snapshot.data ?? List();
          return Container(
              child: ListView.builder(
                  itemCount: pens == null ? 0 : pens.length,
                  itemBuilder: (BuildContext mContext, int index) {
                    Pen pen = pens[index];
                    return InkWell(
                        onTap: () => Navigator.pushNamed(context, '/detail_pen',
                            arguments:
                                BarnToPen(site: site, barn: barn, pen: pen)),
                        child: ItemList(
                            nameHead: pen.penName ?? '',
                            updated: pen.updated ?? '',
                            numCount: LastPenCount(
                                penId: pen.id, color: _styleApp.colorBlue),
                            imgPath: pen.imagePath));
                  }));
        });
  }

  getImage(String siteName) async {
    final _data = Provider.of<BarnDao>(context, listen: false);
    SiteToBarn _arg = ModalRoute.of(context).settings.arguments;
    final picker = ImagePicker();
    final _pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() => _img = _pickedFile.path);
    Barn barn = new Barn(
        id: _arg.barn.id,
        idSite: _arg.barn.idSite,
        imagePath: _img,
        barnName: _arg.barn.barnName,
        updated: _arg.barn.updated);
    _data.updateBarn(barn);
//    refreshDetailBarn(barn, siteName);
  }

//  Refest Screen
  refreshDetailBarn(Barn barn, Site site) =>
      Navigator.pushReplacementNamed(context, '/detail_barn',
          arguments: SiteToBarn(site: site, barn: barn));

  choiceOption(MyPopUpItem choice) {
    SiteToBarn _arg = ModalRoute.of(context).settings.arguments;
    DeleteDialog delete = DeleteDialog(
        context: context,
        site: _arg.site,
        barn: _arg.barn,
        key: 'Barn',
        nameHead: _arg.barn.barnName);
    RenameDiaglog renameDiaglog = RenameDiaglog(
        context: context,
        site: _arg.site,
        key: 'Barn',
        barn: _arg.barn,
        nameHead: _arg.barn.barnName);
    if (choice == choices[0]) {
      renameDiaglog.renameAlertDialog();
    } else {
      delete.deleteAlertDialog();
    }
  }

  _addBarnFunc(String barnName, int barnId, int siteId) {
    var _barnName = [barnName];
    var _barnId = [barnId];
    var _numPen = ['1'];
    Navigator.pushNamed(context, '/setup_pen',
        arguments: ScreenPenArgument(
            barnName: _barnName,
            idBarn: _barnId,
            numPen: _numPen,
            idSite: siteId));
  }
}

class MyPopUpItem {
  MyPopUpItem({this.title, this.color});

  String title;
  Color color;
}

List<MyPopUpItem> choices = <MyPopUpItem>[
  MyPopUpItem(title: 'Rename Barn', color: Colors.black),
  MyPopUpItem(title: 'Delete Barn', color: Color(0xffFF2D55)),
];

class BarnToPen {
  Site site;
  Barn barn;
  Pen pen;

  BarnToPen({this.site, this.barn, this.pen});
}

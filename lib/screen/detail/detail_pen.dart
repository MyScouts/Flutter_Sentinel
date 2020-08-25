import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sentinel_app/screen/detail/detail_barn.dart';
import 'package:sentinel_app/sentinel_database/dao/pen_dao.dart';
import 'package:sentinel_app/sentinel_database/dao/taken_image_dao.dart';
import 'package:sentinel_app/sentinel_database/database/my_database.dart';
import 'package:sentinel_app/widget/count_elemnt/last_pen_count.dart';
import 'package:sentinel_app/widget/count_elemnt/total_count.dart';
import 'package:sentinel_app/widget/dialog/delete_dialog.dart';
import 'package:sentinel_app/widget/dialog/rename_dialog.dart';
import 'package:sentinel_app/widget/list_item/pen_list.dart';
import 'package:sentinel_app/widget/stlye.dart';


class DetailsPen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DetailsPenState();
}

class DetailsPenState extends State<DetailsPen> {
  StyleApp _styleApp = StyleApp();

  @override
  Widget build(BuildContext context) {
    BarnToPen _dataBarn = ModalRoute.of(context).settings.arguments;
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
                child: _styleApp.imgHead(_dataBarn.pen.imagePath)),
            Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 50.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: _styleApp.iconBack(_styleApp.colorWhite)),
                      ),
                      PopupMenuButton(
                          onSelected: choiceOption,
                          itemBuilder: (BuildContext context) => choices
                              .map((MyPopUpItem choice) =>
                                  PopupMenuItem<MyPopUpItem>(
                                      value: choice,
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              right: 83.0, left: 20.0),
                                          child: _styleApp.choiceText(
                                              choice.title, choice.color))))
                              .toList(),
                          icon: Icon(Icons.more_vert, color: Colors.white))
                    ])),
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Row(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _styleApp.titleHead(_dataBarn.site.siteName),
                          Row(children: [
                            _styleApp.nameHeadPage(_dataBarn.barn.barnName),
                            Icon(Icons.arrow_forward_ios, color: Colors.white),
                            _styleApp.nameHeadPage(_dataBarn.pen.penName)
                          ]),
                          _styleApp.dateHead(_dataBarn.pen.updated)
                        ])
                  ]),
                  Padding(padding: EdgeInsets.only(bottom: 35.0)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Row(children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TotalCount(
                                      siteId: _dataBarn.site.id,
                                      color: Colors.white),
                                  _styleApp.countName('Image Taken')
                                ]),
                            Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 22.0)),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LastPenCount(
                                      penId: _dataBarn.pen.id,
                                      color: Colors.white),
                                  _styleApp.countName('Last Pen Count')
                                ])
                          ])
                        ]),
                        Column(children: [
                          Container(
                              child: Row(children: [
                            FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(18.0)),
                                color: _styleApp.colorBlue,
                                onPressed: () => getImage(_dataBarn.site,
                                    _dataBarn.barn, _dataBarn.pen),
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.5, horizontal: 17.5),
                                    child: _styleApp.buttonText('TAKE PHOTO')))
                          ]))
                        ])
                      ]),
                  Padding(padding: EdgeInsets.only(bottom: 15.0))
                ]))
          ])),
      Expanded(child: _streamBuildTaken(context, _dataBarn.site, _dataBarn.pen))
    ]))));
  }

  StreamBuilder<List<TakenImage>> _streamBuildTaken(
      BuildContext context, Site site, Pen pen) {
    final database = Provider.of<TakenImageDao>(context, listen: false);
    return StreamBuilder(
        stream: database.watchAllTakenPenId(pen.id),
        builder:
            (BuildContext mcontext, AsyncSnapshot<List<TakenImage>> snapshot) {
          final takens = snapshot.data ?? List();
          return Container(
              child: ListView.builder(
                  itemCount: takens == null ? 0 : takens.length,
                  itemBuilder: (BuildContext mContext, int index) {
                    TakenImage taken = takens[index];
                    return InkWell(
                        onTap: null,
                        child: PenList(
                            context: context,
                            id: taken.id,
                            sitename: site.siteName,
                            updated: pen.updated,
                            imagePath: taken.imagePath));
                  }));
        });
  }

  getImage(Site site, Barn barn, Pen pen) async {
    setState(() async {
      final penDao = Provider.of<PenDao>(context, listen: false);
      final takenImageDao = Provider.of<TakenImageDao>(context, listen: false);
      final picker = ImagePicker();
      final _pickedFile = await picker.getImage(source: ImageSource.gallery);
      TakenImage takenImage = new TakenImage(
          idSite: site.id, idPen: pen.id, imagePath: _pickedFile.path);
      takenImageDao.insertTaken(takenImage);
      Pen mPen = Pen(
          id: pen.id,
          updated: DateTime.now(),
          idSite: site.id,
          idBarn: barn.id,
          imagePath: _pickedFile.path,
          penName: pen.penName);
      penDao.updatePen(mPen);
      refreshScreenPen(site, mPen, barn);
    });
  }

  choiceOption(MyPopUpItem choice) {
    BarnToPen _arg = ModalRoute.of(context).settings.arguments;
    DeleteDialog delete = DeleteDialog(
        context: context,
        site: _arg.site,
        barn: _arg.barn,
        key: 'Pen',
        pen: _arg.pen,
        nameHead: _arg.pen.penName);
    RenameDiaglog renameDiaglog = RenameDiaglog(
        context: context,
        site: _arg.site,
        key: 'Pen',
        barn: _arg.barn,
        pen: _arg.pen,
        nameHead: _arg.pen.penName);
    if (choice == choices[0]) {
      renameDiaglog.renameAlertDialog();
    } else {
      delete.deleteAlertDialog();
    }
  }

  refreshScreenPen(Site site, Pen pen, Barn barn) =>
      Navigator.pushReplacementNamed(context, '/detail_pen',
          arguments: BarnToPen(site: site, pen: pen, barn: barn));
}

List<MyPopUpItem> choices = <MyPopUpItem>[
  MyPopUpItem(title: 'Rename Pen', color: Colors.black),
  MyPopUpItem(title: 'Delete Pen', color: Color(0xffFF2D55)),
];

class MyPopUpItem {
  MyPopUpItem({this.title, this.color});

  String title;
  Color color;
}

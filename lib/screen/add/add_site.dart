import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:sentinel_app/sentinel_database/dao/site_dao.dart';
import 'package:sentinel_app/sentinel_database/database/my_database.dart';
import 'package:sentinel_app/widget/stlye.dart';

class AddSiteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AddSiteState();
}

class _AddSiteState extends State<AddSiteScreen> {
  StyleApp _styleApp = new StyleApp();

  ///Controller
  final _siteNameController = TextEditingController();
  final _siteAddressController = TextEditingController();
  final _numBarnController = TextEditingController(text: '1');

  String _siteNameErr = 'Tên không được để trống';
  String _siteAddErr = 'Địa chỉ không được để trống';
  String _numBarnErr = 'Số lượng Barn lớn hơn 0';

  ///
  bool _chkSiteName = false;
  bool _chkSiteAdress = false;
  bool _checkNumBarn = false;

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: _styleApp.appBarCorlor,
                elevation: 0.5,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: _styleApp.iconBack(_styleApp.colorBlack)),
                      _styleApp.textTitle(
                          'Add new Sites', _styleApp.colorBlack),
                      GestureDetector(
                          onTap: () => setState(() {
                                String _siteName =
                                    _siteNameController.text.trim();
                                String _adress =
                                    _siteAddressController.text.trim();
                                String _numBarn =
                                    _numBarnController.text.trim();
                                onAddSite(_siteName, _adress, _numBarn);
                              }),
                          child:
                              _styleApp.textTitle('Next', _styleApp.colorRed))
                    ])),
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 19.0),
                child: Column(children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1.0, color: Color(0xffEAECEF)))),
                      child: TextField(
                          textCapitalization: TextCapitalization.words,
                          controller: _siteNameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              errorText:
                                  _chkSiteName == true ? _siteNameErr : null,
                              labelText: 'SITE NAME',
                              labelStyle: _styleApp.textInput))),
                  Padding(padding: EdgeInsets.only(top: 19.5)),
                  Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: _styleApp.borderside)),
                      child: TextField(
                          textCapitalization: TextCapitalization.words,
                          controller: _siteAddressController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              errorText:
                                  _chkSiteAdress == true ? _siteAddErr : null,
                              labelText: 'SITE ADDRESS',
                              labelStyle: _styleApp.textInput))),
                  Padding(padding: EdgeInsets.only(top: 19.5)),
                  Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: _styleApp.borderside)),
                      child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _numBarnController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              errorText:
                                  _checkNumBarn == true ? _numBarnErr : null,
                              labelText: 'NUMBER OF BARNS',
                              labelStyle: _styleApp.textInput)))
                ]))));
  }

  Future<void> onAddSite(
      String _siteName, String _adress, String _numBarn) async {
    DateTime _now = DateTime.now();
    final database = Provider.of<SiteDao>(context, listen: false);
    int _numOfBarn;
    if (_numBarn.trim().isEmpty)
      _numOfBarn = 0;
    else
      _numOfBarn = int.parse(_numBarn);

    _siteName.isEmpty ? _chkSiteName = true : _chkSiteName = false;
    _adress.isEmpty ? _chkSiteAdress = true : _chkSiteAdress = false;
    _numOfBarn <= 0 ? _checkNumBarn = true : _checkNumBarn = false;
    if (_chkSiteName == false &&
        _checkNumBarn == false &&
        _chkSiteAdress == false) {
      var id = await database.insertSite(
          new Site(siteName: _siteName, updated: _now, siteOfBarn: _numOfBarn));
      Navigator.pushNamed(context, '/setup_barn',
          arguments: ScreenSetupBarnArgument(numBarn: _numOfBarn, idSite: id));
    }
  }
}

class ScreenSetupBarnArgument {
  final int idSite;
  int numBarn;

  ScreenSetupBarnArgument({this.numBarn, this.idSite});
}

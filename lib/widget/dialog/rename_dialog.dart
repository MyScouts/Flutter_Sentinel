import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sentinel_app/screen/detail/detail_barn.dart';
import 'package:sentinel_app/screen/detail/detail_site.dart';
import 'package:sentinel_app/screen/home.dart';
import 'package:sentinel_app/sentinel_database/dao/barn_dao.dart';
import 'package:sentinel_app/sentinel_database/dao/pen_dao.dart';
import 'package:sentinel_app/sentinel_database/dao/site_dao.dart';
import 'package:sentinel_app/sentinel_database/database/my_database.dart';

class RenameDiaglog {
  BuildContext context;
  Site site;
  Barn barn;
  Pen pen;
  String key;
  String nameHead;

  RenameDiaglog(
      {this.context, this.site, this.barn, this.pen, this.key, this.nameHead});

  renameAlertDialog() {
    String edText;
    final _siteRenameController = TextEditingController(text: nameHead);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              contentPadding: EdgeInsets.symmetric(horizontal: 21.0),
              title: Text('$key name',
                  style: GoogleFonts.openSans(
                      fontSize: 17.0, color: Color(0xff818181))),
              content: TextField(
                  onChanged: (text) => edText = text,
                  textCapitalization: TextCapitalization.words,
                  controller: _siteRenameController,
                  decoration: InputDecoration()),
              actions: <Widget>[
                Container(
                    padding:
                        EdgeInsets.only(bottom: 34.0, right: 21.0, top: 23.0),
                    child: Row(children: <Widget>[
                      FlatButton(
                          color: Color(0xffC4C4C4),
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel',
                              style: TextStyle(color: Colors.white))),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 4.0)),
                      FlatButton(
                          color: Color(0xff007AFF),
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          onPressed: () => onUpdate(edText),
                          child: Text('Save'))
                    ]))
              ]);
        });
  }

  onUpdate(edtext) {
    switch (key) {
      case 'Site':
        Navigator.pop(context);
        final data = Provider.of<SiteDao>(context, listen: false);
        Site mSite =
            Site(id: site.id, siteName: edtext, updated: DateTime.now());
        data.updateSite(mSite);
        Navigator.pushReplacementNamed(context, '/detail_site',
            arguments: new HomeToSite(site: mSite));
        break;
      case 'Barn':
        Navigator.pop(context);
        final data = Provider.of<BarnDao>(context, listen: false);
        Barn mBarn = Barn(
            id: barn.id,
            barnName: edtext,
            idSite: site.id,
            updated: DateTime.now());
        data.updateBarn(mBarn);
        Navigator.pushReplacementNamed(context, '/detail_barn',
            arguments: new SiteToBarn(barn: mBarn, site: site));
        break;
      case 'Pen':
        Navigator.pop(context);
        final data = Provider.of<PenDao>(context, listen: false);
        Pen mPen = Pen(
            penName: edtext,
            id: pen.id,
            updated: DateTime.now(),
            idSite: site.id,
            idBarn: barn.id);
        data.updatePen(mPen);
        Navigator.pushReplacementNamed(context, '/detail_pen',
            arguments: new BarnToPen(site: site, barn: barn, pen: mPen));
        break;
      default:
        break;
    }
  }
}

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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeleteDialog {
  BuildContext context;
  Site site;
  Barn barn;
  Pen pen;
  String key;
  String nameHead;

  DeleteDialog(
      {this.context, this.site, this.barn, this.pen, this.key, this.nameHead});

  deleteAlertDialog() {
    String deleteText;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              contentPadding: EdgeInsets.symmetric(horizontal: 21.0),
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: FaIcon(FontAwesomeIcons.exclamationTriangle,
                            size: 65.0, color: Color(0xffFF2D55))),
                    Text('Are you sure you want to delete',
                        style: GoogleFonts.openSans(
                            fontSize: 17.0, color: Color(0xffFF0000))),
                    Text(nameHead,
                        style: GoogleFonts.openSans(
                            fontSize: 17.0,
                            color: Color(0xffFF0000),
                            fontWeight: FontWeight.bold)),
                    Text(
                        'This will delete all associated barns,pens, and data.  This action cannot be undone.  Please type ‘DELETE’ below to confirm.',
                        style: GoogleFonts.cabin(fontSize: 17.0))
                  ]),
              content: Container(
                  padding: EdgeInsets.only(top: 13.5),
                  child: TextField(
                      onChanged: (text) => deleteText = text,
                      textCapitalization: TextCapitalization.characters)),
              actions: <Widget>[
                Container(
                    padding:
                        EdgeInsets.only(bottom: 29.0, right: 21.0, top: 23.0),
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
                          color: Color(0xffFF0000),
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          onPressed: () => onDelete(key, deleteText),
                          child: Text('Delete'))
                    ]))
              ]);
        });
  }

  onDelete(key, deleteText) {
    switch (key) {
      case 'Site':
        if (deleteText != 'DELETE') {
          Navigator.pushReplacementNamed(context, '/detail_site',
              arguments: HomeToSite(site: site));
        } else {
          final _siteDao = Provider.of<SiteDao>(context, listen: false);
          _siteDao.deleteSiteById(site.id);
          Navigator.pushReplacementNamed(context, '/home');
        }
        break;
      case 'Barn':
        if (deleteText != 'DELETE') {
          Navigator.pop(context);
        } else {
          final _barnDao = Provider.of<BarnDao>(context, listen: false);
          _barnDao.deleteBarnById(barn.id);
          Navigator.pushReplacementNamed(context, '/detail_site',
              arguments: HomeToSite(site: site));
        }
        break;
      case 'Pen':
        if (deleteText != 'DELETE') {
          Navigator.pop(context);
        } else {
          final _penDao = Provider.of<PenDao>(context, listen: false);
          _penDao.deletePenById(pen.id);
          Navigator.pushReplacementNamed(context, '/detail_barn',
              arguments: SiteToBarn(barn: barn, site: site));
        }
        break;
      default:
        break;
    }
  }
}

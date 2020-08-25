import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:sentinel_app/sentinel_database/dao/site_dao.dart';
import 'package:sentinel_app/sentinel_database/database/my_database.dart';
import 'package:sentinel_app/widget/count_elemnt/total_count.dart';
import 'package:sentinel_app/widget/drawer.dart';
import 'package:sentinel_app/widget/stlye.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/list_item/itemlist.dart';

class HomeState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<HomeState> {
  SharedPreferences dataLogin;
  String userName;
  StyleApp _styleApp = StyleApp();

  @override
  void initState() {
    super.initState();
    pickData();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        appBar: AppBar(
            iconTheme: new IconThemeData(color: Colors.black),
            backgroundColor: _styleApp.appBarCorlor,
            elevation: 0.5,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(padding: EdgeInsets.zero),
                  _styleApp.textTitle('My Site', _styleApp.colorBlack),
                  GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/add_site'),
                      child:
                          _styleApp.textTitle('Add Site', _styleApp.colorRed))
                ])),
        body: _streamDetailSite(context),
        drawer: buildDrawer(context, userName));
  }

  StreamBuilder<List<Site>> _streamDetailSite(BuildContext context) {
    final database = Provider.of<SiteDao>(context);
    return StreamBuilder(
        stream: database.watchAllSite(),
        builder: (BuildContext context, AsyncSnapshot<List<Site>> snapshot) {
          final sites = snapshot.data ?? List();
          return Container(
              child: ListView.builder(
                  itemCount: sites.length,
                  itemBuilder: (BuildContext context, int index) {
                    Site site = sites[index];
                    return InkWell(
                        onTap: () => goToBarn(site),
                        child: ItemList(
                            nameHead: site.siteName.toUpperCase(),
                            updated: site.updated,
                            numCount: TotalCount(
                                siteId: site.id, color: _styleApp.colorBlue)));
                  }));
        });
  }

  void goToBarn(Site site) => Navigator.pushNamed(context, '/detail_site',
      arguments: HomeToSite(site: site));

  pickData() async {
    dataLogin = await SharedPreferences.getInstance();
    setState(() => userName = dataLogin.getString('email'));
  }
}

class HomeToSite {
  final Site site;

  HomeToSite({this.site});
}

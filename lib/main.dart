import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/add/add_site.dart';
import 'screen/detail/detail_pen.dart';
import 'screen/home.dart';
import 'screen/detail/detail_site.dart';
import 'screen/detail/detail_barn.dart';
import 'screen/login.dart';
import 'screen/add/setup_barn.dart';
import 'screen/add/setup_pen.dart';
import 'sentinel_database/database/my_database.dart';

void main() => runApp(MultiProvider(
      providers: [
        Provider(create: (_) => MyDatabase().userDao),
        Provider(create: (_) => MyDatabase().siteDao),
        Provider(create: (_) => MyDatabase().barnDao),
        Provider(create: (_) => MyDatabase().penDao),
        Provider(create: (_) => MyDatabase().takenImageDao)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (context) => LoginPage(),
          '/home': (context) => HomeState(),
          '/add_site': (context) => AddSiteScreen(),
          '/setup_barn': (context) => SetupBarn(),
          '/setup_pen': (context) => SetupPen(),
          '/detail_site': (context) => DetailSite(),
          '/detail_barn': (context) => DetailBarn(),
          '/detail_pen': (context) => DetailsPen()
        },
      ),
    ));

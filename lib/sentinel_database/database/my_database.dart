import 'dart:io';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentinel_app/sentinel_database/dao/pen_dao.dart';
import 'package:sentinel_app/sentinel_database/dao/taken_image_dao.dart';
import 'package:sentinel_app/sentinel_database/table/taken_image.dart';
import '../dao/barn_dao.dart';
import '../dao/site_dao.dart';
import '../dao/user_dao.dart';
import '../table/barn.dart';
import '../table/pen.dart';
import '../table/site.dart';
import '../table/user.dart';
import 'package:path/path.dart' as p;

part 'my_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db2.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(
    tables: [Users, Sites, Barns, Pens, TakenImages],
    daos: [UserDao, SiteDao, BarnDao, PenDao, TakenImageDao])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from == 1) await migrator.createTable(users);
        },
      );
}

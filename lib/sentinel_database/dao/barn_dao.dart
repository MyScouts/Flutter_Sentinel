import 'package:moor/moor.dart';
import 'package:sentinel_app/sentinel_database/database/my_database.dart';
import 'package:sentinel_app/sentinel_database/table/barn.dart';

part 'barn_dao.g.dart';

@UseDao(tables: [Barns])
class BarnDao extends DatabaseAccessor<MyDatabase> with _$BarnDaoMixin {
  final MyDatabase db;

  BarnDao(this.db) : super(db);

  Future<List<Barn>> getAllBarnsBySiteId(int id) =>
      (select(barns)..where((t) => t.idSite.equals(id))).get();

  Stream<List<Barn>> watchAllBarnSiteId(int id) {
    return (select(barns)..where((tbl) => tbl.idSite.equals(id))).watch();
  }
  Stream<List<Barn>> watchAllBarn() => select(barns).watch();

  Future insertBarn(Barn barn) => into(barns).insert(barn);

  Future updateBarn(Barn barn) => update(barns).replace(barn);

  Future deleteBarnById(int id) =>
      (delete(barns)..where((c) => c.id.equals(id))).go();
}

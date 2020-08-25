import 'package:moor/moor.dart';
import 'package:sentinel_app/sentinel_database/database/my_database.dart';
import 'package:sentinel_app/sentinel_database/table/pen.dart';

part 'pen_dao.g.dart';

@UseDao(tables: [Pens])
class PenDao extends DatabaseAccessor<MyDatabase> with _$PenDaoMixin {
  final MyDatabase db;

  PenDao(this.db) : super(db);

  Future<List<Pen>> getAllPen() => select(pens).get();

  Future<List<Pen>> getAllPenBarnId(int idBarn) =>
      (select(pens)..where((tbl) => tbl.idBarn.equals(idBarn))).get();

  Future<List<Pen>> getAllPenSiteId(int idSite) =>
      (select(pens)..where((tbl) => tbl.idSite.equals(idSite))).get();

  Future<int> getCountPenBarnId(int id) async {
    List<Pen> pen = await getAllPenBarnId(id);
    return pen.length;
  }


  Stream<List<Pen>> watchAllPen() => select(pens).watch();

  Stream<List<Pen>> watchAllPenWithBarnId(int id) {
    return (select(pens)..where((tbl) => tbl.idBarn.equals(id))).watch();
  }

  Future insertPen(Pen pen) => into(pens).insert(pen);

  Future updatePen(Pen pen) => update(pens).replace(pen);

  Future deletePen(Pen pen) => delete(pens).delete(pen);
  Future deletePenById(int id) =>
      (delete(pens)..where((c) => c.id.equals(id))).go();
}

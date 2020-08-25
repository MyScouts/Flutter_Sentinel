import 'package:moor/moor.dart';
import 'package:sentinel_app/sentinel_database/database/my_database.dart';
import 'package:sentinel_app/sentinel_database/table/taken_image.dart';

part 'taken_image_dao.g.dart';

@UseDao(tables: [TakenImages])
class TakenImageDao extends DatabaseAccessor<MyDatabase>
    with _$TakenImageDaoMixin {
  MyDatabase db;

  TakenImageDao(this.db) : super(db);

  Future<List<TakenImage>> getAllTakeImage() => select(takenImages).get();

  Stream<List<TakenImage>> watchAllTakenImage() => select(takenImages).watch();

  Future<List<TakenImage>> getAllTakenSiteId(int idBarn) =>
      (select(takenImages)..where((tbl) => tbl.idSite.equals(idBarn))).get();

  Future<List<TakenImage>> getAllTakenPenId(int idPen) =>
      (select(takenImages)..where((tbl) => tbl.idPen.equals(idPen))).get();

  Future<int> getCountPenBarnId(int id) async {
    List<TakenImage> taken = await getAllTakenPenId(id);
    return taken.length;
  }

  Stream<List<TakenImage>> watchAllTakenPenId(int idPen) {
    return (select(takenImages)
      ..where((tbl) => tbl.idPen.equals(idPen))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.id, mode: OrderingMode.desc)])
    ).watch();
  }

  Future insertTaken(TakenImage image) => into(takenImages).insert(image);

  Future updateTaken(TakenImage image) => update(takenImages).replace(image);

  Future deleteTaken(TakenImage image) => delete(takenImages).delete(image);
  Future deleteTakenById(int id) =>
      (delete(takenImages)..where((c) => c.id.equals(id))).go();
}

import 'package:moor/moor.dart';

class TakenImages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idSite => integer().customConstraint('NULL REFERENCES  sites(id) ON DELETE CASCADE')();
  IntColumn get idPen => integer().customConstraint('NULL REFERENCES  pens(id) ON DELETE CASCADE')();
  TextColumn get name => text().withLength(min: 1).nullable()();

  DateTimeColumn get updated => dateTime().nullable()();

  TextColumn get imagePath => text()();
}

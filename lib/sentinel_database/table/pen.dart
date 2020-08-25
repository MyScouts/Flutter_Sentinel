import 'package:moor/moor.dart';

class Pens extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get penName => text().nullable().withLength(min: 1)();

  DateTimeColumn get updated => dateTime()();

  IntColumn get idSite => integer()
      .customConstraint('NULL REFERENCES  sites(id) ON DELETE CASCADE')();

  TextColumn get imagePath => text().nullable()();

  IntColumn get idBarn => integer()
      .customConstraint('NULL REFERENCES barns(id) ON DELETE CASCADE')();
}

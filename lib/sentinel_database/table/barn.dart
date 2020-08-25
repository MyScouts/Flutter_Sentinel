import 'package:moor/moor.dart';

class Barns extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get barnName => text().withLength(min: 1)();

  IntColumn get idSite => integer()
      .customConstraint('NULL REFERENCES  sites(id) ON DELETE CASCADE')();

  DateTimeColumn get updated => dateTime()();

  TextColumn get imagePath => text().nullable()();

  IntColumn get penCount => integer().nullable()();
}

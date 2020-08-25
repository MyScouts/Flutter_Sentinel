import 'package:moor/moor.dart';

class Sites extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get siteName => text().withLength(min: 1)();

  DateTimeColumn get updated => dateTime()();
  TextColumn get imagePath => text().nullable()();

  IntColumn get siteOfBarn => integer().nullable()();

}

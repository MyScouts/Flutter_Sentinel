import 'package:moor/moor.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement().nullable()();

  TextColumn get email => text()();

  TextColumn get password => text().withLength(min: 6)();
}

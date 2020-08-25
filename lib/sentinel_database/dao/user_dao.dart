import 'package:moor/moor.dart';
import 'package:sentinel_app/sentinel_database/database/my_database.dart';
import 'package:sentinel_app/sentinel_database/table/user.dart';

part 'user_dao.g.dart';

@UseDao(tables: [Users])
class UserDao extends DatabaseAccessor<MyDatabase> with _$UserDaoMixin {
  final MyDatabase db;

  UserDao(this.db) : super(db);

  Stream<List<User>> watchUser() => select(users).watch();

  Future<List<User>> getAllUser() => select(users).get();

  Future insertUser(User user) => into(users).insert(user);

  Future updateUser(User user) => update(users).replace(user);

  Future deleteUser(User user) => delete(users).delete(user);

  Future<User> getUserEmail(String e) =>
      (select(db.users)..where((tbl) => tbl.email.equals(e))).getSingle();
}

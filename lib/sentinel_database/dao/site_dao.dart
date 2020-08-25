import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:sentinel_app/sentinel_database/database/my_database.dart';
import 'package:sentinel_app/sentinel_database/table/site.dart';

part 'site_dao.g.dart';

@UseDao(tables: [Sites])
class SiteDao extends DatabaseAccessor<MyDatabase> with _$SiteDaoMixin {
  final MyDatabase db;

  SiteDao(this.db) : super(db);

  Future<List<Site>> getAllSite() => select(sites).get();

  Stream<List<Site>> watchAllSite() => select(sites).watch();

  Future<Site> getSiteId(int id) =>
      (select(sites)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<Site> getSiteName(String name) =>
      (select(sites)..where((tbl) => tbl.siteName.equals(name))).getSingle();

  Future insertSite(Site site) => into(sites).insert(site);

  Future updateSite(Site site) => update(sites).replace(site);

  Future deleteSite(Site site) => delete(sites).delete(site);

  Future deleteSiteById(int id) =>
      (delete(sites)..where((c) => c.id.equals(id))).go();
}

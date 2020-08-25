// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final int id;
  final String email;
  final String password;
  User({this.id, @required this.email, @required this.password});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return User(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      password: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}password']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
    };
  }

  User copyWith({int id, String email, String password}) => User(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(email.hashCode, password.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.email == this.email &&
          other.password == this.password);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> email;
  final Value<String> password;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    @required String email,
    @required String password,
  })  : email = Value(email),
        password = Value(password);
  static Insertable<User> custom({
    Expression<int> id,
    Expression<String> email,
    Expression<String> password,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
    });
  }

  UsersCompanion copyWith(
      {Value<int> id, Value<String> email, Value<String> password}) {
    return UsersCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, true,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  GeneratedTextColumn _password;
  @override
  GeneratedTextColumn get password => _password ??= _constructPassword();
  GeneratedTextColumn _constructPassword() {
    return GeneratedTextColumn('password', $tableName, false, minTextLength: 6);
  }

  @override
  List<GeneratedColumn> get $columns => [id, email, password];
  @override
  $UsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password'], _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return User.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

class Site extends DataClass implements Insertable<Site> {
  final int id;
  final String siteName;
  final DateTime updated;
  final String imagePath;
  final int siteOfBarn;
  Site(
      {@required this.id,
      @required this.siteName,
      @required this.updated,
      this.imagePath,
      this.siteOfBarn});
  factory Site.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Site(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      siteName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}site_name']),
      updated: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated']),
      imagePath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_path']),
      siteOfBarn: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}site_of_barn']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || siteName != null) {
      map['site_name'] = Variable<String>(siteName);
    }
    if (!nullToAbsent || updated != null) {
      map['updated'] = Variable<DateTime>(updated);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || siteOfBarn != null) {
      map['site_of_barn'] = Variable<int>(siteOfBarn);
    }
    return map;
  }

  SitesCompanion toCompanion(bool nullToAbsent) {
    return SitesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      siteName: siteName == null && nullToAbsent
          ? const Value.absent()
          : Value(siteName),
      updated: updated == null && nullToAbsent
          ? const Value.absent()
          : Value(updated),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      siteOfBarn: siteOfBarn == null && nullToAbsent
          ? const Value.absent()
          : Value(siteOfBarn),
    );
  }

  factory Site.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Site(
      id: serializer.fromJson<int>(json['id']),
      siteName: serializer.fromJson<String>(json['siteName']),
      updated: serializer.fromJson<DateTime>(json['updated']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      siteOfBarn: serializer.fromJson<int>(json['siteOfBarn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'siteName': serializer.toJson<String>(siteName),
      'updated': serializer.toJson<DateTime>(updated),
      'imagePath': serializer.toJson<String>(imagePath),
      'siteOfBarn': serializer.toJson<int>(siteOfBarn),
    };
  }

  Site copyWith(
          {int id,
          String siteName,
          DateTime updated,
          String imagePath,
          int siteOfBarn}) =>
      Site(
        id: id ?? this.id,
        siteName: siteName ?? this.siteName,
        updated: updated ?? this.updated,
        imagePath: imagePath ?? this.imagePath,
        siteOfBarn: siteOfBarn ?? this.siteOfBarn,
      );
  @override
  String toString() {
    return (StringBuffer('Site(')
          ..write('id: $id, ')
          ..write('siteName: $siteName, ')
          ..write('updated: $updated, ')
          ..write('imagePath: $imagePath, ')
          ..write('siteOfBarn: $siteOfBarn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          siteName.hashCode,
          $mrjc(updated.hashCode,
              $mrjc(imagePath.hashCode, siteOfBarn.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Site &&
          other.id == this.id &&
          other.siteName == this.siteName &&
          other.updated == this.updated &&
          other.imagePath == this.imagePath &&
          other.siteOfBarn == this.siteOfBarn);
}

class SitesCompanion extends UpdateCompanion<Site> {
  final Value<int> id;
  final Value<String> siteName;
  final Value<DateTime> updated;
  final Value<String> imagePath;
  final Value<int> siteOfBarn;
  const SitesCompanion({
    this.id = const Value.absent(),
    this.siteName = const Value.absent(),
    this.updated = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.siteOfBarn = const Value.absent(),
  });
  SitesCompanion.insert({
    this.id = const Value.absent(),
    @required String siteName,
    @required DateTime updated,
    this.imagePath = const Value.absent(),
    this.siteOfBarn = const Value.absent(),
  })  : siteName = Value(siteName),
        updated = Value(updated);
  static Insertable<Site> custom({
    Expression<int> id,
    Expression<String> siteName,
    Expression<DateTime> updated,
    Expression<String> imagePath,
    Expression<int> siteOfBarn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (siteName != null) 'site_name': siteName,
      if (updated != null) 'updated': updated,
      if (imagePath != null) 'image_path': imagePath,
      if (siteOfBarn != null) 'site_of_barn': siteOfBarn,
    });
  }

  SitesCompanion copyWith(
      {Value<int> id,
      Value<String> siteName,
      Value<DateTime> updated,
      Value<String> imagePath,
      Value<int> siteOfBarn}) {
    return SitesCompanion(
      id: id ?? this.id,
      siteName: siteName ?? this.siteName,
      updated: updated ?? this.updated,
      imagePath: imagePath ?? this.imagePath,
      siteOfBarn: siteOfBarn ?? this.siteOfBarn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (siteName.present) {
      map['site_name'] = Variable<String>(siteName.value);
    }
    if (updated.present) {
      map['updated'] = Variable<DateTime>(updated.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (siteOfBarn.present) {
      map['site_of_barn'] = Variable<int>(siteOfBarn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SitesCompanion(')
          ..write('id: $id, ')
          ..write('siteName: $siteName, ')
          ..write('updated: $updated, ')
          ..write('imagePath: $imagePath, ')
          ..write('siteOfBarn: $siteOfBarn')
          ..write(')'))
        .toString();
  }
}

class $SitesTable extends Sites with TableInfo<$SitesTable, Site> {
  final GeneratedDatabase _db;
  final String _alias;
  $SitesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _siteNameMeta = const VerificationMeta('siteName');
  GeneratedTextColumn _siteName;
  @override
  GeneratedTextColumn get siteName => _siteName ??= _constructSiteName();
  GeneratedTextColumn _constructSiteName() {
    return GeneratedTextColumn('site_name', $tableName, false,
        minTextLength: 1);
  }

  final VerificationMeta _updatedMeta = const VerificationMeta('updated');
  GeneratedDateTimeColumn _updated;
  @override
  GeneratedDateTimeColumn get updated => _updated ??= _constructUpdated();
  GeneratedDateTimeColumn _constructUpdated() {
    return GeneratedDateTimeColumn(
      'updated',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imagePathMeta = const VerificationMeta('imagePath');
  GeneratedTextColumn _imagePath;
  @override
  GeneratedTextColumn get imagePath => _imagePath ??= _constructImagePath();
  GeneratedTextColumn _constructImagePath() {
    return GeneratedTextColumn(
      'image_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _siteOfBarnMeta = const VerificationMeta('siteOfBarn');
  GeneratedIntColumn _siteOfBarn;
  @override
  GeneratedIntColumn get siteOfBarn => _siteOfBarn ??= _constructSiteOfBarn();
  GeneratedIntColumn _constructSiteOfBarn() {
    return GeneratedIntColumn(
      'site_of_barn',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, siteName, updated, imagePath, siteOfBarn];
  @override
  $SitesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'sites';
  @override
  final String actualTableName = 'sites';
  @override
  VerificationContext validateIntegrity(Insertable<Site> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('site_name')) {
      context.handle(_siteNameMeta,
          siteName.isAcceptableOrUnknown(data['site_name'], _siteNameMeta));
    } else if (isInserting) {
      context.missing(_siteNameMeta);
    }
    if (data.containsKey('updated')) {
      context.handle(_updatedMeta,
          updated.isAcceptableOrUnknown(data['updated'], _updatedMeta));
    } else if (isInserting) {
      context.missing(_updatedMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path'], _imagePathMeta));
    }
    if (data.containsKey('site_of_barn')) {
      context.handle(
          _siteOfBarnMeta,
          siteOfBarn.isAcceptableOrUnknown(
              data['site_of_barn'], _siteOfBarnMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Site map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Site.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SitesTable createAlias(String alias) {
    return $SitesTable(_db, alias);
  }
}

class Barn extends DataClass implements Insertable<Barn> {
  final int id;
  final String barnName;
  final int idSite;
  final DateTime updated;
  final String imagePath;
  final int penCount;
  Barn(
      {@required this.id,
      @required this.barnName,
      @required this.idSite,
      @required this.updated,
      this.imagePath,
      this.penCount});
  factory Barn.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Barn(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      barnName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}barn_name']),
      idSite:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_site']),
      updated: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated']),
      imagePath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_path']),
      penCount:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}pen_count']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || barnName != null) {
      map['barn_name'] = Variable<String>(barnName);
    }
    if (!nullToAbsent || idSite != null) {
      map['id_site'] = Variable<int>(idSite);
    }
    if (!nullToAbsent || updated != null) {
      map['updated'] = Variable<DateTime>(updated);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || penCount != null) {
      map['pen_count'] = Variable<int>(penCount);
    }
    return map;
  }

  BarnsCompanion toCompanion(bool nullToAbsent) {
    return BarnsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      barnName: barnName == null && nullToAbsent
          ? const Value.absent()
          : Value(barnName),
      idSite:
          idSite == null && nullToAbsent ? const Value.absent() : Value(idSite),
      updated: updated == null && nullToAbsent
          ? const Value.absent()
          : Value(updated),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      penCount: penCount == null && nullToAbsent
          ? const Value.absent()
          : Value(penCount),
    );
  }

  factory Barn.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Barn(
      id: serializer.fromJson<int>(json['id']),
      barnName: serializer.fromJson<String>(json['barnName']),
      idSite: serializer.fromJson<int>(json['idSite']),
      updated: serializer.fromJson<DateTime>(json['updated']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      penCount: serializer.fromJson<int>(json['penCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'barnName': serializer.toJson<String>(barnName),
      'idSite': serializer.toJson<int>(idSite),
      'updated': serializer.toJson<DateTime>(updated),
      'imagePath': serializer.toJson<String>(imagePath),
      'penCount': serializer.toJson<int>(penCount),
    };
  }

  Barn copyWith(
          {int id,
          String barnName,
          int idSite,
          DateTime updated,
          String imagePath,
          int penCount}) =>
      Barn(
        id: id ?? this.id,
        barnName: barnName ?? this.barnName,
        idSite: idSite ?? this.idSite,
        updated: updated ?? this.updated,
        imagePath: imagePath ?? this.imagePath,
        penCount: penCount ?? this.penCount,
      );
  @override
  String toString() {
    return (StringBuffer('Barn(')
          ..write('id: $id, ')
          ..write('barnName: $barnName, ')
          ..write('idSite: $idSite, ')
          ..write('updated: $updated, ')
          ..write('imagePath: $imagePath, ')
          ..write('penCount: $penCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          barnName.hashCode,
          $mrjc(
              idSite.hashCode,
              $mrjc(updated.hashCode,
                  $mrjc(imagePath.hashCode, penCount.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Barn &&
          other.id == this.id &&
          other.barnName == this.barnName &&
          other.idSite == this.idSite &&
          other.updated == this.updated &&
          other.imagePath == this.imagePath &&
          other.penCount == this.penCount);
}

class BarnsCompanion extends UpdateCompanion<Barn> {
  final Value<int> id;
  final Value<String> barnName;
  final Value<int> idSite;
  final Value<DateTime> updated;
  final Value<String> imagePath;
  final Value<int> penCount;
  const BarnsCompanion({
    this.id = const Value.absent(),
    this.barnName = const Value.absent(),
    this.idSite = const Value.absent(),
    this.updated = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.penCount = const Value.absent(),
  });
  BarnsCompanion.insert({
    this.id = const Value.absent(),
    @required String barnName,
    @required int idSite,
    @required DateTime updated,
    this.imagePath = const Value.absent(),
    this.penCount = const Value.absent(),
  })  : barnName = Value(barnName),
        idSite = Value(idSite),
        updated = Value(updated);
  static Insertable<Barn> custom({
    Expression<int> id,
    Expression<String> barnName,
    Expression<int> idSite,
    Expression<DateTime> updated,
    Expression<String> imagePath,
    Expression<int> penCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (barnName != null) 'barn_name': barnName,
      if (idSite != null) 'id_site': idSite,
      if (updated != null) 'updated': updated,
      if (imagePath != null) 'image_path': imagePath,
      if (penCount != null) 'pen_count': penCount,
    });
  }

  BarnsCompanion copyWith(
      {Value<int> id,
      Value<String> barnName,
      Value<int> idSite,
      Value<DateTime> updated,
      Value<String> imagePath,
      Value<int> penCount}) {
    return BarnsCompanion(
      id: id ?? this.id,
      barnName: barnName ?? this.barnName,
      idSite: idSite ?? this.idSite,
      updated: updated ?? this.updated,
      imagePath: imagePath ?? this.imagePath,
      penCount: penCount ?? this.penCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (barnName.present) {
      map['barn_name'] = Variable<String>(barnName.value);
    }
    if (idSite.present) {
      map['id_site'] = Variable<int>(idSite.value);
    }
    if (updated.present) {
      map['updated'] = Variable<DateTime>(updated.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (penCount.present) {
      map['pen_count'] = Variable<int>(penCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BarnsCompanion(')
          ..write('id: $id, ')
          ..write('barnName: $barnName, ')
          ..write('idSite: $idSite, ')
          ..write('updated: $updated, ')
          ..write('imagePath: $imagePath, ')
          ..write('penCount: $penCount')
          ..write(')'))
        .toString();
  }
}

class $BarnsTable extends Barns with TableInfo<$BarnsTable, Barn> {
  final GeneratedDatabase _db;
  final String _alias;
  $BarnsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _barnNameMeta = const VerificationMeta('barnName');
  GeneratedTextColumn _barnName;
  @override
  GeneratedTextColumn get barnName => _barnName ??= _constructBarnName();
  GeneratedTextColumn _constructBarnName() {
    return GeneratedTextColumn('barn_name', $tableName, false,
        minTextLength: 1);
  }

  final VerificationMeta _idSiteMeta = const VerificationMeta('idSite');
  GeneratedIntColumn _idSite;
  @override
  GeneratedIntColumn get idSite => _idSite ??= _constructIdSite();
  GeneratedIntColumn _constructIdSite() {
    return GeneratedIntColumn('id_site', $tableName, false,
        $customConstraints: 'NULL REFERENCES  sites(id) ON DELETE CASCADE');
  }

  final VerificationMeta _updatedMeta = const VerificationMeta('updated');
  GeneratedDateTimeColumn _updated;
  @override
  GeneratedDateTimeColumn get updated => _updated ??= _constructUpdated();
  GeneratedDateTimeColumn _constructUpdated() {
    return GeneratedDateTimeColumn(
      'updated',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imagePathMeta = const VerificationMeta('imagePath');
  GeneratedTextColumn _imagePath;
  @override
  GeneratedTextColumn get imagePath => _imagePath ??= _constructImagePath();
  GeneratedTextColumn _constructImagePath() {
    return GeneratedTextColumn(
      'image_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _penCountMeta = const VerificationMeta('penCount');
  GeneratedIntColumn _penCount;
  @override
  GeneratedIntColumn get penCount => _penCount ??= _constructPenCount();
  GeneratedIntColumn _constructPenCount() {
    return GeneratedIntColumn(
      'pen_count',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, barnName, idSite, updated, imagePath, penCount];
  @override
  $BarnsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'barns';
  @override
  final String actualTableName = 'barns';
  @override
  VerificationContext validateIntegrity(Insertable<Barn> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('barn_name')) {
      context.handle(_barnNameMeta,
          barnName.isAcceptableOrUnknown(data['barn_name'], _barnNameMeta));
    } else if (isInserting) {
      context.missing(_barnNameMeta);
    }
    if (data.containsKey('id_site')) {
      context.handle(_idSiteMeta,
          idSite.isAcceptableOrUnknown(data['id_site'], _idSiteMeta));
    } else if (isInserting) {
      context.missing(_idSiteMeta);
    }
    if (data.containsKey('updated')) {
      context.handle(_updatedMeta,
          updated.isAcceptableOrUnknown(data['updated'], _updatedMeta));
    } else if (isInserting) {
      context.missing(_updatedMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path'], _imagePathMeta));
    }
    if (data.containsKey('pen_count')) {
      context.handle(_penCountMeta,
          penCount.isAcceptableOrUnknown(data['pen_count'], _penCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Barn map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Barn.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $BarnsTable createAlias(String alias) {
    return $BarnsTable(_db, alias);
  }
}

class Pen extends DataClass implements Insertable<Pen> {
  final int id;
  final String penName;
  final DateTime updated;
  final int idSite;
  final String imagePath;
  final int idBarn;
  Pen(
      {@required this.id,
      this.penName,
      @required this.updated,
      @required this.idSite,
      this.imagePath,
      @required this.idBarn});
  factory Pen.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Pen(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      penName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}pen_name']),
      updated: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated']),
      idSite:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_site']),
      imagePath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_path']),
      idBarn:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_barn']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || penName != null) {
      map['pen_name'] = Variable<String>(penName);
    }
    if (!nullToAbsent || updated != null) {
      map['updated'] = Variable<DateTime>(updated);
    }
    if (!nullToAbsent || idSite != null) {
      map['id_site'] = Variable<int>(idSite);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || idBarn != null) {
      map['id_barn'] = Variable<int>(idBarn);
    }
    return map;
  }

  PensCompanion toCompanion(bool nullToAbsent) {
    return PensCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      penName: penName == null && nullToAbsent
          ? const Value.absent()
          : Value(penName),
      updated: updated == null && nullToAbsent
          ? const Value.absent()
          : Value(updated),
      idSite:
          idSite == null && nullToAbsent ? const Value.absent() : Value(idSite),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      idBarn:
          idBarn == null && nullToAbsent ? const Value.absent() : Value(idBarn),
    );
  }

  factory Pen.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Pen(
      id: serializer.fromJson<int>(json['id']),
      penName: serializer.fromJson<String>(json['penName']),
      updated: serializer.fromJson<DateTime>(json['updated']),
      idSite: serializer.fromJson<int>(json['idSite']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      idBarn: serializer.fromJson<int>(json['idBarn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'penName': serializer.toJson<String>(penName),
      'updated': serializer.toJson<DateTime>(updated),
      'idSite': serializer.toJson<int>(idSite),
      'imagePath': serializer.toJson<String>(imagePath),
      'idBarn': serializer.toJson<int>(idBarn),
    };
  }

  Pen copyWith(
          {int id,
          String penName,
          DateTime updated,
          int idSite,
          String imagePath,
          int idBarn}) =>
      Pen(
        id: id ?? this.id,
        penName: penName ?? this.penName,
        updated: updated ?? this.updated,
        idSite: idSite ?? this.idSite,
        imagePath: imagePath ?? this.imagePath,
        idBarn: idBarn ?? this.idBarn,
      );
  @override
  String toString() {
    return (StringBuffer('Pen(')
          ..write('id: $id, ')
          ..write('penName: $penName, ')
          ..write('updated: $updated, ')
          ..write('idSite: $idSite, ')
          ..write('imagePath: $imagePath, ')
          ..write('idBarn: $idBarn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          penName.hashCode,
          $mrjc(
              updated.hashCode,
              $mrjc(idSite.hashCode,
                  $mrjc(imagePath.hashCode, idBarn.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Pen &&
          other.id == this.id &&
          other.penName == this.penName &&
          other.updated == this.updated &&
          other.idSite == this.idSite &&
          other.imagePath == this.imagePath &&
          other.idBarn == this.idBarn);
}

class PensCompanion extends UpdateCompanion<Pen> {
  final Value<int> id;
  final Value<String> penName;
  final Value<DateTime> updated;
  final Value<int> idSite;
  final Value<String> imagePath;
  final Value<int> idBarn;
  const PensCompanion({
    this.id = const Value.absent(),
    this.penName = const Value.absent(),
    this.updated = const Value.absent(),
    this.idSite = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.idBarn = const Value.absent(),
  });
  PensCompanion.insert({
    this.id = const Value.absent(),
    this.penName = const Value.absent(),
    @required DateTime updated,
    @required int idSite,
    this.imagePath = const Value.absent(),
    @required int idBarn,
  })  : updated = Value(updated),
        idSite = Value(idSite),
        idBarn = Value(idBarn);
  static Insertable<Pen> custom({
    Expression<int> id,
    Expression<String> penName,
    Expression<DateTime> updated,
    Expression<int> idSite,
    Expression<String> imagePath,
    Expression<int> idBarn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (penName != null) 'pen_name': penName,
      if (updated != null) 'updated': updated,
      if (idSite != null) 'id_site': idSite,
      if (imagePath != null) 'image_path': imagePath,
      if (idBarn != null) 'id_barn': idBarn,
    });
  }

  PensCompanion copyWith(
      {Value<int> id,
      Value<String> penName,
      Value<DateTime> updated,
      Value<int> idSite,
      Value<String> imagePath,
      Value<int> idBarn}) {
    return PensCompanion(
      id: id ?? this.id,
      penName: penName ?? this.penName,
      updated: updated ?? this.updated,
      idSite: idSite ?? this.idSite,
      imagePath: imagePath ?? this.imagePath,
      idBarn: idBarn ?? this.idBarn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (penName.present) {
      map['pen_name'] = Variable<String>(penName.value);
    }
    if (updated.present) {
      map['updated'] = Variable<DateTime>(updated.value);
    }
    if (idSite.present) {
      map['id_site'] = Variable<int>(idSite.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (idBarn.present) {
      map['id_barn'] = Variable<int>(idBarn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PensCompanion(')
          ..write('id: $id, ')
          ..write('penName: $penName, ')
          ..write('updated: $updated, ')
          ..write('idSite: $idSite, ')
          ..write('imagePath: $imagePath, ')
          ..write('idBarn: $idBarn')
          ..write(')'))
        .toString();
  }
}

class $PensTable extends Pens with TableInfo<$PensTable, Pen> {
  final GeneratedDatabase _db;
  final String _alias;
  $PensTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _penNameMeta = const VerificationMeta('penName');
  GeneratedTextColumn _penName;
  @override
  GeneratedTextColumn get penName => _penName ??= _constructPenName();
  GeneratedTextColumn _constructPenName() {
    return GeneratedTextColumn('pen_name', $tableName, true, minTextLength: 1);
  }

  final VerificationMeta _updatedMeta = const VerificationMeta('updated');
  GeneratedDateTimeColumn _updated;
  @override
  GeneratedDateTimeColumn get updated => _updated ??= _constructUpdated();
  GeneratedDateTimeColumn _constructUpdated() {
    return GeneratedDateTimeColumn(
      'updated',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idSiteMeta = const VerificationMeta('idSite');
  GeneratedIntColumn _idSite;
  @override
  GeneratedIntColumn get idSite => _idSite ??= _constructIdSite();
  GeneratedIntColumn _constructIdSite() {
    return GeneratedIntColumn('id_site', $tableName, false,
        $customConstraints: 'NULL REFERENCES  sites(id) ON DELETE CASCADE');
  }

  final VerificationMeta _imagePathMeta = const VerificationMeta('imagePath');
  GeneratedTextColumn _imagePath;
  @override
  GeneratedTextColumn get imagePath => _imagePath ??= _constructImagePath();
  GeneratedTextColumn _constructImagePath() {
    return GeneratedTextColumn(
      'image_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _idBarnMeta = const VerificationMeta('idBarn');
  GeneratedIntColumn _idBarn;
  @override
  GeneratedIntColumn get idBarn => _idBarn ??= _constructIdBarn();
  GeneratedIntColumn _constructIdBarn() {
    return GeneratedIntColumn('id_barn', $tableName, false,
        $customConstraints: 'NULL REFERENCES barns(id) ON DELETE CASCADE');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, penName, updated, idSite, imagePath, idBarn];
  @override
  $PensTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'pens';
  @override
  final String actualTableName = 'pens';
  @override
  VerificationContext validateIntegrity(Insertable<Pen> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('pen_name')) {
      context.handle(_penNameMeta,
          penName.isAcceptableOrUnknown(data['pen_name'], _penNameMeta));
    }
    if (data.containsKey('updated')) {
      context.handle(_updatedMeta,
          updated.isAcceptableOrUnknown(data['updated'], _updatedMeta));
    } else if (isInserting) {
      context.missing(_updatedMeta);
    }
    if (data.containsKey('id_site')) {
      context.handle(_idSiteMeta,
          idSite.isAcceptableOrUnknown(data['id_site'], _idSiteMeta));
    } else if (isInserting) {
      context.missing(_idSiteMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path'], _imagePathMeta));
    }
    if (data.containsKey('id_barn')) {
      context.handle(_idBarnMeta,
          idBarn.isAcceptableOrUnknown(data['id_barn'], _idBarnMeta));
    } else if (isInserting) {
      context.missing(_idBarnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pen map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Pen.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PensTable createAlias(String alias) {
    return $PensTable(_db, alias);
  }
}

class TakenImage extends DataClass implements Insertable<TakenImage> {
  final int id;
  final int idSite;
  final int idPen;
  final String name;
  final DateTime updated;
  final String imagePath;
  TakenImage(
      {@required this.id,
      @required this.idSite,
      @required this.idPen,
      this.name,
      this.updated,
      @required this.imagePath});
  factory TakenImage.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return TakenImage(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      idSite:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}id_site']),
      idPen: intType.mapFromDatabaseResponse(data['${effectivePrefix}id_pen']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      updated: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated']),
      imagePath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_path']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || idSite != null) {
      map['id_site'] = Variable<int>(idSite);
    }
    if (!nullToAbsent || idPen != null) {
      map['id_pen'] = Variable<int>(idPen);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || updated != null) {
      map['updated'] = Variable<DateTime>(updated);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    return map;
  }

  TakenImagesCompanion toCompanion(bool nullToAbsent) {
    return TakenImagesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idSite:
          idSite == null && nullToAbsent ? const Value.absent() : Value(idSite),
      idPen:
          idPen == null && nullToAbsent ? const Value.absent() : Value(idPen),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      updated: updated == null && nullToAbsent
          ? const Value.absent()
          : Value(updated),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
    );
  }

  factory TakenImage.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TakenImage(
      id: serializer.fromJson<int>(json['id']),
      idSite: serializer.fromJson<int>(json['idSite']),
      idPen: serializer.fromJson<int>(json['idPen']),
      name: serializer.fromJson<String>(json['name']),
      updated: serializer.fromJson<DateTime>(json['updated']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idSite': serializer.toJson<int>(idSite),
      'idPen': serializer.toJson<int>(idPen),
      'name': serializer.toJson<String>(name),
      'updated': serializer.toJson<DateTime>(updated),
      'imagePath': serializer.toJson<String>(imagePath),
    };
  }

  TakenImage copyWith(
          {int id,
          int idSite,
          int idPen,
          String name,
          DateTime updated,
          String imagePath}) =>
      TakenImage(
        id: id ?? this.id,
        idSite: idSite ?? this.idSite,
        idPen: idPen ?? this.idPen,
        name: name ?? this.name,
        updated: updated ?? this.updated,
        imagePath: imagePath ?? this.imagePath,
      );
  @override
  String toString() {
    return (StringBuffer('TakenImage(')
          ..write('id: $id, ')
          ..write('idSite: $idSite, ')
          ..write('idPen: $idPen, ')
          ..write('name: $name, ')
          ..write('updated: $updated, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          idSite.hashCode,
          $mrjc(
              idPen.hashCode,
              $mrjc(name.hashCode,
                  $mrjc(updated.hashCode, imagePath.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TakenImage &&
          other.id == this.id &&
          other.idSite == this.idSite &&
          other.idPen == this.idPen &&
          other.name == this.name &&
          other.updated == this.updated &&
          other.imagePath == this.imagePath);
}

class TakenImagesCompanion extends UpdateCompanion<TakenImage> {
  final Value<int> id;
  final Value<int> idSite;
  final Value<int> idPen;
  final Value<String> name;
  final Value<DateTime> updated;
  final Value<String> imagePath;
  const TakenImagesCompanion({
    this.id = const Value.absent(),
    this.idSite = const Value.absent(),
    this.idPen = const Value.absent(),
    this.name = const Value.absent(),
    this.updated = const Value.absent(),
    this.imagePath = const Value.absent(),
  });
  TakenImagesCompanion.insert({
    this.id = const Value.absent(),
    @required int idSite,
    @required int idPen,
    this.name = const Value.absent(),
    this.updated = const Value.absent(),
    @required String imagePath,
  })  : idSite = Value(idSite),
        idPen = Value(idPen),
        imagePath = Value(imagePath);
  static Insertable<TakenImage> custom({
    Expression<int> id,
    Expression<int> idSite,
    Expression<int> idPen,
    Expression<String> name,
    Expression<DateTime> updated,
    Expression<String> imagePath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idSite != null) 'id_site': idSite,
      if (idPen != null) 'id_pen': idPen,
      if (name != null) 'name': name,
      if (updated != null) 'updated': updated,
      if (imagePath != null) 'image_path': imagePath,
    });
  }

  TakenImagesCompanion copyWith(
      {Value<int> id,
      Value<int> idSite,
      Value<int> idPen,
      Value<String> name,
      Value<DateTime> updated,
      Value<String> imagePath}) {
    return TakenImagesCompanion(
      id: id ?? this.id,
      idSite: idSite ?? this.idSite,
      idPen: idPen ?? this.idPen,
      name: name ?? this.name,
      updated: updated ?? this.updated,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idSite.present) {
      map['id_site'] = Variable<int>(idSite.value);
    }
    if (idPen.present) {
      map['id_pen'] = Variable<int>(idPen.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (updated.present) {
      map['updated'] = Variable<DateTime>(updated.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TakenImagesCompanion(')
          ..write('id: $id, ')
          ..write('idSite: $idSite, ')
          ..write('idPen: $idPen, ')
          ..write('name: $name, ')
          ..write('updated: $updated, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }
}

class $TakenImagesTable extends TakenImages
    with TableInfo<$TakenImagesTable, TakenImage> {
  final GeneratedDatabase _db;
  final String _alias;
  $TakenImagesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _idSiteMeta = const VerificationMeta('idSite');
  GeneratedIntColumn _idSite;
  @override
  GeneratedIntColumn get idSite => _idSite ??= _constructIdSite();
  GeneratedIntColumn _constructIdSite() {
    return GeneratedIntColumn('id_site', $tableName, false,
        $customConstraints: 'NULL REFERENCES  sites(id) ON DELETE CASCADE');
  }

  final VerificationMeta _idPenMeta = const VerificationMeta('idPen');
  GeneratedIntColumn _idPen;
  @override
  GeneratedIntColumn get idPen => _idPen ??= _constructIdPen();
  GeneratedIntColumn _constructIdPen() {
    return GeneratedIntColumn('id_pen', $tableName, false,
        $customConstraints: 'NULL REFERENCES  pens(id) ON DELETE CASCADE');
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, true, minTextLength: 1);
  }

  final VerificationMeta _updatedMeta = const VerificationMeta('updated');
  GeneratedDateTimeColumn _updated;
  @override
  GeneratedDateTimeColumn get updated => _updated ??= _constructUpdated();
  GeneratedDateTimeColumn _constructUpdated() {
    return GeneratedDateTimeColumn(
      'updated',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imagePathMeta = const VerificationMeta('imagePath');
  GeneratedTextColumn _imagePath;
  @override
  GeneratedTextColumn get imagePath => _imagePath ??= _constructImagePath();
  GeneratedTextColumn _constructImagePath() {
    return GeneratedTextColumn(
      'image_path',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, idSite, idPen, name, updated, imagePath];
  @override
  $TakenImagesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'taken_images';
  @override
  final String actualTableName = 'taken_images';
  @override
  VerificationContext validateIntegrity(Insertable<TakenImage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('id_site')) {
      context.handle(_idSiteMeta,
          idSite.isAcceptableOrUnknown(data['id_site'], _idSiteMeta));
    } else if (isInserting) {
      context.missing(_idSiteMeta);
    }
    if (data.containsKey('id_pen')) {
      context.handle(
          _idPenMeta, idPen.isAcceptableOrUnknown(data['id_pen'], _idPenMeta));
    } else if (isInserting) {
      context.missing(_idPenMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    }
    if (data.containsKey('updated')) {
      context.handle(_updatedMeta,
          updated.isAcceptableOrUnknown(data['updated'], _updatedMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path'], _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TakenImage map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TakenImage.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TakenImagesTable createAlias(String alias) {
    return $TakenImagesTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  $SitesTable _sites;
  $SitesTable get sites => _sites ??= $SitesTable(this);
  $BarnsTable _barns;
  $BarnsTable get barns => _barns ??= $BarnsTable(this);
  $PensTable _pens;
  $PensTable get pens => _pens ??= $PensTable(this);
  $TakenImagesTable _takenImages;
  $TakenImagesTable get takenImages => _takenImages ??= $TakenImagesTable(this);
  UserDao _userDao;
  UserDao get userDao => _userDao ??= UserDao(this as MyDatabase);
  SiteDao _siteDao;
  SiteDao get siteDao => _siteDao ??= SiteDao(this as MyDatabase);
  BarnDao _barnDao;
  BarnDao get barnDao => _barnDao ??= BarnDao(this as MyDatabase);
  PenDao _penDao;
  PenDao get penDao => _penDao ??= PenDao(this as MyDatabase);
  TakenImageDao _takenImageDao;
  TakenImageDao get takenImageDao =>
      _takenImageDao ??= TakenImageDao(this as MyDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, sites, barns, pens, takenImages];
}

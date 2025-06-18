// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FavoriteTeamsTable extends FavoriteTeams
    with TableInfo<$FavoriteTeamsTable, FavoriteTeam> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteTeamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shortNameMeta = const VerificationMeta(
    'shortName',
  );
  @override
  late final GeneratedColumn<String> shortName = GeneratedColumn<String>(
    'short_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tlaMeta = const VerificationMeta('tla');
  @override
  late final GeneratedColumn<String> tla = GeneratedColumn<String>(
    'tla',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _crestMeta = const VerificationMeta('crest');
  @override
  late final GeneratedColumn<String> crest = GeneratedColumn<String>(
    'crest',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueMeta = const VerificationMeta('venue');
  @override
  late final GeneratedColumn<String> venue = GeneratedColumn<String>(
    'venue',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _foundedMeta = const VerificationMeta(
    'founded',
  );
  @override
  late final GeneratedColumn<int> founded = GeneratedColumn<int>(
    'founded',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clubColorsMeta = const VerificationMeta(
    'clubColors',
  );
  @override
  late final GeneratedColumn<String> clubColors = GeneratedColumn<String>(
    'club_colors',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    shortName,
    tla,
    crest,
    venue,
    founded,
    clubColors,
    addedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_teams';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteTeam> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('short_name')) {
      context.handle(
        _shortNameMeta,
        shortName.isAcceptableOrUnknown(data['short_name']!, _shortNameMeta),
      );
    } else if (isInserting) {
      context.missing(_shortNameMeta);
    }
    if (data.containsKey('tla')) {
      context.handle(
        _tlaMeta,
        tla.isAcceptableOrUnknown(data['tla']!, _tlaMeta),
      );
    } else if (isInserting) {
      context.missing(_tlaMeta);
    }
    if (data.containsKey('crest')) {
      context.handle(
        _crestMeta,
        crest.isAcceptableOrUnknown(data['crest']!, _crestMeta),
      );
    } else if (isInserting) {
      context.missing(_crestMeta);
    }
    if (data.containsKey('venue')) {
      context.handle(
        _venueMeta,
        venue.isAcceptableOrUnknown(data['venue']!, _venueMeta),
      );
    }
    if (data.containsKey('founded')) {
      context.handle(
        _foundedMeta,
        founded.isAcceptableOrUnknown(data['founded']!, _foundedMeta),
      );
    }
    if (data.containsKey('club_colors')) {
      context.handle(
        _clubColorsMeta,
        clubColors.isAcceptableOrUnknown(data['club_colors']!, _clubColorsMeta),
      );
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteTeam map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteTeam(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      shortName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}short_name'],
      )!,
      tla: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tla'],
      )!,
      crest: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}crest'],
      )!,
      venue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue'],
      ),
      founded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}founded'],
      ),
      clubColors: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}club_colors'],
      ),
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_at'],
      )!,
    );
  }

  @override
  $FavoriteTeamsTable createAlias(String alias) {
    return $FavoriteTeamsTable(attachedDatabase, alias);
  }
}

class FavoriteTeam extends DataClass implements Insertable<FavoriteTeam> {
  final int id;
  final String name;
  final String shortName;
  final String tla;
  final String crest;
  final String? venue;
  final int? founded;
  final String? clubColors;
  final DateTime addedAt;
  const FavoriteTeam({
    required this.id,
    required this.name,
    required this.shortName,
    required this.tla,
    required this.crest,
    this.venue,
    this.founded,
    this.clubColors,
    required this.addedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['short_name'] = Variable<String>(shortName);
    map['tla'] = Variable<String>(tla);
    map['crest'] = Variable<String>(crest);
    if (!nullToAbsent || venue != null) {
      map['venue'] = Variable<String>(venue);
    }
    if (!nullToAbsent || founded != null) {
      map['founded'] = Variable<int>(founded);
    }
    if (!nullToAbsent || clubColors != null) {
      map['club_colors'] = Variable<String>(clubColors);
    }
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  FavoriteTeamsCompanion toCompanion(bool nullToAbsent) {
    return FavoriteTeamsCompanion(
      id: Value(id),
      name: Value(name),
      shortName: Value(shortName),
      tla: Value(tla),
      crest: Value(crest),
      venue: venue == null && nullToAbsent
          ? const Value.absent()
          : Value(venue),
      founded: founded == null && nullToAbsent
          ? const Value.absent()
          : Value(founded),
      clubColors: clubColors == null && nullToAbsent
          ? const Value.absent()
          : Value(clubColors),
      addedAt: Value(addedAt),
    );
  }

  factory FavoriteTeam.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteTeam(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      shortName: serializer.fromJson<String>(json['shortName']),
      tla: serializer.fromJson<String>(json['tla']),
      crest: serializer.fromJson<String>(json['crest']),
      venue: serializer.fromJson<String?>(json['venue']),
      founded: serializer.fromJson<int?>(json['founded']),
      clubColors: serializer.fromJson<String?>(json['clubColors']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'shortName': serializer.toJson<String>(shortName),
      'tla': serializer.toJson<String>(tla),
      'crest': serializer.toJson<String>(crest),
      'venue': serializer.toJson<String?>(venue),
      'founded': serializer.toJson<int?>(founded),
      'clubColors': serializer.toJson<String?>(clubColors),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  FavoriteTeam copyWith({
    int? id,
    String? name,
    String? shortName,
    String? tla,
    String? crest,
    Value<String?> venue = const Value.absent(),
    Value<int?> founded = const Value.absent(),
    Value<String?> clubColors = const Value.absent(),
    DateTime? addedAt,
  }) => FavoriteTeam(
    id: id ?? this.id,
    name: name ?? this.name,
    shortName: shortName ?? this.shortName,
    tla: tla ?? this.tla,
    crest: crest ?? this.crest,
    venue: venue.present ? venue.value : this.venue,
    founded: founded.present ? founded.value : this.founded,
    clubColors: clubColors.present ? clubColors.value : this.clubColors,
    addedAt: addedAt ?? this.addedAt,
  );
  FavoriteTeam copyWithCompanion(FavoriteTeamsCompanion data) {
    return FavoriteTeam(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      shortName: data.shortName.present ? data.shortName.value : this.shortName,
      tla: data.tla.present ? data.tla.value : this.tla,
      crest: data.crest.present ? data.crest.value : this.crest,
      venue: data.venue.present ? data.venue.value : this.venue,
      founded: data.founded.present ? data.founded.value : this.founded,
      clubColors: data.clubColors.present
          ? data.clubColors.value
          : this.clubColors,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteTeam(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shortName: $shortName, ')
          ..write('tla: $tla, ')
          ..write('crest: $crest, ')
          ..write('venue: $venue, ')
          ..write('founded: $founded, ')
          ..write('clubColors: $clubColors, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    shortName,
    tla,
    crest,
    venue,
    founded,
    clubColors,
    addedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteTeam &&
          other.id == this.id &&
          other.name == this.name &&
          other.shortName == this.shortName &&
          other.tla == this.tla &&
          other.crest == this.crest &&
          other.venue == this.venue &&
          other.founded == this.founded &&
          other.clubColors == this.clubColors &&
          other.addedAt == this.addedAt);
}

class FavoriteTeamsCompanion extends UpdateCompanion<FavoriteTeam> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> shortName;
  final Value<String> tla;
  final Value<String> crest;
  final Value<String?> venue;
  final Value<int?> founded;
  final Value<String?> clubColors;
  final Value<DateTime> addedAt;
  const FavoriteTeamsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.shortName = const Value.absent(),
    this.tla = const Value.absent(),
    this.crest = const Value.absent(),
    this.venue = const Value.absent(),
    this.founded = const Value.absent(),
    this.clubColors = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  FavoriteTeamsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String shortName,
    required String tla,
    required String crest,
    this.venue = const Value.absent(),
    this.founded = const Value.absent(),
    this.clubColors = const Value.absent(),
    this.addedAt = const Value.absent(),
  }) : name = Value(name),
       shortName = Value(shortName),
       tla = Value(tla),
       crest = Value(crest);
  static Insertable<FavoriteTeam> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? shortName,
    Expression<String>? tla,
    Expression<String>? crest,
    Expression<String>? venue,
    Expression<int>? founded,
    Expression<String>? clubColors,
    Expression<DateTime>? addedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (shortName != null) 'short_name': shortName,
      if (tla != null) 'tla': tla,
      if (crest != null) 'crest': crest,
      if (venue != null) 'venue': venue,
      if (founded != null) 'founded': founded,
      if (clubColors != null) 'club_colors': clubColors,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  FavoriteTeamsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? shortName,
    Value<String>? tla,
    Value<String>? crest,
    Value<String?>? venue,
    Value<int?>? founded,
    Value<String?>? clubColors,
    Value<DateTime>? addedAt,
  }) {
    return FavoriteTeamsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      tla: tla ?? this.tla,
      crest: crest ?? this.crest,
      venue: venue ?? this.venue,
      founded: founded ?? this.founded,
      clubColors: clubColors ?? this.clubColors,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (shortName.present) {
      map['short_name'] = Variable<String>(shortName.value);
    }
    if (tla.present) {
      map['tla'] = Variable<String>(tla.value);
    }
    if (crest.present) {
      map['crest'] = Variable<String>(crest.value);
    }
    if (venue.present) {
      map['venue'] = Variable<String>(venue.value);
    }
    if (founded.present) {
      map['founded'] = Variable<int>(founded.value);
    }
    if (clubColors.present) {
      map['club_colors'] = Variable<String>(clubColors.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteTeamsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shortName: $shortName, ')
          ..write('tla: $tla, ')
          ..write('crest: $crest, ')
          ..write('venue: $venue, ')
          ..write('founded: $founded, ')
          ..write('clubColors: $clubColors, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoriteTeamsTable favoriteTeams = $FavoriteTeamsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favoriteTeams];
}

typedef $$FavoriteTeamsTableCreateCompanionBuilder =
    FavoriteTeamsCompanion Function({
      Value<int> id,
      required String name,
      required String shortName,
      required String tla,
      required String crest,
      Value<String?> venue,
      Value<int?> founded,
      Value<String?> clubColors,
      Value<DateTime> addedAt,
    });
typedef $$FavoriteTeamsTableUpdateCompanionBuilder =
    FavoriteTeamsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> shortName,
      Value<String> tla,
      Value<String> crest,
      Value<String?> venue,
      Value<int?> founded,
      Value<String?> clubColors,
      Value<DateTime> addedAt,
    });

class $$FavoriteTeamsTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteTeamsTable> {
  $$FavoriteTeamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shortName => $composableBuilder(
    column: $table.shortName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tla => $composableBuilder(
    column: $table.tla,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get crest => $composableBuilder(
    column: $table.crest,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venue => $composableBuilder(
    column: $table.venue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get founded => $composableBuilder(
    column: $table.founded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clubColors => $composableBuilder(
    column: $table.clubColors,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteTeamsTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteTeamsTable> {
  $$FavoriteTeamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shortName => $composableBuilder(
    column: $table.shortName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tla => $composableBuilder(
    column: $table.tla,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get crest => $composableBuilder(
    column: $table.crest,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venue => $composableBuilder(
    column: $table.venue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get founded => $composableBuilder(
    column: $table.founded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clubColors => $composableBuilder(
    column: $table.clubColors,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteTeamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteTeamsTable> {
  $$FavoriteTeamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get shortName =>
      $composableBuilder(column: $table.shortName, builder: (column) => column);

  GeneratedColumn<String> get tla =>
      $composableBuilder(column: $table.tla, builder: (column) => column);

  GeneratedColumn<String> get crest =>
      $composableBuilder(column: $table.crest, builder: (column) => column);

  GeneratedColumn<String> get venue =>
      $composableBuilder(column: $table.venue, builder: (column) => column);

  GeneratedColumn<int> get founded =>
      $composableBuilder(column: $table.founded, builder: (column) => column);

  GeneratedColumn<String> get clubColors => $composableBuilder(
    column: $table.clubColors,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);
}

class $$FavoriteTeamsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoriteTeamsTable,
          FavoriteTeam,
          $$FavoriteTeamsTableFilterComposer,
          $$FavoriteTeamsTableOrderingComposer,
          $$FavoriteTeamsTableAnnotationComposer,
          $$FavoriteTeamsTableCreateCompanionBuilder,
          $$FavoriteTeamsTableUpdateCompanionBuilder,
          (
            FavoriteTeam,
            BaseReferences<_$AppDatabase, $FavoriteTeamsTable, FavoriteTeam>,
          ),
          FavoriteTeam,
          PrefetchHooks Function()
        > {
  $$FavoriteTeamsTableTableManager(_$AppDatabase db, $FavoriteTeamsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteTeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteTeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteTeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> shortName = const Value.absent(),
                Value<String> tla = const Value.absent(),
                Value<String> crest = const Value.absent(),
                Value<String?> venue = const Value.absent(),
                Value<int?> founded = const Value.absent(),
                Value<String?> clubColors = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
              }) => FavoriteTeamsCompanion(
                id: id,
                name: name,
                shortName: shortName,
                tla: tla,
                crest: crest,
                venue: venue,
                founded: founded,
                clubColors: clubColors,
                addedAt: addedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String shortName,
                required String tla,
                required String crest,
                Value<String?> venue = const Value.absent(),
                Value<int?> founded = const Value.absent(),
                Value<String?> clubColors = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
              }) => FavoriteTeamsCompanion.insert(
                id: id,
                name: name,
                shortName: shortName,
                tla: tla,
                crest: crest,
                venue: venue,
                founded: founded,
                clubColors: clubColors,
                addedAt: addedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteTeamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoriteTeamsTable,
      FavoriteTeam,
      $$FavoriteTeamsTableFilterComposer,
      $$FavoriteTeamsTableOrderingComposer,
      $$FavoriteTeamsTableAnnotationComposer,
      $$FavoriteTeamsTableCreateCompanionBuilder,
      $$FavoriteTeamsTableUpdateCompanionBuilder,
      (
        FavoriteTeam,
        BaseReferences<_$AppDatabase, $FavoriteTeamsTable, FavoriteTeam>,
      ),
      FavoriteTeam,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoriteTeamsTableTableManager get favoriteTeams =>
      $$FavoriteTeamsTableTableManager(_db, _db.favoriteTeams);
}

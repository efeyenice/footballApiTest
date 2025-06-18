import 'package:drift/drift.dart';

class FavoriteTeams extends Table {
  IntColumn get id => integer().named('id')();
  TextColumn get name => text().named('name')();
  TextColumn get shortName => text().named('short_name')();
  TextColumn get tla => text().named('tla')();
  TextColumn get crest => text().named('crest')();
  TextColumn get venue => text().nullable().named('venue')();
  IntColumn get founded => integer().nullable().named('founded')();
  TextColumn get clubColors => text().nullable().named('club_colors')();
  DateTimeColumn get addedAt =>
      dateTime().named('added_at').withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

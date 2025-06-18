import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';

import 'favorite_team.dart';
import '../models/team.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [FavoriteTeams])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Get all favorite teams
  Future<List<FavoriteTeam>> getAllFavoriteTeams() async {
    return select(favoriteTeams).get();
  }

  /// Add a team to favorites
  Future<int> addFavoriteTeam(Team team) async {
    return into(favoriteTeams).insert(FavoriteTeamsCompanion(
      id: Value(team.id),
      name: Value(team.name),
      shortName: Value(team.shortName),
      tla: Value(team.tla),
      crest: Value(team.crest),
      venue: Value(team.venue),
      founded: Value(team.founded),
      clubColors: Value(team.clubColors),
    ));
  }

  /// Remove a team from favorites
  Future<int> removeFavoriteTeam(int teamId) async {
    return (delete(favoriteTeams)..where((t) => t.id.equals(teamId))).go();
  }

  /// Check if a team is in favorites
  Future<bool> isTeamFavorite(int teamId) async {
    final query = select(favoriteTeams)..where((t) => t.id.equals(teamId));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  /// Toggle favorite status for a team
  Future<bool> toggleFavoriteTeam(Team team) async {
    final isFavorite = await isTeamFavorite(team.id);
    if (isFavorite) {
      await removeFavoriteTeam(team.id);
      return false;
    } else {
      await addFavoriteTeam(team);
      return true;
    }
  }

  /// Get count of favorite teams
  Future<int> getFavoriteTeamsCount() async {
    final count = countAll();
    final query = selectOnly(favoriteTeams)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'football_app.db'));

    // Make sure sqlite3 works
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
} 
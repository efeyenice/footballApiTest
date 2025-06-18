import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/team.dart';
import '../models/area.dart';
import '../database/app_database.dart';
import 'app_providers.dart';

part 'favorites_providers.g.dart';

/// Provider that gets all favorite teams from the database
@riverpod
Future<List<FavoriteTeam>> favoriteTeams(ref) async {
  final database = ref.watch(appDatabaseProvider);
  return database.getAllFavoriteTeams();
}

/// Provider that converts favorite teams to Team objects for UI
@riverpod
Future<List<Team>> favoriteTeamsAsTeams(ref) async {
  final favoriteTeams = await ref.watch(favoriteTeamsProvider.future);
  return favoriteTeams.map((favoriteTeam) => Team(
    id: favoriteTeam.id,
    name: favoriteTeam.name,
    shortName: favoriteTeam.shortName,
    tla: favoriteTeam.tla,
    crest: favoriteTeam.crest,
    address: null, // Not stored in favorites
    website: null, // Not stored in favorites
    founded: favoriteTeam.founded,
    clubColors: favoriteTeam.clubColors,
    venue: favoriteTeam.venue,
    area: const Area( // Default area - not stored in favorites
      id: 0,
      name: 'Unknown',
      code: 'UNK',
      flag: '',
    ),
    runningCompetitions: [], // Not applicable for favorites
    lastUpdated: DateTime.now().toIso8601String(),
  )).toList();
}

/// Provider that checks if a specific team is favorite
@riverpod
Future<bool> isTeamFavorite(ref, int teamId) async {
  final database = ref.watch(appDatabaseProvider);
  return database.isTeamFavorite(teamId);
}

/// Provider that gets the count of favorite teams
@riverpod
Future<int> favoriteTeamsCount(ref) async {
  final database = ref.watch(appDatabaseProvider);
  return database.getFavoriteTeamsCount();
}

/// Notifier for managing favorite teams state
@riverpod
class FavoritesNotifier extends _$FavoritesNotifier {
  @override
  Future<List<FavoriteTeam>> build() async {
    final database = ref.watch(appDatabaseProvider);
    return database.getAllFavoriteTeams();
  }

  /// Toggle favorite status for a team
  Future<void> toggleFavorite(Team team) async {
    final database = ref.read(appDatabaseProvider);
    await database.toggleFavoriteTeam(team);

    // Refresh the favorites list
    ref.invalidateSelf();

    // Also refresh related providers
    ref.invalidate(isTeamFavoriteProvider(team.id));
    ref.invalidate(favoriteTeamsCountProvider);
    ref.invalidate(favoriteTeamsAsTeamsProvider);
  }

  /// Add team to favorites
  Future<void> addFavorite(Team team) async {
    final database = ref.read(appDatabaseProvider);
    await database.addFavoriteTeam(team);

    // Refresh providers
    ref.invalidateSelf();
    ref.invalidate(isTeamFavoriteProvider(team.id));
    ref.invalidate(favoriteTeamsCountProvider);
    ref.invalidate(favoriteTeamsAsTeamsProvider);
  }

  /// Remove team from favorites
  Future<void> removeFavorite(int teamId) async {
    final database = ref.read(appDatabaseProvider);
    await database.removeFavoriteTeam(teamId);

    // Refresh providers
    ref.invalidateSelf();
    ref.invalidate(isTeamFavoriteProvider(teamId));
    ref.invalidate(favoriteTeamsCountProvider);
    ref.invalidate(favoriteTeamsAsTeamsProvider);
  }
}

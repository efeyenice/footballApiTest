import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/team.dart';
import '../database/app_database.dart';
import 'app_providers.dart';

part 'favorites_providers.g.dart';

/// Provider that gets all favorite teams from the database
@riverpod
Future<List<FavoriteTeam>> favoriteTeams(FavoriteTeamsRef ref) async {
  final database = ref.watch(appDatabaseProvider);
  return database.getAllFavoriteTeams();
}

/// Provider that checks if a specific team is favorite
@riverpod
Future<bool> isTeamFavorite(IsTeamFavoriteRef ref, int teamId) async {
  final database = ref.watch(appDatabaseProvider);
  return database.isTeamFavorite(teamId);
}

/// Provider that gets the count of favorite teams
@riverpod
Future<int> favoriteTeamsCount(FavoriteTeamsCountRef ref) async {
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
  }

  /// Add team to favorites
  Future<void> addFavorite(Team team) async {
    final database = ref.read(appDatabaseProvider);
    await database.addFavoriteTeam(team);
    
    // Refresh providers
    ref.invalidateSelf();
    ref.invalidate(isTeamFavoriteProvider(team.id));
    ref.invalidate(favoriteTeamsCountProvider);
  }

  /// Remove team from favorites
  Future<void> removeFavorite(int teamId) async {
    final database = ref.read(appDatabaseProvider);
    await database.removeFavoriteTeam(teamId);
    
    // Refresh providers
    ref.invalidateSelf();
    ref.invalidate(isTeamFavoriteProvider(teamId));
    ref.invalidate(favoriteTeamsCountProvider);
  }
} 
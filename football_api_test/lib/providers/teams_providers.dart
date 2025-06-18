import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/team.dart';
import '../models/match.dart';
import '../services/football_api_service.dart';
import 'app_providers.dart';

part 'teams_providers.g.dart';

/// Provider that fetches all Premier League teams
@riverpod
Future<List<Team>> premierLeagueTeams(PremierLeagueTeamsRef ref) async {
  final apiService = ref.watch(footballApiServiceProvider);
  return apiService.getPremierLeagueTeams();
}

/// Provider that gets a specific team by ID
@riverpod
Future<Team> teamById(TeamByIdRef ref, int teamId) async {
  final apiService = ref.watch(footballApiServiceProvider);
  return apiService.getTeamById(teamId);
}

/// Provider that gets upcoming matches for a team
@riverpod
Future<List<Match>> teamUpcomingMatches(TeamUpcomingMatchesRef ref, int teamId) async {
  final apiService = ref.watch(footballApiServiceProvider);
  return apiService.getTeamUpcomingMatches(teamId);
}

/// Provider that gets finished matches for a team
@riverpod
Future<List<Match>> teamFinishedMatches(TeamFinishedMatchesRef ref, int teamId) async {
  final apiService = ref.watch(footballApiServiceProvider);
  return apiService.getTeamFinishedMatches(teamId);
}

/// Provider that gets the number of matches played for a team
@riverpod
Future<int> teamMatchesPlayed(TeamMatchesPlayedRef ref, int teamId) async {
  final apiService = ref.watch(footballApiServiceProvider);
  return apiService.getTeamMatchesPlayed(teamId);
} 
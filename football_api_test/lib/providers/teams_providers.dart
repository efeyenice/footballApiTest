import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/team.dart';
import '../models/match.dart';
import 'app_providers.dart';

part 'teams_providers.g.dart';

/// Provider that fetches all Premier League teams
@riverpod
Future<List<Team>> premierLeagueTeams(ref) async {
  final apiService = ref.watch(footballApiServiceProvider);
  return apiService.getPremierLeagueTeams();
}

/// Provider that gets a specific team by ID
@riverpod
Future<Team> teamById(ref, int teamId) async {
  final apiService = ref.watch(footballApiServiceProvider);
  return apiService.getTeamById(teamId);
}

/// Provider that gets upcoming matches for a team
@riverpod
Future<List<Match>> teamUpcomingMatches(ref, int teamId) async {
  final apiService = ref.watch(footballApiServiceProvider);
  return apiService.getTeamUpcomingMatches(teamId);
}

/// Provider that gets finished matches for a team
@riverpod
Future<List<Match>> teamFinishedMatches(ref, int teamId) async {
  final apiService = ref.watch(footballApiServiceProvider);
  return apiService.getTeamFinishedMatches(teamId);
}

/// Provider that gets the number of matches played for a team
@riverpod
Future<int> teamMatchesPlayed(ref, int teamId) async {
  final apiService = ref.watch(footballApiServiceProvider);
  return apiService.getTeamMatchesPlayed(teamId);
}

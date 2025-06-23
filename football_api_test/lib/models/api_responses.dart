import 'team.dart';
import 'match.dart';

/// Simplified response wrapper for teams API call
class TeamsResponse {
  final int count;
  final List<Team> teams;

  const TeamsResponse({
    required this.count,
    required this.teams,
  });

  /// Parse teams from API response
  factory TeamsResponse.fromJson(Map<String, dynamic> json) {
    final teamsJson = json['teams'] as List<dynamic>;
    final teams = teamsJson
        .map((teamJson) => Team.fromJson(teamJson as Map<String, dynamic>))
        .toList();

    return TeamsResponse(
      count: json['count'] as int? ?? teams.length,
      teams: teams,
    );
}
}

/// Simplified response wrapper for matches API call
class MatchesResponse {
  final List<Match> matches;

  const MatchesResponse({required this.matches});

  /// Parse matches from API response
  factory MatchesResponse.fromJson(Map<String, dynamic> json) {
    final matchesJson = json['matches'] as List<dynamic>;
    final matches = matchesJson
        .map((matchJson) => Match.fromJson(matchJson as Map<String, dynamic>))
        .toList();

    return MatchesResponse(matches: matches);
  }
}

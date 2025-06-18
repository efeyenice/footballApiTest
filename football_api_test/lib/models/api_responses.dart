import 'package:json_annotation/json_annotation.dart';
import 'team.dart';
import 'match.dart';
import 'competition.dart';
import 'season.dart';

part 'api_responses.g.dart';

@JsonSerializable()
class TeamsResponse {
  final int count;
  final Competition competition;
  final Season season;
  final List<Team> teams;

  const TeamsResponse({
    required this.count,
    required this.competition,
    required this.season,
    required this.teams,
  });

  factory TeamsResponse.fromJson(Map<String, dynamic> json) =>
      _$TeamsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TeamsResponseToJson(this);
}

@JsonSerializable()
class MatchesResponse {
  final List<Match> matches;

  const MatchesResponse({required this.matches});

  factory MatchesResponse.fromJson(Map<String, dynamic> json) =>
      _$MatchesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MatchesResponseToJson(this);
}

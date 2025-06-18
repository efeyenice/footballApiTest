import 'package:json_annotation/json_annotation.dart';
import 'area.dart';
import 'competition.dart';
import 'season.dart';
import 'team_summary.dart';
import 'score.dart';

part 'match.g.dart';

@JsonSerializable()
class Match {
  final int id;
  final String utcDate;
  final String status;
  final int? matchday;
  final String stage;
  final String? group;
  final String lastUpdated;
  final Area area;
  final Competition competition;
  final Season season;
  final TeamSummary homeTeam;
  final TeamSummary awayTeam;
  final Score score;

  const Match({
    required this.id,
    required this.utcDate,
    required this.status,
    this.matchday,
    required this.stage,
    this.group,
    required this.lastUpdated,
    required this.area,
    required this.competition,
    required this.season,
    required this.homeTeam,
    required this.awayTeam,
    required this.score,
  });

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);
  Map<String, dynamic> toJson() => _$MatchToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Match && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Match(id: $id, ${homeTeam.shortName} vs ${awayTeam.shortName}, $status)';

  /// Helper method to get formatted date
  DateTime get dateTime => DateTime.parse(utcDate);

  /// Helper method to check if match is upcoming
  bool get isUpcoming => ['SCHEDULED', 'TIMED'].contains(status);

  /// Helper method to check if match is finished
  bool get isFinished => status == 'FINISHED';

  /// Helper method to check if match is live
  bool get isLive => ['IN_PLAY', 'PAUSED', 'HALF_TIME'].contains(status);
}

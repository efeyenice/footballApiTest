// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Match _$MatchFromJson(Map<String, dynamic> json) => Match(
  id: (json['id'] as num).toInt(),
  utcDate: json['utcDate'] as String,
  status: json['status'] as String,
  matchday: (json['matchday'] as num?)?.toInt(),
  stage: json['stage'] as String,
  group: json['group'] as String?,
  lastUpdated: json['lastUpdated'] as String,
  area: Area.fromJson(json['area'] as Map<String, dynamic>),
  competition: Competition.fromJson(
    json['competition'] as Map<String, dynamic>,
  ),
  season: Season.fromJson(json['season'] as Map<String, dynamic>),
  homeTeam: TeamSummary.fromJson(json['homeTeam'] as Map<String, dynamic>),
  awayTeam: TeamSummary.fromJson(json['awayTeam'] as Map<String, dynamic>),
  score: Score.fromJson(json['score'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
  'id': instance.id,
  'utcDate': instance.utcDate,
  'status': instance.status,
  'matchday': instance.matchday,
  'stage': instance.stage,
  'group': instance.group,
  'lastUpdated': instance.lastUpdated,
  'area': instance.area,
  'competition': instance.competition,
  'season': instance.season,
  'homeTeam': instance.homeTeam,
  'awayTeam': instance.awayTeam,
  'score': instance.score,
};

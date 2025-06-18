// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamsResponse _$TeamsResponseFromJson(Map<String, dynamic> json) =>
    TeamsResponse(
      count: (json['count'] as num).toInt(),
      competition: Competition.fromJson(
        json['competition'] as Map<String, dynamic>,
      ),
      season: Season.fromJson(json['season'] as Map<String, dynamic>),
      teams: (json['teams'] as List<dynamic>)
          .map((e) => Team.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TeamsResponseToJson(TeamsResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'competition': instance.competition,
      'season': instance.season,
      'teams': instance.teams,
    };

MatchesResponse _$MatchesResponseFromJson(Map<String, dynamic> json) =>
    MatchesResponse(
      matches: (json['matches'] as List<dynamic>)
          .map((e) => Match.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MatchesResponseToJson(MatchesResponse instance) =>
    <String, dynamic>{'matches': instance.matches};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreTime _$ScoreTimeFromJson(Map<String, dynamic> json) => ScoreTime(
  home: (json['home'] as num?)?.toInt(),
  away: (json['away'] as num?)?.toInt(),
);

Map<String, dynamic> _$ScoreTimeToJson(ScoreTime instance) => <String, dynamic>{
  'home': instance.home,
  'away': instance.away,
};

Score _$ScoreFromJson(Map<String, dynamic> json) => Score(
  winner: json['winner'] as String?,
  duration: json['duration'] as String,
  fullTime: ScoreTime.fromJson(json['fullTime'] as Map<String, dynamic>),
  halfTime: ScoreTime.fromJson(json['halfTime'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ScoreToJson(Score instance) => <String, dynamic>{
  'winner': instance.winner,
  'duration': instance.duration,
  'fullTime': instance.fullTime,
  'halfTime': instance.halfTime,
};

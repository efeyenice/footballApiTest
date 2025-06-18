// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
  id: (json['id'] as num).toInt(),
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String,
  currentMatchday: (json['currentMatchday'] as num?)?.toInt(),
  winner: json['winner'] as String?,
);

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
  'id': instance.id,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'currentMatchday': instance.currentMatchday,
  'winner': instance.winner,
};

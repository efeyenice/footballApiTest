// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamSummary _$TeamSummaryFromJson(Map<String, dynamic> json) => TeamSummary(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  shortName: json['shortName'] as String,
  tla: json['tla'] as String,
  crest: json['crest'] as String,
);

Map<String, dynamic> _$TeamSummaryToJson(TeamSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortName': instance.shortName,
      'tla': instance.tla,
      'crest': instance.crest,
    };

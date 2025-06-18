// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  shortName: json['shortName'] as String,
  tla: json['tla'] as String,
  crest: json['crest'] as String,
  address: json['address'] as String?,
  website: json['website'] as String?,
  founded: (json['founded'] as num?)?.toInt(),
  clubColors: json['clubColors'] as String?,
  venue: json['venue'] as String?,
  area: Area.fromJson(json['area'] as Map<String, dynamic>),
  runningCompetitions: (json['runningCompetitions'] as List<dynamic>)
      .map((e) => Competition.fromJson(e as Map<String, dynamic>))
      .toList(),
  lastUpdated: json['lastUpdated'] as String,
);

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'shortName': instance.shortName,
  'tla': instance.tla,
  'crest': instance.crest,
  'address': instance.address,
  'website': instance.website,
  'founded': instance.founded,
  'clubColors': instance.clubColors,
  'venue': instance.venue,
  'area': instance.area,
  'runningCompetitions': instance.runningCompetitions,
  'lastUpdated': instance.lastUpdated,
};

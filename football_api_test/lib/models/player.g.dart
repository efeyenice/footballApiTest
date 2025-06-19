// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  position: json['position'] as String,
  dateOfBirth: json['dateOfBirth'] as String?,
  nationality: json['nationality'] as String?,
);

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'position': instance.position,
  'dateOfBirth': instance.dateOfBirth,
  'nationality': instance.nationality,
};

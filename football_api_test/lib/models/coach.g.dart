// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coach.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coach _$CoachFromJson(Map<String, dynamic> json) => Coach(
  id: (json['id'] as num?)?.toInt(),
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  name: json['name'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  nationality: json['nationality'] as String?,
  contract: json['contract'] == null
      ? null
      : Contract.fromJson(json['contract'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CoachToJson(Coach instance) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'name': instance.name,
  'dateOfBirth': instance.dateOfBirth,
  'nationality': instance.nationality,
  'contract': instance.contract,
};

Contract _$ContractFromJson(Map<String, dynamic> json) =>
    Contract(start: json['start'] as String?, until: json['until'] as String?);

Map<String, dynamic> _$ContractToJson(Contract instance) => <String, dynamic>{
  'start': instance.start,
  'until': instance.until,
};

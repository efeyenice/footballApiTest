import 'package:json_annotation/json_annotation.dart';

part 'coach.g.dart';

@JsonSerializable()
class Coach {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? name;
  final String? dateOfBirth;
  final String? nationality;
  final Contract? contract;

  const Coach({
    this.id,
    this.firstName,
    this.lastName,
    this.name,
    this.dateOfBirth,
    this.nationality,
    this.contract,
  });

  factory Coach.fromJson(Map<String, dynamic> json) => _$CoachFromJson(json);
  Map<String, dynamic> toJson() => _$CoachToJson(this);
}

@JsonSerializable()
class Contract {
  final String? start;
  final String? until;

  const Contract({
    this.start,
    this.until,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => _$ContractFromJson(json);
  Map<String, dynamic> toJson() => _$ContractToJson(this);
} 
import 'package:json_annotation/json_annotation.dart';

part 'team_summary.g.dart';

@JsonSerializable()
class TeamSummary {
  final int id;
  final String name;
  final String shortName;
  final String tla;
  final String crest;

  const TeamSummary({
    required this.id,
    required this.name,
    required this.shortName,
    required this.tla,
    required this.crest,
  });

  factory TeamSummary.fromJson(Map<String, dynamic> json) =>
      _$TeamSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$TeamSummaryToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamSummary &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'TeamSummary(id: $id, name: $name)';
} 
import 'package:json_annotation/json_annotation.dart';
import 'area.dart';
import 'competition.dart';

part 'team.g.dart';

@JsonSerializable()
class Team {
  final int id;
  final String name;
  final String shortName;
  final String tla;
  final String crest;
  final String? address;
  final String? website;
  final int? founded;
  final String? clubColors;
  final String? venue;
  final Area area;
  final List<Competition> runningCompetitions;
  final String lastUpdated;

  const Team({
    required this.id,
    required this.name,
    required this.shortName,
    required this.tla,
    required this.crest,
    this.address,
    this.website,
    this.founded,
    this.clubColors,
    this.venue,
    required this.area,
    required this.runningCompetitions,
    required this.lastUpdated,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Team && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Team(id: $id, name: $name, shortName: $shortName)';
} 
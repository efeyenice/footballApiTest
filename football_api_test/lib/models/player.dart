import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

@JsonSerializable()
class Player {
  final int id;
  final String name;
  final String position;
  final String? dateOfBirth;
  final String? nationality;

  const Player({
    required this.id,
    required this.name,
    required this.position,
    this.dateOfBirth,
    this.nationality,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
} 
import 'package:json_annotation/json_annotation.dart';

part 'competition.g.dart';

@JsonSerializable()
class Competition {
  final int id;
  final String name;
  final String code;
  final String type;
  final String? emblem;

  const Competition({
    required this.id,
    required this.name,
    required this.code,
    required this.type,
    this.emblem,
  });

  factory Competition.fromJson(Map<String, dynamic> json) =>
      _$CompetitionFromJson(json);
  Map<String, dynamic> toJson() => _$CompetitionToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Competition &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

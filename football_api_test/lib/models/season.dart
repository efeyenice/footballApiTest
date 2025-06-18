import 'package:json_annotation/json_annotation.dart';

part 'season.g.dart';

@JsonSerializable()
class Season {
  final int id;
  final String startDate;
  final String endDate;
  final int? currentMatchday;
  final String? winner;

  const Season({
    required this.id,
    required this.startDate,
    required this.endDate,
    this.currentMatchday,
    this.winner,
  });

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
  Map<String, dynamic> toJson() => _$SeasonToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Season && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

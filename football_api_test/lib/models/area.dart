import 'package:json_annotation/json_annotation.dart';

part 'area.g.dart';

@JsonSerializable()
class Area {
  final int id;
  final String name;
  final String code;
  final String flag;

  const Area({
    required this.id,
    required this.name,
    required this.code,
    required this.flag,
  });

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);
  Map<String, dynamic> toJson() => _$AreaToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Area && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

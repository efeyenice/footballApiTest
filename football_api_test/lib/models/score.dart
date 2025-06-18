import 'package:json_annotation/json_annotation.dart';

part 'score.g.dart';

@JsonSerializable()
class ScoreTime {
  final int? home;
  final int? away;

  const ScoreTime({
    this.home,
    this.away,
  });

  factory ScoreTime.fromJson(Map<String, dynamic> json) =>
      _$ScoreTimeFromJson(json);
  Map<String, dynamic> toJson() => _$ScoreTimeToJson(this);
}

@JsonSerializable()
class Score {
  final String? winner;
  final String duration;
  final ScoreTime fullTime;
  final ScoreTime halfTime;

  const Score({
    this.winner,
    required this.duration,
    required this.fullTime,
    required this.halfTime,
  });

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
  Map<String, dynamic> toJson() => _$ScoreToJson(this);

  @override
  String toString() => 
      'Score(winner: $winner, fullTime: ${fullTime.home}-${fullTime.away})';
} 